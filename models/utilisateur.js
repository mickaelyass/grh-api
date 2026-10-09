const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const ROLES = ['admin', 'directrice', 'chef_service', 'employe'];

const Utilisateur = sequelize.define('Utilisateur', {
  id_user: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  // Clé métier de l'agent. Immuables : aucune route ne doit permettre de les modifier.
  matricule: {
    type: DataTypes.STRING(50),
    allowNull: false,
    unique: true
  },
  email: {
    type: DataTypes.STRING,
    allowNull: true,
    unique: true,
    validate: { isEmail: { msg: 'Email invalide' } }
  },
  password: {
    type: DataTypes.STRING,
    allowNull: false
  },
  role: {
    type: DataTypes.ENUM(...ROLES),
    allowNull: false,
    defaultValue: 'employe'
  },
  is_active: {
    type: DataTypes.BOOLEAN,
    allowNull: false,
    defaultValue: true
  },
  last_login_at: {
    type: DataTypes.DATE,
    allowNull: true
  },
  // Mot de passe oublié : token HASHÉ + expiration (jamais de token en clair en base)
  reset_token_hash: {
    type: DataTypes.STRING,
    allowNull: true
  },
  reset_token_expire: {
    type: DataTypes.DATE,
    allowNull: true
  }
}, {
  tableName: 'utilisateur',
  timestamps: true,
  defaultScope: {
    // Les comptes désactivés ne sont plus proposés par défaut (login compris)
    attributes: { exclude: ['password'] }
  },
  scopes: {
    withPassword: { attributes: { include: ['password'] } }
  }
});

Utilisateur.ROLES = ROLES;

module.exports = Utilisateur;
