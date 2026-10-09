// scripts/dupinfo.js — liste les index/FK dupliqués à nettoyer
require('dotenv').config();
const sequelize = require('../db');

(async () => {
  await sequelize.authenticate();
  const idx = await sequelize.query(
    `SELECT tablename, indexname
       FROM pg_indexes WHERE schemaname='public'
       AND tablename IN ('utilisateur','dossier')
       ORDER BY tablename, indexname LIMIT 60`,
    { type: 'SELECT' }
  );
  console.log('--- INDEX utilisateur/dossier (60 premiers) ---');
  idx.forEach((r) => console.log(r.tablename, '|', r.indexname));
  const fk = await sequelize.query(
    `SELECT conrelid::regclass AS table, conname
       FROM pg_constraint WHERE contype='f'
       AND conrelid::regclass::text IN ('utilisateur','dossier')
       ORDER BY 1, 2 LIMIT 40`,
    { type: 'SELECT' }
  );
  console.log('--- FK utilisateur/dossier ---');
  fk.forEach((r) => console.log(r.table, '|', r.conname));
  await sequelize.close();
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
