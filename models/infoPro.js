const { DataTypes } = require('sequelize');
const sequelize = require('../db');

const InfoPro = sequelize.define('InfoPro', {
  id_infop: {
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
  statut: { type: DataTypes.STRING },
  corps: { type: DataTypes.STRING },
  categorie: { type: DataTypes.STRING },
  branche_du_personnel: { type: DataTypes.STRING },
  fonctions: { type: DataTypes.STRING },
  // Date de prise de fonction = date de signature du contrat :
  // c'est elle qui déclenche le crédit de 2 jours de congés par mois.
  dat_prise_fonction: { type: DataTypes.DATE },
  responsabilite_partiuliere: { type: DataTypes.STRING },
  grade_paye: { type: DataTypes.STRING },
  indice_paye: { type: DataTypes.INTEGER },
  dat_first_prise_de_service: { type: DataTypes.DATE },
  dat_de_depart_retraite: { type: DataTypes.DATE },
  dat_de_prise_service_dans_departement: { type: DataTypes.DATE },
  ref_acte_de_prise_service_poste_actuel: { type: DataTypes.STRING },
  poste_actuel_service: { type: DataTypes.STRING },
  type_structure: { type: DataTypes.STRING },
  ref_nomination: { type: DataTypes.STRING },
  zone_sanitaire: { type: DataTypes.STRING },
  poste_specifique: { type: DataTypes.STRING },
  // SUPPRIMÉ : nombre_jour_conges_disponible → remplacé par la table `solde_conge`
  // (acquis / consommés par année, mise à jour transactionnellement).
}, {
  tableName: 'info_pro',
  timestamps: true
});

module.exports = InfoPro;
