const { DataTypes } = require('sequelize');
const sequelize = require('../db');

/**
 * Table pivot du personnel : UN dossier par matricule (clé métier immuable).
 * L'association avec un compte utilisateur se fait par ÉGALITÉ de matricule
 * (l'administrateur la valide via POST /api/dossiers/:id/assign-user).
 * Les blocs (info_ident, info_pro, info_bank, info_complementaire) pointent
 * ICI via leur colonne dossier_id — et non l'inverse.
 */
const Dossier = sequelize.define('Dossier', {
  id_dossier: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  matricule: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: true
  },
  // Dernier compte associé par l'admin (traçabilité de l'association)
  id_user_associe: {
    type: DataTypes.INTEGER,
    allowNull: true,
    references: { model: 'utilisateur', key: 'id_user' }
  }
}, {
  tableName: 'dossier',
  timestamps: true,
  paranoid: true,            // archivage : deleted_at au lieu de suppression physique
  deletedAt: 'deleted_at'
});

module.exports = Dossier;