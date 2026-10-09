// scripts/migrate.js — applique les migrations SQL versionnées (idempotentes).
// Usage :  node scripts/migrate.js
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const sequelize = require('../db');

const FICHIERS = ['020_schema.sql', '010_index.sql'];

(async () => {
  await sequelize.authenticate();
  try {
    await sequelize.query('CREATE EXTENSION IF NOT EXISTS pg_trgm');
  } catch (e) {
    console.warn('[migrate] pg_trgm indisponible :', e.message);
  }
  for (const f of FICHIERS) {
    const chemin = path.join(__dirname, '..', 'migrations', f);
    if (!fs.existsSync(chemin)) {
      console.log(`[migrate] ignoré (absent) : ${f}`);
      continue;
    }
    console.log(`[migrate] application : ${f}`);
    await sequelize.query(fs.readFileSync(chemin, 'utf8'));
    console.log(`[migrate] OK : ${f}`);
  }
  await sequelize.close();
  process.exit(0);
})().catch(async (e) => {
  console.error('[migrate] ÉCHEC :', e.message);
  try { await sequelize.close(); } catch (e2) { /* noop */ }
  process.exit(1);
});
