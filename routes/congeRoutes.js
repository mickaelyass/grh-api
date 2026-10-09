// routes/congeRoutes.js
const express = require('express');
const router = express.Router();
const {
  createDemandeConge, listesDemandeConge, listesCongeParServices,
  findCongeId, findCongeMatricule, decisionChef, decisionDirectrice,
  listescongeParStatus, deleteConge, listescongeParStatusAutoriser,
  getSoldeConge, forcerCredit,
} = require('../controllers/demandeCongesController');
const { authenticate, requireRole } = require('../utils/auth');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Configuration du stockage des fichiers
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadPath = path.join(__dirname, '../frontend/public/doc');
    if (!fs.existsSync(uploadPath)) fs.mkdirSync(uploadPath, { recursive: true });
    cb(null, uploadPath);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname)); // Nom unique du fichier
  },
});

const upload = multer({
  storage,
  limits: { fileSize: 10 * 1024 * 1024 }, // 10 Mo max par pièce jointe
  fileFilter: (req, file, cb) => cb(null, true), // Tous types acceptés
});

// ===========================================================================
// Routes STATIQUES d'abord (avant /:id_cong pour éviter l'ambiguïté)
// ===========================================================================

// Création d'une demande avec pièces jointes (le périmètre matricule est
// vérifié dans le contrôleur : employé/chef = son propre matricule)
router.post(
  '/demande-conges/create',
  authenticate,
  requireRole('employe', 'chef_service', 'directrice', 'admin'),
  upload.fields([{ name: 'certificat', maxCount: 1 }, { name: 'attestation', maxCount: 1 }]),
  createDemandeConge
);

// Toutes les demandes (portée selon le rôle ; ?page=&limit= pour paginer)
router.get('/demande-conges', authenticate, listesDemandeConge);

// Demandes autorisées, avec nom/prénom (1 requête SQL)
router.get('/demande-conges-autoriser', authenticate, listescongeParStatusAutoriser);

// Solde de congés (sans matricule = son propre solde)
router.get('/demande-conges/solde', authenticate, getSoldeConge);
router.get('/demande-conges/solde/:matricule', authenticate, getSoldeConge);

// Crédit de rattrapage manuel (admin) — idempotent
router.post(
  '/demande-conges/solde/forcer-credit',
  authenticate, requireRole('admin'),
  forcerCredit
);
router.post(
  '/demande-conges/solde/forcer-credit/:matricule',
  authenticate, requireRole('admin'),
  forcerCredit
);

// Demandes par décision du chef
router.get('/demande-conges/status/:status', authenticate, listescongeParStatus);

// Demandes en attente de décision pour un service
router.get('/demandes/service/:service', authenticate, listesCongeParServices);

// Toutes les demandes d'un agent (route explicite, sans ambiguïté)
router.get('/demande-conges/matricule/:matricule', authenticate, findCongeMatricule);

// ===========================================================================
// Routes paramétrées
// ===========================================================================

// Une demande (par id, repli automatique sur le matricule)
router.get('/demande-conges/:id_cong', authenticate, findCongeId);

// Décisions du circuit de validation
router.put(
  '/demande-conges/:id/decision-chef-service',
  authenticate, requireRole('chef_service', 'admin'),
  decisionChef
);
router.put(
  '/demande-conges/:id/decision-directrice',
  authenticate, requireRole('directrice', 'admin'),
  decisionDirectrice
);

// Archivage (soft-delete) d'une demande
router.delete('/demande-conges/:id', authenticate, deleteConge);

module.exports = router;
