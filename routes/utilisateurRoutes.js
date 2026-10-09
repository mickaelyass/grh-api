// routes/utilisateurRoutes.js — comptes (login public, gestion admin)
const express = require('express');
const router = express.Router();
const utilisateurController = require('../controllers/utilisateurController');
const { authenticate, requireRole } = require('../utils/auth');

// Public : connexion + mot de passe oublié
router.post('/login', utilisateurController.login);
router.post('/request-reset', utilisateurController.requestReset);
router.post('/reset-password/:token', utilisateurController.resetPassword);

// Création et gestion des comptes : admin uniquement
router.post('/register', authenticate, requireRole('admin'), utilisateurController.register);
router.get('/', authenticate, requireRole('admin'), utilisateurController.getAll);
router.get('/:id', authenticate, requireRole('admin'), utilisateurController.getById);
router.put('/:id', authenticate, utilisateurController.update); // soi-même ou admin (voir contrôleur)
router.delete('/:id', authenticate, requireRole('admin'), utilisateurController.delete);

module.exports = router;
