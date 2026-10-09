// scripts/dbinfo.js — diagnostic rapide de la base (index, FK, tables)
require('dotenv').config();
const sequelize = require('../db');

(async () => {
  await sequelize.authenticate();
  const total = await sequelize.query(
    "SELECT count(*)::int AS n FROM pg_indexes WHERE schemaname='public'",
    { type: 'SELECT' }
  );
  console.log('INDEX_TOTAL', total[0].n);
  const parTable = await sequelize.query(
    "SELECT tablename, count(*)::int AS n FROM pg_indexes WHERE schemaname='public' GROUP BY 1 ORDER BY 2 DESC LIMIT 15",
    { type: 'SELECT' }
  );
  console.log(JSON.stringify(parTable, null, 1));
  const tables = await sequelize.query(
    "SELECT tablename FROM pg_tables WHERE schemaname='public' ORDER BY 1",
    { type: 'SELECT' }
  );
  console.log('TABLES', tables.map((t) => t.tablename).join(', '));
  await sequelize.close();
  process.exit(0);
})().catch((e) => { console.error('ERR', e.message); process.exit(1); });
