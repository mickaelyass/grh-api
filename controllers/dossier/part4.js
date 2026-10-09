// controllers/dossier/part4.js — état, archivage
const sequelize = require('../../db');
const { getIo } = require('../../utils/socket');
const {
  Dossier, InfoPro, Details,
} = require('../../models/association');
const { verifierAccesDossier } = require('./helpers');

exports.updateEtat = async (req, res) => {
  const t = await sequelize.transaction();
  try {
    const { id_dossier } = req.params;
    const { etat, nouveau_poste, nouveau_service } = req.body;
    const dossier = await Dossier.findByPk(id_dossier, {
      include: [{ model: InfoPro }],
      transaction: t,
    });
    if (!dossier) { await t.rollback(); return res.status(404).json({ error: 'Dossier non trouvé' }); }
    if (!(await verifierAccesDossier(req, dossier))) {
      await t.rollback();
      return res.status(403).json({ error: 'Accès refusé à ce dossier.' });
    }
    const pro = dossier.InfoPro;
    const mutation = await Details.create({
      etat: etat || 'Actif',
      poste_actuel: (pro && pro.fonctions) || 'Neant',
      nouveau_poste: nouveau_poste || 'Neant',
      nouveau_service: nouveau_service || 'Neant',
      date_prise_fonction: (pro && pro.dat_prise_fonction) || null,
      date_changement: new Date(),
      infop: pro ? pro.id_infop : null,
    }, { transaction: t });
    if (pro && (nouveau_poste || nouveau_service)) {
      if (nouveau_poste) pro.fonctions = nouveau_poste;
      if (nouveau_service) pro.poste_actuel_service = nouveau_service;
      await pro.save({ transaction: t });
    }
    await t.commit();
    try { getIo().emit('mutationAgent', { matricule: dossier.matricule, etat }); } catch (e) { /* socket */ }
    res.status(200).json(mutation);
  } catch (error) {
    await t.rollback();
    res.status(500).json({ error: "Erreur lors de la mise à jour de l'état : " + error.message });
  }
};

exports.deletedossier = async (req, res) => {
  try {
    const dossier = await Dossier.findByPk(req.params.id_dossier);
    if (!dossier) return res.status(404).json({ error: 'Dossier non trouvé' });
    if (!(await verifierAccesDossier(req, dossier))) {
      return res.status(403).json({ error: 'Accès refusé à ce dossier.' });
    }
    await dossier.destroy(); // paranoid → archivage
    try { getIo().emit('dossierArchive', { matricule: dossier.matricule }); } catch (e) { /* socket */ }
    res.status(200).json({ message: 'Dossier archivé avec succès' });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la suppression du dossier : ' + error.message });
  }
};
