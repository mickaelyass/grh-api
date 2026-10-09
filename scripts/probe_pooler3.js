// scripts/probe_pooler3.js — reteste les hôtes « timeout » du probe 2 avec un
// timeout plus long (TLS lent), username postgres.<ref>.
require('dotenv').config();
const { Client } = require('pg');

const REF = 'ghilpdgpfiuqyfljqqpo';
const m = process.env.DATABASE_URL.match(/:\/\/[^:]+:(.*)@/);
const PWD = m[1];
const PWDs = [PWD, PWD.replace(/^\[|\]$/g, '')];

const HOSTS = [
  'aws-0-us-east-1', 'aws-0-us-west-2', 'aws-0-eu-central-1', 'aws-0-ca-central-1',
  'aws-1-us-east-1', 'aws-1-us-east-2', 'aws-1-eu-central-1', 'aws-1-ap-northeast-2',
  'aws-1-ca-central-1', 'aws-1-sa-east-1',
].map(h => `${h}.pooler.supabase.com`);

const essai = async (host, pwd) => {
  const c = new Client({
    host, port: 5432, user: `postgres.${REF}`, password: pwd, database: 'postgres',
    ssl: { rejectUnauthorized: false },
    connectionTimeoutMillis: 12000,
    statement_timeout: 8000,
  });
  await c.connect();
  const r = await c.query('SELECT current_database(), current_user');
  await c.end();
  return r.rows[0];
};

(async () => {
  for (const host of HOSTS) {
    for (const pwd of PWDs) {
      try {
        const info = await essai(host, pwd);
        console.log(`SUCCESS ${host} -> db=${info.current_database} user=${info.current_user}`);
        process.exit(0);
      } catch (e) {
        const label = pwd === PWD ? 'brut' : 'sans-crochets';
        console.log(`fail ${host} [${label}] -> ${e.message}`);
        if ((e.message || '').includes('tenant/user')) break; // même hôte : inutile de réessayer
      }
    }
  }
  console.log('AUCUN GAGNANT');
  process.exit(1);
})();