// controllers/presenceController.js — fiches de présence (pointage quotidien)
//
// Historique : le module avait été « mis en pause ». En le réactivant, trois
// défauts ont été corrigés :
//   - getAllPresences faisait une jointure en mémoire (et crashait sur une
//     variable `demande` copiée d'un autre contrôleur) : on laisse Sequelize
//     joindre dossier → info_ident ;
//   - les listes retournées ne suivaient pas la convention { data, meta } du
//     reste de l'API (cf. controllers/dossier/part2.js) ;
//   - l'upsert partait en Promise.all sans transaction : une erreur en milieu
//     de lot laissait la journée à moitié enregistrée. Désormais tout le lot
//     réussit ou échoue ensemble.
const sequelize = require('../db');
const { FichePresence, Dossier, InfoIdent } = require('../models/association');
const { getIo } = require('../utils/socket');

// Les six statuts du modèle — rejeter tôt une valeur inconnue évite une
// erreur Sequelize cryptique au milieu de la transaction.
const STATUTS = ['Présent', 'Absent', 'Retard', 'Permission', 'Congé', 'Maladie'];

/** include commun : nom/prenom de l'agent, joints côté SQL. */
const AVEC_AGENT = [
  {
    model: Dossier,
    attributes: ['matricule'],
    include: [{ model: InfoIdent, attributes: ['nom', 'prenom'] }],
  },
];

/** Aplatit { Dossier: { InfoIdent } } → { nom, prenom }. */
const aplatirAgent = (fiche) => {
  const { Dossier: dossier, ...reste } = fiche.dataValues;
  return {
    ...reste,
    nom: dossier?.InfoIdent?.nom ?? null,
    prenom: dossier?.InfoIdent?.prenom ?? null,
  };
};

/** Normalise une fiche venue du front. Lève une Error si elle est invalide. */
const normaliserFiche = (fiche) => {
  const matricule = typeof fiche?.matricule === 'string' ? fiche.matricule.trim() : '';
  const date_presence = fiche?.date_presence;
  if (!matricule || !date_presence) {
    throw new Error('Le matricule et la date sont requis pour chaque fiche de présence.');
  }
  if (!STATUTS.includes(fiche?.statut)) {
    throw new Error(`Statut invalide pour ${matricule} : « ${fiche?.statut} » (valeurs acceptées : ${STATUTS.join(', ')}).`);
  }
  // Heure vide -> null : une fiche « Absent » sans heure est normale, pas « 00:00 ».
  const heure = (v) => (typeof v === 'string' && v.trim() ? v.trim() : null);
  return {
    matricule,
    date_presence,
    statut: fiche.statut,
    heure_arrivee: heure(fiche.heure_arrivee),
    heure_depart: heure(fiche.heure_depart),
    observations: typeof fiche.observations === 'string' && fiche.observations.trim()
      ? fiche.observations.trim()
      : null,
  };
};

/** Pagination bornée, identique à celle des dossiers. */
const pagination = (req, defaut = 100, max = 500) => {
  const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
  const limit = Math.min(Math.max(parseInt(req.query.limit, 10) || defaut, 1), max);
  return { page, limit, offset: (page - 1) * limit };
};

// GET /api/presences — toutes les fiches (paginées), agent joints.
exports.getAllPresences = async (req, res) => {
  try {
    const { page, limit, offset } = pagination(req);
    const { rows, count } = await FichePresence.findAndCountAll({
      include: AVEC_AGENT,
      attributes: ['id', 'matricule', 'date_presence', 'heure_arrivee', 'heure_depart', 'statut', 'observations'],
      order: [['date_presence', 'DESC'], ['matricule', 'ASC']],
      limit,
      offset,
      distinct: true,
    });
    res.status(200).json({ data: rows.map(aplatirAgent), meta: { page, limit, total: count } });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération des présences : ' + error.message });
  }
};


// GET /api/presences/:date — les fiches d'une journée (200 + [] si aucune).
exports.getPresencesByDate = async (req, res) => {
  try {
    const { date } = req.params;
    if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) {
      return res.status(400).json({ error: 'Format de date invalide (attendu : aaaa-mm-jj).' });
    }
    const presences = await FichePresence.findAll({
      where: { date_presence: date },
      include: AVEC_AGENT,
      attributes: ['id', 'matricule', 'date_presence', 'heure_arrivee', 'heure_depart', 'statut', 'observations'],
      order: [['matricule', 'ASC']],
    });
    // Une journée sans pointage n'est pas une erreur : 200 + liste vide.
    res.status(200).json({ data: presences.map(aplatirAgent) });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération des présences : ' + error.message });
  }
};

// POST /api/presences — enregistre un lot de fiches (upsert transactionnel).
exports.savePresence = async (req, res) => {
  const { fiches } = req.body;
  if (!Array.isArray(fiches) || fiches.length === 0) {
    return res.status(400).json({ error: 'Aucune fiche de présence à enregistrer.' });
  }

  let normalisees;
  try {
    // Validation de tout le lot AVANT la transaction : une fiche invalide
    // refuse l'ensemble, on n'enregistre jamais un jour à moitié.
    normalisees = fiches.map(normaliserFiche);
  } catch (error) {
    return res.status(400).json({ error: error.message });
  }

  const t = await sequelize.transaction();
  try {
    const result = [];
    for (const fiche of normalisees) {
      const [ligne, creee] = await FichePresence.upsert(fiche, {
        transaction: t,
        // Une seule fiche par agent et par jour : le re-pointage corrige la
        // ligne existante au lieu d'en créer une seconde.
        returning: true,
        conflictFields: ['matricule', 'date_presence'],
      });
      result.push({ ...fiche, id: ligne?.id, action: creee ? 'créée' : 'mise à jour' });
    }
    await t.commit();

    // Socket best-effort : une notification qui échoue ne doit pas annuler
    // un enregistrement pourtant réussi.
    try {
      getIo().emit('receiveNotification', {
        message: `La fiche de présence du ${normalisees[0].date_presence} est enregistrée.`,
        user_id: 'Agent',
      });
    } catch (e) { /* socket optionnel */ }

    res.status(200).json({ message: 'Fiches de présence traitées', data: result });
  } catch (error) {
    await t.rollback();
    res.status(500).json({ error: "Erreur lors de l'enregistrement des présences : " + error.message });
  }
};

// Exporté pour les tests unitaires (presenceController.test.mjs).
exports.normaliserFiche = normaliserFiche;
exports.STATUTS = STATUTS;
