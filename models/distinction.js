const { DataTypes } = require('sequelize');
const sequelize = require('../db');
const InfoComplementaire = require('./infoComplementaire');

const Distinction = sequelize.define('Distinction', {
  id_distinction: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  ref_distinction: { type: DataTypes.STRING },
  detail_distinction: { type: DataTypes.TEXT },
  nature_distinction: { type: DataTypes.STRING },
  date_distinction: { type: DataTypes.DATE },
  motif_distinction: { type: DataTypes.TEXT },
  infoc: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: { model: 'info_complementaire', key: 'id_infoc' }
  }

}, {
  tableName: 'distinction',
  timestamps: true
});

// Associations

module.exports = Distinction;
