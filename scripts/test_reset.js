// scripts/test_reset.js — vérifie la chaîne request-reset / reset-password
require('dotenv').config();
const BASE = `http://localhost:${process.env.PORT || 3003}`;

(async () => {
  // 1. Demande de réinitialisation (compte existant)
  let r = await fetch(`${BASE}/api/users/request-reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ matricule: process.env.TEST_RESET_MATRICULE || 'ADMIN001' }),
  });
  let j = await r.json();
  console.log('1. request-reset :', r.status, 'envoye =', j.envoye, j.envoye ? '(email envoyé)' : `(resetLink: ${j.resetLink || 'aucun'})`);
  const token = j.resetLink && j.resetLink.split('/').pop();

  // 2. Compte inexistant → même réponse (anti-énumération)
  r = await fetch(`${BASE}/api/users/request-reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ matricule: 'INEXISTANT99' }),
  });
  j = await r.json();
  console.log('2. request-reset (inexistant) :', r.status, JSON.stringify(j));

  // 3. Réinitialisation avec le token
  if (token) {
    r = await fetch(`${BASE}/api/users/reset-password/${token}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ password: 'Nouveau@2026' }),
    });
    j = await r.json();
    console.log('3. reset-password :', r.status, JSON.stringify(j));

    // 4. Login avec le NOUVEAU mot de passe
    r = await fetch(`${BASE}/api/users/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ matricule: process.env.TEST_RESET_MATRICULE || 'ADMIN001', password: 'Nouveau@2026' }),
    });
    j = await r.json();
    console.log('4. login nouveau mdp :', r.status, j.token ? 'TOKEN OK' : JSON.stringify(j));

    // 5. Ancien mot de passe doit échouer
    r = await fetch(`${BASE}/api/users/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ matricule: process.env.TEST_RESET_MATRICULE || 'ADMIN001', password: 'Admin@2026' }),
    });
    console.log('5. ancien mdp refusé :', r.status, r.status === 401 || r.status === 400 ? 'OK' : 'PROBLÈME');

    // 6. Token réutilisé → invalide (à usage unique)
    r = await fetch(`${BASE}/api/users/reset-password/${token}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ password: 'Encore@2026' }),
    });
    console.log('6. token réutilisé refusé :', r.status, r.status === 400 ? 'OK' : 'PROBLÈME');

    // 7. Restauration du mot de passe d'origine (le test ne doit pas laisser
    //    le compte dans un état différent).
    const mdp = process.env.TEST_RESET_ORIGINAL_PASSWORD || 'Admin@2026';
    r = await fetch(`${BASE}/api/users/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ matricule: process.env.TEST_RESET_MATRICULE || 'ADMIN001', password: 'Nouveau@2026' }),
    });
    if (r.status === 200) {
      const { hashPassword } = require('../utils/auth');
      const { Utilisateur } = require('../models/association');
      const u = await Utilisateur.findOne({ where: { matricule: process.env.TEST_RESET_MATRICULE || 'ADMIN001' } });
      u.password = await hashPassword(mdp);
      u.reset_token_hash = null;
      u.reset_token_expire = null;
      await u.save();
      console.log(`7. mot de passe restauré (${mdp}) : OK`);
    } else {
      console.log('7. restauration sautée (login Nouveau@2026 impossible)');
    }
  } else {
    console.log("!! Aucun resetLink dans la réponse — le lien n'est pas généré.");
  }
  process.exit(0);
})().catch((e) => { console.error('ERREUR :', e.message); process.exit(1); });
