const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const ACTIONS = [
  'CREATION',
  'DECISION_CHEF',
  'DECISION_DIRECTRICE',
  'SUPPRESSION',
  'CREDIT_MENSUEL',
  'REPORT_ANNUEL',
];

/**
 * Journal d'audit des congés : qui a fait quoi, quand, de quel état à quel état.
 * Écrit en même temps que chaque changement de statut ou de solde.
 */
const AuditConge = sequelize.define('AuditConge', {
  id_audit: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  id_cong: {
    type: DataTypes.INTEGER,
    allowNull: true,               // les lignes de solde n'ont pas de demande
    references: { model: 'demande_conges', key: 'id_cong' }
  },
  matricule: {
    type: DataTypes.STRING(50),
    allowNull: false
  },
  action: {
    type: DataTypes.ENUM(...ACTIONS),
    allowNull: false
  },
  ancien_statut: { type: DataTypes.STRING(50) },
  nouveau_statut: { type: DataTypes.STRING(50) },
  details: { type: DataTypes.TEXT },
  auteur_matricule: { type: DataTypes.STRING(50) }   // matricule de l'utilisateur qui agit
}, {
  tableName: 'audit_conges',
  timestamps: true
});

AuditConge.ACTIONS = ACTIONS;

module.exports = AuditConge;