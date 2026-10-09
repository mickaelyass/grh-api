const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const InfoIdent = sequelize.define('InfoIdent', {
  id_infoi: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  // FK vers le dossier : le bloc appartient au dossier (relation inversée)
  dossier_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: true,
    references: { model: 'dossier', key: 'id_dossier' }
  },
  cnss: { type: DataTypes.STRING },
  nom: { type: DataTypes.STRING, allowNull: false },
  prenom: { type: DataTypes.STRING, allowNull: false },
  dat_nat: { type: DataTypes.DATE },
  lieu_nat: { type: DataTypes.STRING },
  situat_matri: { type: DataTypes.STRING },
  // Contact de l'agent (l'email de connexion, lui, vit sur `utilisateur`)
  email: { type: DataTypes.STRING },
  sexe: { type: DataTypes.STRING(1), allowNull: false, validate: { isIn: [['F', 'M']] } },
  nom_du_conjoint: { type: DataTypes.STRING, allowNull: true },
  dat_mariage: { type: DataTypes.DATE, allowNull: true },
  nbre_enfants: { type: DataTypes.INTEGER }
}, {
  tableName: 'info_ident',
  timestamps: true
});

module.exports = InfoIdent;
