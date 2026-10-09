const { DataTypes } = require('sequelize');
const sequelize = require('../db');

/**
 * Solde de congés par agent et par année de jouissance.
 *   jours_acquis    : +2 par mois à partir du mois de `info_pro.dat_prise_fonction`
 *                     (crédit idempotent, voir `acquittement_cron`)
 *   jours_consommes : décrémentés UNIQUEMENT quand la demande est acceptée
 *                     par le chef de service ET par la directrice.
 * Les jours non pris sont reportés (procédure de report annuel).
 * Aucun plafond.
 */
const SoldeConge = sequelize.define('SoldeConge', {
  id_solde: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  matricule: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: 'uq_solde_matricule_annee',
    references: { model: 'dossier', key: 'matricule' }
  },
  annee: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: 'uq_solde_matricule_annee',
    validate: { min: 2000 }
  },
  jours_acquis: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0
  },
  jours_consommes: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0
  },
  // Report REÇU de l'année N-1 (journalisé pour éviter un double report)
  jours_reportes: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0
  },
  // Report SORTANT vers l'année N+1 (contrepartie : le total reste conservé,
  // dispo(année) = acquis + reportés - consommés - transférés)
  jours_transferes: {
    type: DataTypes.INTEGER,
    allowNull: false,
    defaultValue: 0
  }
}, {
  tableName: 'solde_conge',
  timestamps: true
});

module.exports = SoldeConge;