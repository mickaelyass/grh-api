const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const InfoBank = sequelize.define('InfoBank', {
  id_infob: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  // FK vers le dossier
  dossier_id: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: true,
    references: { model: 'dossier', key: 'id_dossier' }
  },
  rib: { type: DataTypes.STRING },
  mtn: { type: DataTypes.STRING },
  celtics: { type: DataTypes.STRING },
  moov: { type: DataTypes.STRING }
}, {
  tableName: 'info_bank',
  timestamps: true
});

module.exports = InfoBank;
