const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const InfoComplementaire = sequelize.define('InfoComplementaire', {
  id_infoc: {
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
  observation_particuliere: { type: DataTypes.TEXT },
  situat_sante: { type: DataTypes.STRING },
}, {
  tableName: 'info_complementaire',
  timestamps: true
});

module.exports = InfoComplementaire;
