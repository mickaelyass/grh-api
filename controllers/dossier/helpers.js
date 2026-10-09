// controllers/dossier/helpers.js — périmètre, pagination, vérification d'accès
const {
  Dossier, InfoIdent, InfoPro, InfoBank, InfoComplementaire, SoldeConge,
} = require('../../models/association');

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
  { model: SoldeConge }, // solde de congés de l'agent dans la lecture du dossier
];

const pagination = (req, defaut = 20, max = 100) => {
  const page = Math.max(parseInt(req.query.page, 10) || 1, 1);
  const limit = Math.min(Math.max(parseInt(req.query.limit, 10) || defaut, 1), max);
  return { page, limit, offset: (page - 1) * limit };
};

const verifierAccesDossier = async (req, dossier) => {
  if (!dossier) return false;
  const { role, matricule } = req.user;
  if (peutToutVoir(role)) return true;
  if (role === 'chef_service') {
    const service = await serviceDeChef(req.user);
    const pro = await InfoPro.findOne({
      where: { dossier_id: dossier.id_dossier },
      attributes: ['poste_actuel_service'],
    });
    return !!service && !!pro && pro.poste_actuel_service === service;
  }
  return dossier.matricule === matricule;
};

module.exports = {
  peutToutVoir, serviceDeChef, porteeDossier,
  INCLUDE_DOSSIER, pagination, verifierAccesDossier,
};
