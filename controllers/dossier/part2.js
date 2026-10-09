// controllers/dossier/part2.js — lectures (liste, recherche, détail)
const { Op } = require('sequelize');
const {
  Dossier, InfoIdent, InfoPro,
} = require('../../models/association');
const {
  peutToutVoir, serviceDeChef, porteeDossier,
  INCLUDE_DOSSIER, pagination, verifierAccesDossier,
} = require('./helpers');

exports.getAllDossiers = async (req, res) => {
  try {
    const { page, limit, offset } = pagination(req);
    const portee = await porteeDossier(req);
    const { rows, count } = await Dossier.findAndCountAll({
      where: portee,
      include: [
        { model: InfoIdent, attributes: ['nom', 'prenom', 'sexe'] },
        { model: InfoPro, attributes: ['corps', 'grade_paye', 'poste_actuel_service', 'fonctions'] },
      ],
      order: [['createdAt', 'DESC']],
      limit, offset, distinct: true,
    });
    res.status(200).json({ data: rows, meta: { page, limit, total: count } });
  } catch (err) {
    res.status(500).json({ error: 'Erreur serveur' });
  }
};

exports.searchDossiersByNomAndService = async (req, res) => {
  try {
    const { q = '', service = '' } = req.query;
    const { page, limit, offset } = pagination(req);
    const portee = await porteeDossier(req);
    const and = [portee];
    if (q.trim()) {
      and.push({ [Op.or]: [
        { '$InfoIdent.nom$': { [Op.iLike]: `%${q.trim()}%` } },
        { '$InfoIdent.prenom$': { [Op.iLike]: `%${q.trim()}%` } },
      ] });
    }
    if (service.trim()) {
      and.push({ '$InfoPro.poste_actuel_service$': { [Op.iLike]: `%${service.trim()}%` } });
    }
    const { rows, count } = await Dossier.findAndCountAll({
      where: { [Op.and]: and },
      include: [
        { model: InfoIdent, attributes: ['nom', 'prenom', 'sexe'], required: !!q.trim() },
        { model: InfoPro, attributes: ['corps', 'poste_actuel_service', 'fonctions'],
          required: !!service.trim() || req.user.role === 'chef_service' },
      ],
      order: [['createdAt', 'DESC']],
      limit, offset, distinct: true,
    });
    res.status(200).json({ data: rows, meta: { page, limit, total: count } });
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la recherche des dossiers : ' + error.message });
  }
};

exports.getDossierById = async (req, res) => {
  try {
    const dossier = await Dossier.findByPk(req.params.id, { include: INCLUDE_DOSSIER });
    if (!dossier) return res.status(404).json({ error: 'Dossier non trouvé' });
    if (!(await verifierAccesDossier(req, dossier))) {
      return res.status(403).json({ error: 'Accès refusé à ce dossier.' });
    }
    res.status(200).json(dossier);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération du dossier : ' + error.message });
  }
};

exports.getDossierByMaticule = async (req, res) => {
  try {
    const dossier = await Dossier.findOne({
      where: { matricule: req.params.matricule },
      include: INCLUDE_DOSSIER,
    });
    if (!dossier) return res.status(404).json({ error: 'Dossier non trouvé' });
    if (!(await verifierAccesDossier(req, dossier))) {
      return res.status(403).json({ error: 'Accès refusé à ce dossier.' });
    }
    res.status(200).json(dossier);
  } catch (error) {
    res.status(500).json({ error: 'Erreur lors de la récupération du dossier : ' + error.message });
  }
};
