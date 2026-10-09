// models/Piece_jointe.js
const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const TYPES_PIECE = ['certificat', 'attestation'];

/**
 * Une pièce jointe appartient à UNE demande de congré (et non l'inverse) :
 * plus de clé circulaire `demande_conges.piece_jointe`.
 * 1 ligne par fichier, au maximum 1 de chaque type par demande.
 */
const PieceJointe = sequelize.define('Piece_jointe', {
  id_piece: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  id_cong: {
    type: DataTypes.INTEGER,
    allowNull: false,
    unique: 'uq_piece_conge_type',
    references: { model: 'demande_conges', key: 'id_cong' }
  },
  type: {
    type: DataTypes.ENUM(...TYPES_PIECE),
    allowNull: false,
    unique: 'uq_piece_conge_type'
  },
  url: {
    type: DataTypes.TEXT,
    allowNull: false
  }
}, {
  tableName: 'piece_jointe',
  timestamps: true
});

PieceJointe.TYPES = TYPES_PIECE;

module.exports = PieceJointe;