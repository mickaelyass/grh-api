const { DataTypes } = require('sequelize');
const sequelize = require('../db');
const InfoPro = require('./infoPro');

const PosteAnterieur = sequelize.define('PosteAnterieur', {
  id_poste: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  nom_poste: { type: DataTypes.STRING },
  date_debut: { type: DataTypes.DATE },
  date_fin: { type: DataTypes.DATE },
  institution: { type: DataTypes.STRING },
  infop: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: { model: 'info_pro', key: 'id_infop' }
  }
}, {
  tableName: 'poste_anterieur',
  timestamps: true
});

// Associations


module.exports = PosteAnterieur;
