const { DataTypes } = require('sequelize');
const sequelize = require('../db');

/**
 * Empreinte mensuelle du crédit automatique de congés (+2 jours).
 * L'UNIQUE (matricule, annee, mois) garantit qu'un même mois ne sera
 * crédité qu'une seule fois, même si le cron est relancé manuellement.
 */
const AcquittementCron = sequelize.define('AcquittementCron', {
  id: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  matricule: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: 'uq_acquittement_periode'
  },
  annee: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: 'uq_acquittement_periode'
  },
  mois: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: 'uq_acquittement_periode',
    validate: { min: 1, max: 12 }
  }
}, {
  tableName: 'acquittement_cron',
  timestamps: true
});

module.exports = AcquittementCron;