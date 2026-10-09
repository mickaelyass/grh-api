const { Sequelize } = require('sequelize');
require('dotenv').config();

/**
 * Construit l'URL de connexion à la base :
 *   1. on utilise DATABASE_URL si elle est renseignée dans .env
 *   2. sinon on la reconstruit à partir de DB_HOST / DB_PORT / DB_USER / DB_PASSWORD / DB_NAME
 */
function buildDatabaseUrl() {
  if (process.env.DATABASE_URL && process.env.DATABASE_URL.trim() !== '') {
    // on enlève d'éventuels guillemets ou espaces parasites du .env
    return process.env.DATABASE_URL.trim().replace(/^["']|["']$/g, '');
  }

  const {
    DB_USER,
    DB_PASSWORD = '',
    DB_HOST = 'localhost',
    DB_PORT = '5432',
    DB_NAME,
  } = process.env;

  if (!DB_USER || !DB_NAME) {
    throw new Error(
      'Configuration base de données incomplète : renseignez DATABASE_URL, ' +
        'ou bien DB_USER + DB_NAME (+ DB_PASSWORD / DB_HOST / DB_PORT) dans le fichier .env'
    );
  }

  return `postgres://${encodeURIComponent(DB_USER)}:${encodeURIComponent(
    DB_PASSWORD
  )}@${DB_HOST}:${DB_PORT}/${DB_NAME}`;
}

const databaseUrl = buildDatabaseUrl();

// On expose l'hôte / la base pour les logs (jamais le mot de passe !)
let dbHost = 'inconnu';
let dbName = process.env.DB_NAME || 'inconnue';
try {
  const parsed = new URL(databaseUrl);
  dbHost = parsed.hostname;
  dbName = parsed.pathname.replace(/^\//, '') || dbName;
} catch (e) {
  /* DATABASE_URL non parsable : on garde les valeurs par défaut */
}

// SSL uniquement pour une base DISTANTE (Render, Neon...).
// En local (localhost / 127.0.0.1) forcer le SSL provoque des erreurs ou des
// ralentissements inutiles. Surchargeable avec DB_SSL=true dans le .env.
const isLocalHost = ['localhost', '127.0.0.1', '::1'].includes(dbHost);
const useSsl =
  process.env.DB_SSL !== undefined
    ? process.env.DB_SSL === 'true'
    : !isLocalHost;

const sequelize = new Sequelize(databaseUrl, {
  dialect: process.env.DB_DIALECT || 'postgres',
  logging: false,
  dialectOptions: useSsl
    ? {
        ssl: {
          require: true,
          rejectUnauthorized: false, // utile sur Render / hébergeurs avec certificat auto-signé
        },
      }
    : {},
  pool: {
    max: 10,
    min: 0,
    acquire: 30000,
    idle: 10000,
  },
});

// ⚠️ Correction importante : quand l'URI contient `sslmode=...` (cas de
// Supabase), Sequelize fait Object.assign(dialectOptions, pgConnectionString
// .parse(uri)) qui REMPLACE notre dialectOptions.ssl par un objet vide {}.
// pg interprète alors ssl={} comme « SSL avec vérification du certificat »
// et la connexion échoue avec "self-signed certificate in certificate chain".
// On réapplique donc notre config SSL explicite APRÈS la construction.
// NB : le connection-manager CLONE deepcopy sequelize.config à la
// construction, il faut donc corriger les DEUX copies.
const sslConfig = { require: true, rejectUnauthorized: false };
const dialectOptionsCibles = [sequelize.options.dialectOptions];
if (
  sequelize.connectionManager &&
  sequelize.connectionManager.config &&
  sequelize.connectionManager.config.dialectOptions
) {
  dialectOptionsCibles.push(sequelize.connectionManager.config.dialectOptions);
}
for (const opts of dialectOptionsCibles) {
  if (useSsl) {
    opts.ssl = { ...sslConfig };
  } else {
    // En local : on retire un éventuel ssl injecté par l'URI (DB_SSL=false gagne)
    delete opts.ssl;
  }
}

console.log(
  `[db] Connexion PostgreSQL -> hôte=${dbHost} base=${dbName} ssl=${useSsl ? 'activé' : 'désactivé'}`
);

module.exports = sequelize;
