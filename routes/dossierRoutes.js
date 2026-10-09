// routes/dossierRoutes.js — routes sécurisées (authenticate + requireRole)
const express = require('express');
const router = express.Router();
const {
  createMutation, creteDossier, getAllDossiers, getDossierById,
  getDossierByMaticule, searchDossiersByNomAndService, updateDossier,
  updateEtat, deletedossier, assignUser, getEtat, getCongeByMatricule,
} = require('../controllers/dossierController.js');
const { authenticate, requireRole } = require('../utils/auth');

// Création d'un dossier (admin — le dossier précède l'association au compte)
router.post('/', authenticate, requireRole('admin'), creteDossier);

router.get('/', authenticate, getAllDossiers);

// Recherche nom/service (AVANT /:id pour éviter l'ambiguïté)
router.get('/search', authenticate, searchDossiersByNomAndService);

// État d'un agent / congés d'un agent (AVANT les routes paramétrées)
router.get('/etat/:matricule', authenticate, getEtat);
router.get('/conges/:matricule', authenticate, getCongeByMatricule);
router.get('/user/:matricule', authenticate, getDossierByMaticule);

router.get('/:id', authenticate, getDossierById);

// Mise à jour (admin + encadrement, périmètre vérifié dans le contrôleur)
router.put('/:id', authenticate, requireRole('admin', 'directrice', 'chef_service'), updateDossier);

// Association dossier <-> compte par l'admin (égalité des matricules)
router.put('/:id/assign-user', authenticate, requireRole('admin'), assignUser);

router.put('/:id_dossier/etat', authenticate, requireRole('admin', 'directrice', 'chef_service'), updateEtat);

// Archivage (soft-delete) — admin uniquement
router.delete('/:id_dossier', authenticate, requireRole('admin'), deletedossier);

router.post('/mutations/:matricule', authenticate, requireRole('admin', 'directrice', 'chef_service'), createMutation);

module.exports = router;
