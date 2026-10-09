// controllers/dossier/part5.js — mutations, état lecture, congés d'un agent
const sequelize = require('../../db');
const { getIo } = require('../../utils/socket');
const {
  Dossier, InfoPro, Details, DemandeConges,
} = require('../../models/association');
const { pagination, verifierAccesDossier } = require('./helpers');

exports.createMutation = async (req, res) => {
  const t = await sequelize.transaction();
  try {
    const { matricule } = req.params;
    const dossier = await Dossier.findOne({
      where: { matricule },
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
      etat: req.body.etat || 'Actif',
      poste_actuel: req.body.poste_actuel || (pro && pro.fonctions) || 'Neant',
      nouveau_poste: req.body.nouveau_poste || 'Neant',
      nouveau_service: req.body.nouveau_service || 'Neant',
      date_prise_fonction: req.body.date_prise_fonction || (pro && pro.dat_prise_fonction) || null,
      date_changement: req.body.date_changement || new Date(),
      infop: pro ? pro.id_infop : null,
    }, { transaction: t });
    await t.commit();
    try { getIo().emit('mutationAgent', { matricule, etat: mutation.etat }); } catch (e) { /* s */ }
    res.status(201).json(mutation);
  } catch (error) {
    await t.rollback();
    res.status(500).json({ error: 'Erreur lors de la création de la mutation : ' + error.message });
  }
};

exports.getEtat = async (req, res) => {
  try {
    const mutation = await Details.findOne({
      where: { '$InfoPro.Dossier.matricule$': req.params.matricule },
      include: [{ model: InfoPro, include: [{ model: Dossier, attributes: [] }], attributes: [] }],
      order: [['createdAt', 'DESC']],
    });
    if (!mutation) return res.status(404).json({ error: 'Aucun état trouvé pour ce matricule.' });
    res.status(200).json({ etat: mutation.etat });
  } catch (error) {
    res.status(500).json({ error: "Erreur lors de la récupération de l'état : " + error.message });
  }
};

exports.getCongeByMatricule = async (req, res) => {
  try {
    const { matricule } = req.params;
    const dossier = await Dossier.findOne({ where: { matricule } });
    if (!dossier) return res.status(404).json({ error: 'Dossier non trouvé' });
    if (!(await verifierAccesDossier(req, dossier))) {
      return res.status(403).json({ error: 'Accès refusé à ce dossier.' });
    }
    const { page, limit, offset } = pagination(req);
    const { rows, count } = await DemandeConges.findAndCountAll({
      where: { matricule },
      order: [['date_debut', 'DESC']],
      limit, offset,
    });
    res.status(200).json({ data: rows, meta: { page, limit, total: count } });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération des congés : ' + error.message });
  }
};
