// controllers/dossier/part1.js — entête, helpers, création
const { Op } = require('sequelize');
const sequelize = require('../../db');
const { getIo } = require('../../utils/socket');
const {
  Dossier, InfoIdent, InfoPro, InfoBank, InfoComplementaire,
  Diplome, PosteAnterieur, Details, Sanction, Distinction,
  Utilisateur, DemandeConges, SoldeConge,
} = require('../../models/association');
const { crediterJusqua } = require('../../services/soldeService');

const peutToutVoir = (role) => ['admin', 'directrice'].includes(role);

const serviceDeChef = async (user, transaction) => {
  const dossier = await Dossier.findOne({
    where: { matricule: user.matricule },
    include: [{ model: InfoPro, attributes: ['poste_actuel_service'] }],
    transaction,
  });
  return (dossier && dossier.InfoPro && dossier.InfoPro.poste_actuel_service) || null;
};

const porteeDossier = async (req, transaction) => {
  const { role, matricule } = req.user;
  if (peutToutVoir(role)) return {};
  if (role === 'chef_service') {
    const service = await serviceDeChef(req.user, transaction);
    return service ? { '$InfoPro.poste_actuel_service$': service } : { matricule: '__aucun__' };
  }
  return { matricule };
};

const INCLUDE_DOSSIER = [
  { model: InfoIdent },
  { model: InfoPro },
  { model: InfoBank },
  { model: InfoComplementaire },
];

const pagination = (req, defaut = 20, max = 100) => {
  const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
  const limit = Math.min(Math.max(parseInt(req.query.limit, 10) || defaut, 1), max);
  return { page, limit, offset: (page - 1) * limit };
};

exports.creteDossier = async (req, res) => {
  const {
    matricule, infoIdent, infoPro, infoBank, infoComplementaire,
    detailsMutation, sanction, diplome, poste, distinction,
  } = req.body;
  if (!matricule || !infoIdent || !infoPro || !infoBank) {
    return res.status(400).json({ error: 'Champs requis : matricule, infoIdent, infoPro, infoBank.' });
  }
  const t = await sequelize.transaction();
  try {
    if (await Dossier.findOne({ where: { matricule }, transaction: t })) {
      await t.rollback();
      return res.status(409).json({ error: 'Un dossier existe déjà pour ce matricule.' });
    }
    const dossier = await Dossier.create({ matricule }, { transaction: t });
    await InfoIdent.create({ ...infoIdent, dossier_id: dossier.id_dossier }, { transaction: t });
    const pro = await InfoPro.create({ ...infoPro, dossier_id: dossier.id_dossier }, { transaction: t });
    await InfoBank.create({ ...infoBank, dossier_id: dossier.id_dossier }, { transaction: t });
    const comp = infoComplementaire
      ? await InfoComplementaire.create({ ...infoComplementaire, dossier_id: dossier.id_dossier }, { transaction: t })
      : await InfoComplementaire.create({ dossier_id: dossier.id_dossier }, { transaction: t });
    const d = detailsMutation || {};
    await Details.create({
      etat: d.etat || 'Actif',
      poste_actuel: d.poste_actuel || pro.fonctions || 'Neant',
      service_actuel: d.service_actuel || pro.poste_actuel_service || 'Neant',
      nouveau_poste: d.nouveau_poste || 'Neant',
      nouveau_service: d.nouveau_service || 'Neant',
      date_prise_fonction: d.date_prise_fonction || pro.dat_prise_fonction || null,
      date_changement: d.date_changement || null,
      motif_changement: d.motif_changement || 'Neant',
      type_changement: d.type_changement || 'Neant',
      besoins_formation: d.besoins_formation || 'Neant',
      infop: pro.id_infop,
    }, { transaction: t });
    if (poste) {
      // Reçu soit en objet unique (ancien client), soit en tableau (CollectionEditor).
      const postes = Array.isArray(poste) ? poste : [poste];
      for (const p of postes) {
        if (!p || typeof p !== 'object') continue;
        await PosteAnterieur.create({
          nom_poste: p.nom_poste, date_debut: p.date_debut || null,
          date_fin: p.date_fin || null, institution: p.institution, infop: pro.id_infop,
        }, { transaction: t });
      }
    }
    if (diplome) {
      const diplomes = Array.isArray(diplome) ? diplome : [diplome];
      for (const dpl of diplomes) {
        if (!dpl || typeof dpl !== 'object') continue;
        await Diplome.create({
          nom_diplome: dpl.nom_diplome, date_obtention: dpl.date_obtention || null,
          institution: dpl.institution, infop: pro.id_infop,
        }, { transaction: t });
      }
    }
    if (sanction) {
      const sanctions = Array.isArray(sanction) ? sanction : [sanction];
      for (const s of sanctions) {
        if (!s || typeof s !== 'object') continue;
        await Sanction.create({
          sanction_punitive: s.sanction_punitive,
          nature_sanction: s.nature_sanction, date_sanction: s.date_sanction || null,
          motif_sanction: s.motif_sanction, infoc: comp.id_infoc,
        }, { transaction: t });
      }
    }
    if (distinction) {
      const distinctions = Array.isArray(distinction) ? distinction : [distinction];
      for (const ds of distinctions) {
        if (!ds || typeof ds !== 'object') continue;
        await Distinction.create({
          ref_distinction: ds.ref_distinction, detail_distinction: ds.detail_distinction,
          nature_distinction: ds.nature_distinction, date_distinction: ds.date_distinction || null,
          motif_distinction: ds.motif_distinction, infoc: comp.id_infoc,
        }, { transaction: t });
      }
    }
    await crediterJusqua(matricule, new Date(), { transaction: t, auteur: req.user.matricule });
    await t.commit();
    const complet = await Dossier.findOne({ where: { matricule }, include: [...INCLUDE_DOSSIER, { model: SoldeConge }] });
    try { getIo().emit('dossierCree', { matricule }); } catch (e) { /* socket optionnel */ }
    return res.status(201).json(complet);
  } catch (error) {
    await t.rollback();
    if (error.name === 'SequelizeUniqueConstraintError') {
      return res.status(409).json({ error: 'Matricule déjà utilisé.' });
    }
    return res.status(500).json({ error: 'Erreur lors de la création du dossier : ' + error.message });
  }
};
