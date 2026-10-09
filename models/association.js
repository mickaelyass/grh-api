const { DataTypes } = require('sequelize');
const sequelize = require('../db');
const Utilisateur = require('./utilisateur');
const Dossier = require('./dossier');
const PieceJointe = require('./piece_jointe');
const InfoIdent = require('./infoIdent');
const InfoPro = require('./infoPro');
const InfoBank = require('./infoBank');
const InfoComplementaire = require('./infoComplementaire');
const Distinction = require('./distinction');
const Sanction = require('./sanction');
const Details = require('./detailsMutation');
const Diplome = require('./diplome');
const PosteAnterieur = require('./posteAnterieur');
const Notifications = require('./notification');
const UserProfile = require('./userProfile');
const DemandeConges = require('./demandeConge');
const FichePresence = require('./fichePresence');
const SoldeConge = require('./soldeConge');
const AcquittementCron = require('./acquittementCron');
const AuditConge = require('./auditConge');

/**
 * ============================================================================
 * RELATIONS DES DONNÉES
 * ============================================================================
 *  dossier (matricule UNIQUE = clé métier immuable)
 *    1:1 info_ident / info_pro / info_bank / info_complementaire
 *         └─ chaque bloc porte `dossier_id` (UNIQUE NOT NULL)
 *    1:N details, distinction, sanction, diplome, poste_anterieur
 *    1:N demande_conges ── 1:N piece_jointe
 *    1:N solde_conge (par année), audit_conges, fichepresence, evaluation
 *
 *  utilisateur (compte de connexion — peut exister SANS dossier)
 *    ⇔ dossier : association par ÉGALITÉ de matricule, validée par l'admin
 *                → `constraints: false` : AUCUNE FK entre les deux
 *    1:N notifications, 1:1 user_profiles
 * ============================================================================
 */

// --- Dossier ↔ blocs 1:1 (l'enfant porte la FK) --------------------------
Dossier.hasOne(InfoIdent, { foreignKey: 'dossier_id', sourceKey: 'id_dossier' });
InfoIdent.belongsTo(Dossier, { foreignKey: 'dossier_id' });

Dossier.hasOne(InfoPro, { foreignKey: 'dossier_id', sourceKey: 'id_dossier' });
InfoPro.belongsTo(Dossier, { foreignKey: 'dossier_id' });

Dossier.hasOne(InfoBank, { foreignKey: 'dossier_id', sourceKey: 'id_dossier' });
InfoBank.belongsTo(Dossier, { foreignKey: 'dossier_id' });

Dossier.hasOne(InfoComplementaire, { foreignKey: 'dossier_id', sourceKey: 'id_dossier' });
InfoComplementaire.belongsTo(Dossier, { foreignKey: 'dossier_id' });

// --- Collections rattachées à leur bloc ----------------------------------
InfoComplementaire.hasMany(Distinction, { foreignKey: 'infoc', sourceKey: 'id_infoc' });
Distinction.belongsTo(InfoComplementaire, { foreignKey: 'infoc', targetKey: 'id_infoc' });

InfoComplementaire.hasMany(Sanction, { foreignKey: 'infoc', sourceKey: 'id_infoc' });
Sanction.belongsTo(InfoComplementaire, { foreignKey: 'infoc', targetKey: 'id_infoc' });

InfoPro.hasMany(Diplome, { foreignKey: 'infop', sourceKey: 'id_infop' });
Diplome.belongsTo(InfoPro, { foreignKey: 'infop', targetKey: 'id_infop' });

InfoPro.hasMany(PosteAnterieur, { foreignKey: 'infop', sourceKey: 'id_infop' });
PosteAnterieur.belongsTo(InfoPro, { foreignKey: 'infop', targetKey: 'id_infop' });

InfoPro.hasMany(Details, { foreignKey: 'infop', sourceKey: 'id_infop' });
Details.belongsTo(InfoPro, { foreignKey: 'infop', targetKey: 'id_infop' });

// --- Compte ⇔ dossier : association par matricule, SANS contrainte --------
// Un utilisateur peut exister sans dossier (admin, …) : aucune FK ici.
// L'association est validée par l'administrateur (assign-user) + journalisée.
Utilisateur.hasOne(Dossier, { foreignKey: 'matricule', sourceKey: 'matricule', constraints: false });
Dossier.belongsTo(Utilisateur, { foreignKey: 'matricule', targetKey: 'matricule', constraints: false });

Utilisateur.hasOne(UserProfile, { foreignKey: 'matricule', sourceKey: 'matricule' });
UserProfile.belongsTo(Utilisateur, { foreignKey: 'matricule', targetKey: 'matricule' });

Utilisateur.hasMany(Notifications, { foreignKey: 'id_user', sourceKey: 'id_user' });
Notifications.belongsTo(Utilisateur, { foreignKey: 'id_user', targetKey: 'id_user' });

// --- Congés ---------------------------------------------------------------
// Une demande exige un dossier → FK réelle vers dossier.matricule
Dossier.hasMany(DemandeConges, { foreignKey: 'matricule', sourceKey: 'matricule' });
DemandeConges.belongsTo(Dossier, { foreignKey: 'matricule', targetKey: 'matricule' });

// Pièces jointes : 1:N, sens unique (la pièce pointe vers la demande)
DemandeConges.hasMany(PieceJointe, {
  foreignKey: 'id_cong',
  sourceKey: 'id_cong',
  as: 'piecesJointes',
  onDelete: 'CASCADE',
});
PieceJointe.belongsTo(DemandeConges, { foreignKey: 'id_cong', as: 'demandeConge' });

Dossier.hasMany(SoldeConge, { foreignKey: 'matricule', sourceKey: 'matricule' });
SoldeConge.belongsTo(Dossier, { foreignKey: 'matricule', targetKey: 'matricule' });

Dossier.hasMany(AcquittementCron, { foreignKey: 'matricule', sourceKey: 'matricule', constraints: false });
AcquittementCron.belongsTo(Dossier, { foreignKey: 'matricule', targetKey: 'matricule', constraints: false });

DemandeConges.hasMany(AuditConge, { foreignKey: 'id_cong', sourceKey: 'id_cong' });
AuditConge.belongsTo(DemandeConges, { foreignKey: 'id_cong' });

Dossier.hasMany(AuditConge, { foreignKey: 'matricule', sourceKey: 'matricule', constraints: false });
AuditConge.belongsTo(Dossier, { foreignKey: 'matricule', targetKey: 'matricule', constraints: false });

// --- Présences (module mis en pause : table conservée, routes débranchées)
FichePresence.belongsTo(Dossier, { foreignKey: 'matricule', targetKey: 'matricule', constraints: false });
Dossier.hasMany(FichePresence, { foreignKey: 'matricule', constraints: false });

// --- Évaluations ----------------------------------------------------------
const Evaluation = sequelize.define("Evaluation", {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    primaryKey: true,
  },

  // Section 1 : Informations personnelles de l'agent
  nom_prenom: { type: DataTypes.STRING, allowNull: false },
  date_lieu_naissance: { type: DataTypes.STRING, allowNull: false },
  telephone: { type: DataTypes.STRING },
  email: { type: DataTypes.STRING, validate: { isEmail: true } },
  situation_familiale: { type: DataTypes.STRING },
  situation_militaire: { type: DataTypes.STRING },
  diplome: { type: DataTypes.STRING },
  matricule: { type: DataTypes.STRING, allowNull: false },
  cnss: { type: DataTypes.STRING },
  adresse: { type: DataTypes.STRING },

  // Section 2 : Données professionnelles
  date_prise_service: { type: DataTypes.DATEONLY },
  grade_actuel: { type: DataTypes.STRING },
  categorie: { type: DataTypes.STRING },
  echelle: { type: DataTypes.STRING },
  echelon: { type: DataTypes.STRING },
  emploi: { type: DataTypes.STRING },
  contrat_initial: { type: DataTypes.STRING },
  contrat_renouvele: { type: DataTypes.STRING },
  cdi: { type: DataTypes.STRING },
  avenants: { type: DataTypes.STRING },

  // Section 3 : Évaluation des objectifs et résultats
  periode_debut: { type: DataTypes.DATEONLY },
  periode_fin: { type: DataTypes.DATEONLY },
  objectifs: { type: DataTypes.JSONB },
  resultats: { type: DataTypes.JSONB },
  contraintes: { type: DataTypes.TEXT },
  superior_notes: { type: DataTypes.JSONB },
  committee_notes: { type: DataTypes.JSONB },
}, {
  tableName: 'evaluation',
  timestamps: true
});

// FK réellement appliquée (elle n'était JAMAIS créée avant la refonte) :
// une évaluation appartient au dossier identifié par son matricule.
Dossier.hasMany(Evaluation, { foreignKey: 'matricule', sourceKey: 'matricule' });
Evaluation.belongsTo(Dossier, { foreignKey: 'matricule', targetKey: 'matricule' });

module.exports = {
  InfoIdent,
  Dossier,
  Utilisateur,
  UserProfile,
  Diplome,
  PosteAnterieur,
  Details,
  Sanction,
  Distinction,
  PieceJointe,
  Notifications,
  InfoComplementaire,
  InfoPro,
  InfoBank,
  DemandeConges,
  FichePresence,
  Evaluation,
  SoldeConge,
  AcquittementCron,
  AuditConge,
};