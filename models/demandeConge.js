// models/DemandeConges.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const STATUTS = ['En attente', 'Autorisée', 'Rejetée'];

const DemandeConges = sequelize.define('DemandeConges', {
  id_cong: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  // FK vers le dossier de l'agent (matricule = clé métier UNIQUE du dossier).
  // Remplace l'ancien lien vers `utilisateur` : une demande exige un dossier.
  matricule: {
    type: DataTypes.STRING(50),
    allowNull: false,
    references: { model: 'dossier', key: 'matricule' }
  },
  type_de_conge: {
    type: DataTypes.STRING,
    allowNull: false
  },
  date_debut: {
    type: DataTypes.DATE,
    allowNull: false
  },
  date_de_fin: {
    type: DataTypes.DATE,
    allowNull: false
  },
  annee_jouissance: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  nombre_de_jour: {
    type: DataTypes.INTEGER,
    allowNull: false,
    validate: { min: 1 }
  },
  raison: {
    type: DataTypes.TEXT
  },
  // Cycle de vie : En attente (chef) → En attente (directrice) → Autorisée / Rejetée
  status: {
    type: DataTypes.ENUM(...STATUTS),
    allowNull: false,
    defaultValue: 'En attente'
  },
  decision_chef_service: {
    type: DataTypes.ENUM(...STATUTS),
    allowNull: false,
    defaultValue: 'En attente'
  },
  decision_directrice: {
    type: DataTypes.ENUM(...STATUTS),
    allowNull: false,
    defaultValue: 'En attente'
  }
}, {
  tableName: 'demande_conges',
  timestamps: true,
  paranoid: true,              // archivage des demandes supprimées
  deletedAt: 'deleted_at'
});

DemandeConges.STATUTS = STATUTS;

module.exports = DemandeConges;
