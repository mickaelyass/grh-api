// routes/presenceRoutes.js — pointage des présences.
//
// Réactivation du module : les routes n'étaient jamais montées dans index.js
// et aucune n'était protégée (n'importe qui pouvait pointerer). Droits :
//   - lecture (tableau de bord, historique) : admin, directrice, securite ;
//   - écriture (pointage) : securite d'abord, admin pour corriger.
const express = require("express");
const router = express.Router();
const { savePresence, getAllPresences, getPresencesByDate } = require('../controllers/presenceController');
const { authenticate, requireRole } = require('../utils/auth');

router.get("/", authenticate, requireRole('admin', 'directrice', 'securite'), getAllPresences);
router.get("/:date", authenticate, requireRole('admin', 'directrice', 'securite'), getPresencesByDate);
router.post("/", authenticate, requireRole('securite', 'admin'), savePresence);

module.exports = router;