// scripts/init_clean.js — repart d'une base PROPRE (décision validée) :
//   1. DROP SCHEMA public CASCADE (backup obligatoire : backups/backup_*.sql)
//   2. sequelize.sync() recrée le schéma des modèles (jamais d'alter:true)
//   3. migrations/020 (conformité) + 010 (index)
//   4. compte admin initial si aucun compte n'existe
// Usage : node scripts/init_clean.js
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const bcrypt = require('bcryptjs');
const sequelize = require('../db');
// Import OBLIGATOIRE : sans lui, aucun modèle n'est enregistré sur sequelize
// et sync() ne crée aucune table.
require('../models/association');

(async () => {
  await sequelize.authenticate();

  console.log('[init] 1/4 — DROP SCHEMA public (base propre)...');
  await sequelize.query('DROP SCHEMA public CASCADE');
  await sequelize.query('CREATE SCHEMA public');

  console.log('[init] 2/4 — création du schéma des modèles (sync sans alter)...');
  await sequelize.sync();

  console.log('[init] 3/4 — migrations 020_schema + 010_index...');
  try {
    await sequelize.query('CREATE EXTENSION IF NOT EXISTS pg_trgm');
  } catch (e) {
    console.warn('[init] pg_trgm indisponible :', e.message);
  }
  for (const f of ['020_schema.sql', '010_index.sql']) {
    const p = path.join(__dirname, '..', 'migrations', f);
    if (!fs.existsSync(p)) continue;
    await sequelize.query(fs.readFileSync(p, 'utf8'));
    console.log(`[init] OK ${f}`);
  }

  console.log('[init] 4/4 — compte admin initial...');
  const [[{ n }]] = await sequelize.query(
    "SELECT count(*)::int AS n FROM utilisateur WHERE role = 'admin'"
  );
  if (n === 0) {
    const hash = await bcrypt.hash(process.env.INIT_ADMIN_PASSWORD || 'Admin@2026', 10);
    await sequelize.query(
      `INSERT INTO utilisateur (matricule, email, password, role, "createdAt", "updatedAt")
       VALUES ('ADMIN001', :email, :hash, 'admin', now(), now())`,
      { replacements: { email: process.env.INIT_ADMIN_EMAIL || 'admin@grh.local', hash } }
    );
    console.log('[init] admin créé : matricule=ADMIN001 (mot de passe : INIT_ADMIN_PASSWORD ou Admin@2026)');
  } else {
    console.log(`[init] ${n} admin(s) déjà présent(s), aucun créé.`);
  }

  const idx = await sequelize.query(
    "SELECT count(*)::int AS n FROM pg_indexes WHERE schemaname='public'",
    { type: 'SELECT' }
  );
  console.log(`[init] TERMINÉ — ${idx[0].n} index (devrait être ~40, pas 596).`);
  await sequelize.close();
  process.exit(0);
})().catch(async (e) => {
  console.error('[init] ÉCHEC :', e.message);
  try { await sequelize.close(); } catch (e2) { /* noop */ }
  process.exit(1);
});
