// services/soldeService.js
/**
 * Règles métier des congés :
 *  - Crédit : +2 jours par mois à partir du MOIS de `info_pro.dat_prise_fonction`
 *    (crédit idempotent : UNIQUE (matricule, annee, mois) dans `acquittement_cron`).
 *  - Débit  : UNIQUEMENT à l'acceptation totale (chef + directrice), FIFO sur les
 *    années les plus anciennes, sous verrouillage des lignes (FOR UPDATE).
 *  - Report : les jours non pris sont transférés au 1er janvier vers l'année
 *    suivante (contrepartie `jours_transferes` → pas de double comptage).
 *  - Plafond : aucun. Aucun maximum de jours.
 */
const { Op } = require('sequelize');
const sequelize = require('../db');
const Dossier = require('../models/dossier');
const InfoPro = require('../models/infoPro');
const SoldeConge = require('../models/soldeConge');
const AcquittementCron = require('../models/acquittementCron');
const AuditConge = require('../models/auditConge');

const JOURS_PAR_MOIS = 2;

class SoldeInsuffisantError extends Error {
  constructor(demande, disponible) {
    super(
      `Solde insuffisant : ${demande} jour(s) demande(s), ${disponible} jour(s) disponible(s).`
    );
    this.name = 'SoldeInsuffisantError';
    this.demande = demande;
    this.disponible = disponible;
  }
}

/** Disponible d'une ligne de solde (année). */
const disponibleLigne = (row) =>
  row.jours_acquis + row.jours_reportes - row.jours_consommes - row.jours_transferes;

const debutMois = (d) => new Date(d.getFullYear(), d.getMonth(), 1);

/**
 * Crédite (idempotent) tous les mois échus depuis `dat_prise_fonction` jusqu'à
 * `jusquAu`. Appelé à la création du dossier, puis par le cron mensuel.
 */
async function crediterJusqua(matricule, jusquAu = new Date(), { transaction, auteur = 'SYSTEM' } = {}) {
  const dossier = await Dossier.findOne({
    where: { matricule },
    include: [{ model: InfoPro, attributes: ['dat_prise_fonction'] }],
    transaction,
  });
  if (!dossier || !dossier.InfoPro || !dossier.InfoPro.dat_prise_fonction) {
    return { credite: 0, motif: 'dossier ou date de prise de fonction absente' };
  }

  const debut = debutMois(new Date(dossier.InfoPro.dat_prise_fonction));
  const fin = debutMois(new Date(jusquAu));
  if (fin < debut) return { credite: 0, motif: 'prise de fonction future' };

  let credite = 0;
  for (let d = new Date(debut); d <= fin; d.setMonth(d.getMonth() + 1)) {
    credite += await crediterMois(matricule, d.getFullYear(), d.getMonth() + 1, { transaction, auteur });
  }
  return { credite };
}

/** Crédite un mois précis s'il n'a pas encore été acrédité. Retourne 0 ou 2. */
async function crediterMois(matricule, annee, mois, { transaction, auteur = 'SYSTEM' } = {}) {
  const [, cree] = await AcquittementCron.findOrCreate({
    where: { matricule, annee, mois },
    transaction,
  });
  if (!cree) return 0; // mois déjà crédité (cron relancé, double appel…)

  const [solde] = await SoldeConge.findOrCreate({
    where: { matricule, annee },
    defaults: { jours_acquis: 0, jours_consommes: 0 },
    transaction,
  });
  await SoldeConge.update(
    { jours_acquis: sequelize.literal(`jours_acquis + ${JOURS_PAR_MOIS}`) },
    { where: { id_solde: solde.id_solde }, transaction }
  );
  await AuditConge.create(
    {
      matricule,
      action: 'CREDIT_MENSUEL',
      details: `+${JOURS_PAR_MOIS} jours credites pour ${String(mois).padStart(2, '0')}/${annee}`,
      auteur_matricule: auteur,
    },
    { transaction }
  );
  return JOURS_PAR_MOIS;
}

/** Résumé du solde : détail par année + total disponible. */
async function soldeResume(matricule, { transaction, lock = false } = {}) {
  const rows = await SoldeConge.findAll({
    where: { matricule },
    order: [['annee', 'ASC']],
    transaction,
    lock: lock && transaction ? transaction.LOCK.UPDATE : undefined,
  });
  const detail = rows.map((r) => ({
    annee: r.annee,
    jours_acquis: r.jours_acquis,
    jours_reportes: r.jours_reportes,
    jours_consommes: r.jours_consommes,
    jours_transferes: r.jours_transferes,
    disponible: disponibleLigne(r),
  }));
  const total = detail.reduce((s, d) => s + d.disponible, 0);
  return { detail, total };
}

/**
 * Débite `jours` sur le solde de l'agent, FIFO (années les plus anciennes
 * d'abord), lignes verrouillées. Lance SoldeInsuffisantError si le total est
 * insuffisant — aucune écriture n'est alors conservée (rollback de la tx).
 */
async function debiterSolde(matricule, jours, { transaction, auteur, id_cong = null } = {}) {
  if (!transaction) throw new Error('debiterSolde exige une transaction');
  const rows = await SoldeConge.findAll({
    where: { matricule },
    order: [['annee', 'ASC']],
    transaction,
    lock: transaction.LOCK.UPDATE,
  });
  const total = rows.reduce((s, r) => s + disponibleLigne(r), 0);
  if (total < jours) throw new SoldeInsuffisantError(jours, total);

  let restant = jours;
  const ventilation = [];
  for (const row of rows) {
    if (restant <= 0) break;
    const dispo = disponibleLigne(row);
    if (dispo <= 0) continue;
    const prise = Math.min(dispo, restant);
    row.jours_consommes += prise;
    await row.save({ transaction });
    restant -= prise;
    ventilation.push(`${row.annee}:${prise}`);
  }
  if (auteur || id_cong) {
    await AuditConge.create(
      {
        id_cong,
        matricule,
        action: 'DECISION_DIRECTRICE',
        details: `Debit de ${jours} jour(s) [${ventilation.join(', ')}] par ${auteur || 'SYSTEM'}`,
        auteur_matricule: auteur,
      },
      { transaction }
    );
  }
  return { total_avant: total, ventilation: ventilation.join(', ') };
}

/**
 * Report annuel : le solde restant de `anneeSource` est transféré vers
 * `anneeSource + 1`. Idempotent (relance sans effet si déjà reporté).
 */
async function reporterAnnee(anneeSource, { auteur = 'SYSTEM' } = {}) {
  const anneeCible = anneeSource + 1;
  const transaction = await sequelize.transaction();
  try {
    const sources = await SoldeConge.findAll({
      where: { annee: anneeSource },
      order: [['matricule', 'ASC']],
      transaction,
      lock: transaction.LOCK.UPDATE,
    });
    let rapports = 0;
    for (const src of sources) {
      const restant = disponibleLigne(src);
      if (restant <= 0) continue;
      const [cible] = await SoldeConge.findOrCreate({
        where: { matricule: src.matricule, annee: anneeCible },
        defaults: {},
        transaction,
      });
      cible.jours_reportes += restant;
      await cible.save({ transaction });
      src.jours_transferes += restant;
      await src.save({ transaction });
      await AuditConge.create(
        {
          matricule: src.matricule,
          action: 'REPORT_ANNUEL',
          details: `${restant} jour(s) reporte(s) de ${anneeSource} vers ${anneeCible}`,
          auteur_matricule: auteur,
        },
        { transaction }
      );
      rapports += 1;
    }
    await transaction.commit();
    return { rapports };
  } catch (err) {
    await transaction.rollback();
    throw err;
  }
}

/** Crédit de tous les dossiers actifs (appel mensuel du cron, rattrapage inclus). */
async function crediterTousLesAgents({ jusquAu = new Date(), auteur = 'CRON' } = {}) {
  const dossiers = await Dossier.findAll({ attributes: ['matricule'] });
  let joursCredites = 0;
  const erreurs = [];
  for (const d of dossiers) {
    const t = await sequelize.transaction();
    try {
      const r = await crediterJusqua(d.matricule, jusquAu, { transaction: t, auteur });
      await t.commit();
      joursCredites += r.credite;
    } catch (err) {
      await t.rollback();
      erreurs.push(`${d.matricule} : ${err.message}`);
    }
  }
  return { agents: dossiers.length, joursCredites, erreurs };
}

module.exports = {
  JOURS_PAR_MOIS,
  SoldeInsuffisantError,
  disponibleLigne,
  crediterJusqua,
  crediterMois,
  soldeResume,
  debiterSolde,
  reporterAnnee,
  crediterTousLesAgents,
};
