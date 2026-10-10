// controllers/dossier/part3.js — mise à jour, assign-user
const sequelize = require('../../db');
const {
  Dossier, InfoIdent, InfoPro, InfoBank, InfoComplementaire,
  Utilisateur, Diplome, PosteAnterieur, Distinction, Sanction,
} = require('../../models/association');
const { crediterJusqua } = require('../../services/soldeService');
const { verifierAccesDossier } = require('./helpers');
const { getIo } = require('../../utils/socket');

/**
 * Remplace la collection 1:N d'une ligne (diplômes, postes, distinctions,
 * sanctions). La liste envoyée devient l'état final : la liste éditée dans
 * l'interface est la source de vérité, on détruit puis on recrée dans la
 * transaction. Un tableau vide signifie « tout supprimer ».
 */
const remplacerCollection = async (Model, items, valeursFk, transaction) => {
  await Model.destroy({ where: valeursFk, transaction });
  const lignes = (Array.isArray(items) ? items : [])
    .filter((item) => item && typeof item === 'object')
    .map((item) => ({ ...item, ...valeursFk }));
  if (lignes.length) await Model.bulkCreate(lignes, { transaction });
};

exports.updateDossier = async (req, res) => {
  const t = await sequelize.transaction();
  try {
    const dossier = await Dossier.findByPk(req.params.id, { transaction: t });
    if (!dossier) { await t.rollback(); return res.status(404).json({ error: 'Dossier non trouvé' }); }
    if (!(await verifierAccesDossier(req, dossier))) {
      await t.rollback();
      return res.status(403).json({ error: 'Accès refusé à ce dossier.' });
    }
    if (req.body.matricule && req.body.matricule !== dossier.matricule) {
      await t.rollback();
      return res.status(400).json({ error: 'Le matricule est immuable : il ne peut pas être modifié.' });
    }
    const { infoIdent, infoPro, infoBank, infoComplementaire } = req.body;
    if (infoIdent) await InfoIdent.update(infoIdent, { where: { dossier_id: dossier.id_dossier }, transaction: t });
    if (infoPro) await InfoPro.update(infoPro, { where: { dossier_id: dossier.id_dossier }, transaction: t });
    if (infoBank) await InfoBank.update(infoBank, { where: { dossier_id: dossier.id_dossier }, transaction: t });
    if (infoComplementaire) {
      await InfoComplementaire.update(infoComplementaire, { where: { dossier_id: dossier.id_dossier }, transaction: t });
    }

    // Collections éditées dans le formulaire (tableaux) : remplacées telles
    // quelles. Absentes du body → inchangées (compat avec l'ancien client).
    const pro = await InfoPro.findOne({ where: { dossier_id: dossier.id_dossier }, transaction: t });
    const comp = await InfoComplementaire.findOne({ where: { dossier_id: dossier.id_dossier }, transaction: t });
    if (pro && Array.isArray(req.body.diplome)) {
      await remplacerCollection(Diplome, req.body.diplome, { infop: pro.id_infop }, t);
    }
    if (pro && Array.isArray(req.body.poste)) {
      await remplacerCollection(PosteAnterieur, req.body.poste, { infop: pro.id_infop }, t);
    }
    if (comp && Array.isArray(req.body.distinction)) {
      await remplacerCollection(Distinction, req.body.distinction, { infoc: comp.id_infoc }, t);
    }
    if (comp && Array.isArray(req.body.sanction)) {
      await remplacerCollection(Sanction, req.body.sanction, { infoc: comp.id_infoc }, t);
    }

    if (infoPro && infoPro.dat_prise_fonction) {
      await crediterJusqua(dossier.matricule, new Date(), { transaction: t, auteur: req.user.matricule });
    }
    await t.commit();
    try { getIo().emit('dossierMisAJour', { id_dossier: dossier.id_dossier, matricule: dossier.matricule }); } catch (e) { /* socket optionnel */ }
    const { INCLUDE_DOSSIER } = require('./helpers');
    const maj = await Dossier.findByPk(dossier.id_dossier, { include: INCLUDE_DOSSIER });
    res.status(200).json(maj);
  } catch (error) {
    await t.rollback();
    res.status(500).json({ error: 'Erreur lors de la mise à jour du dossier : ' + error.message });
  }
};

exports.assignUser = async (req, res) => {
  const t = await sequelize.transaction();
  try {
    const dossier = await Dossier.findByPk(req.params.id, { transaction: t });
    if (!dossier) { await t.rollback(); return res.status(404).json({ error: 'Dossier non trouvé' }); }
    const { id_user } = req.body;
    const compte = await Utilisateur.findByPk(id_user, { transaction: t });
    if (!compte) { await t.rollback(); return res.status(404).json({ error: 'Compte utilisateur introuvable.' }); }
    if (compte.matricule !== dossier.matricule) {
      await t.rollback();
      return res.status(409).json({
        error: `Matricules différents : dossier=${dossier.matricule}, compte=${compte.matricule}.`,
      });
    }
    if (dossier.id_user_associe && dossier.id_user_associe !== compte.id_user) {
      await t.rollback();
      return res.status(409).json({ error: 'Ce dossier est déjà associé à un autre compte.' });
    }
    dossier.id_user_associe = compte.id_user;
    await dossier.save({ transaction: t });
    await t.commit();
    res.status(200).json({ message: 'Compte associé au dossier.', matricule: dossier.matricule, id_user });
  } catch (error) {
    await t.rollback();
    res.status(500).json({ error: "Erreur lors de l'association : " + error.message });
  }
};
