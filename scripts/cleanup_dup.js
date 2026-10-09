// scripts/cleanup_dup.js — PHASE A : supprime les contraintes fantômes générées
// par sync({ alter: true }) (~568 UNIQUE sur `utilisateur`, FK multiples sur
// `dossier`), sans toucher aux données. À lancer UNE fois sur la base propre.
require('dotenv').config();
const sequelize = require('../db');

(async () => {
  await sequelize.authenticate();

  // A1. Contraintes UNIQUE dupliquées sur utilisateur : on supprime la
  // CONTRAINTE (son index suit automatiquement), en gardant l'originale.
  const cons = await sequelize.query(
    `SELECT conname FROM pg_constraint
      WHERE conrelid = 'utilisateur'::regclass AND contype = 'u'
        AND conname ~ '^utilisateur_matricule_key[0-9]+$'
      ORDER BY conname`,
    { type: 'SELECT' }
  );
  let dropU = 0;
  for (const { conname } of cons) {
    await sequelize.query(`ALTER TABLE utilisateur DROP CONSTRAINT IF EXISTS "${conname}"`);
    dropU += 1;
  }

  // A2. FK dupliquées sur dossier (…_fkey, …_fkey1, …) : garder la première.
  const fks = await sequelize.query(
    `SELECT conname FROM pg_constraint
      WHERE contype = 'f' AND conrelid = 'dossier'::regclass
      ORDER BY conname`,
    { type: 'SELECT' }
  );
  const vues = new Set();
  let dropFk = 0;
  for (const { conname } of fks) {
    const base = conname.replace(/\d+$/, '');
    if (vues.has(base)) {
      await sequelize.query(`ALTER TABLE dossier DROP CONSTRAINT IF EXISTS "${conname}"`);
      dropFk += 1;
    } else {
      vues.add(base);
    }
  }

  // A3. Index propres si absents.
  await sequelize.query(
    'CREATE UNIQUE INDEX IF NOT EXISTS uq_utilisateur_matricule ON utilisateur (matricule)'
  );
  await sequelize.query(
    'CREATE UNIQUE INDEX IF NOT EXISTS uq_utilisateur_email ON utilisateur (email)'
  );

  console.log(`NETTOYAGE OK : ${dropU} contraintes UNIQUE et ${dropFk} FK dupliquées supprimés.`);
  await sequelize.close();
  process.exit(0);
})().catch(async (e) => {
  console.error('NETTOYAGE ÉCHEC :', e.message);
  try { await sequelize.close(); } catch (e2) { /* noop */ }
  process.exit(1);
});
