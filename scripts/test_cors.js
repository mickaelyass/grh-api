// scripts/test_cors.js — vérifie les en-têtes CORS pour un jeu d'origines.
// Usage : node scripts/test_cors.js   (API lancée sur PORT)
require('dotenv').config();

const BASE = `http://localhost:${process.env.PORT || 3003}`;
const origines = [
  'http://localhost:3000',
  'http://localhost:3001',
  'http://localhost:4173',
  'https://grh-web.vercel.app',
  'https://evil.example.com',
];

(async () => {
  let ko = 0;
  for (const origin of origines) {
    const r = await fetch(`${BASE}/api/dossiers`, {
      method: 'OPTIONS',
      headers: { Origin: origin, 'Access-Control-Request-Method': 'GET' },
    });
    const ac = r.headers.get('access-control-allow-origin');
    const estLocale = /^https?:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origin);
    const autorisees = process.env.FRONTEND_URL
      ? process.env.FRONTEND_URL.split(',').map((s) => s.trim())
      : [];
    const enProd = process.env.NODE_ENV === 'production';
    // En prod : seule FRONTEND_URL compte. En dev : origines locales toujours
    // acceptées (cf. utils/origines.js).
    const attendu = autorisees.includes(origin) || (!enProd && estLocale);
    const ok = attendu ? ac === origin : ac === null;
    if (!ok) ko++;
    console.log(
      `${ok ? 'OK     ' : 'PROBLEME'} ${origin.padEnd(30)} ACAO=${ac ?? '(absent)'} attendu=${attendu ? origin : '(absent)'}`
    );
  }
  console.log(ko === 0 ? '\nCORS : tous les cas conformes.' : `\nCORS : ${ko} anomalie(s).`);
  process.exit(ko === 0 ? 0 : 1);
})();
