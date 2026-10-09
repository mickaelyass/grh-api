const { DataTypes } = require('sequelize');
const sequelize = require('../db');
const InfoComplementaire = require('./infoComplementaire');

const Sanction = sequelize.define('Sanction', {
  id_sanction: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  sanction_punitive: { type: DataTypes.STRING },
  nature_sanction: { type: DataTypes.STRING },
  date_sanction: { type: DataTypes.DATE },
  motif_sanction: { type: DataTypes.TEXT },
  infoc: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: { model: 'info_complementaire', key: 'id_infoc' }
  }
}, {
  tableName: 'sanction',
  timestamps: true
});

// Associations


module.exports = Sanction;
