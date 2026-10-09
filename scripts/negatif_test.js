// scripts/negatif_test.js — tests de SÉCURITÉ (doivent tous être REFUSÉS) :
//   A. sans token → 401 sur chaque route protégée
//   B. employé → 403 sur la création de dossier et la création de compte
//   C. employé → 403 sur le dossier d'un autre agent
//   D. employé → 403 sur la décision de congé
//   E. matricule modifié → 400 (immuabilité)
// Usage : node scripts/negatif_test.js
require('dotenv').config();

const BASE = `http://localhost:${process.env.PORT || 3003}`;

const call = async (methode, url, corps, token) => {
  const opts = { method: methode, headers: { 'Content-Type': 'application/json' } };
  if (token) opts.headers.Authorization = `Bearer ${token}`;
  if (corps !== undefined && methode !== 'GET') opts.body = JSON.stringify(corps);
  const r = await fetch(BASE + url, opts);
  let json = null;
  try { json = await r.json(); } catch (e) { /* vide */ }
  return { status: r.status, json };
};

let echecs = 0;
const refuse = (etape, condition, detail) => {
  if (condition) console.log(`  OK   ${etape}`);
  else { console.log(`  FAIL ${etape} -> ${JSON.stringify(detail)}`); echecs += 1; }
};

(async () => {
  console.log('== TESTS NÉGATIFS ==');

  // A. Sans token → 401 attendu
  for (const url of ['/api/dossiers', '/api/dossiers/search', '/api/demande-conges', '/api/users']) {
    const r = await call('GET', url);
    refuse(`A. 401 sans token ${url}`, r.status === 401, r);
  }

  // Tokens (EMP001 : mot de passe potentiellement changé par scripts/test_reset.js)
  const adm = await call('POST', '/api/users/login', { matricule: 'ADMIN001', password: process.env.INIT_ADMIN_PASSWORD || 'Admin@2026' });
  let emp = await call('POST', '/api/users/login', { matricule: 'EMP001', password: 'Emp@2026' });
  if (emp.status !== 200) emp = await call('POST', '/api/users/login', { matricule: 'EMP001', password: 'Nouveau@2026' });
  const empToken = emp.json && emp.json.token;
  refuse('B0. logins', !!adm.json.token && !!empToken, { adm: adm.status, emp: emp.status });

  // B. Employé ne crée ni dossier ni compte
  let r = await call('POST', '/api/dossiers', { matricule: 'X', infoIdent: {}, infoPro: {}, infoBank: {} }, empToken);
  refuse('B. 403 employé crée un dossier', r.status === 403, r);
  r = await call('POST', '/api/users/register', { matricule: 'HACK', email: 'h@x.co', password: 'Xx@123456', role: 'admin' }, empToken);
  refuse('B2. 403 employé crée un compte admin', r.status === 403, r);

  // C. Employé : dossier d'un autre agent → 403 (dossier CHEF001 existe)
  r = await call('GET', '/api/dossiers/user/CHEF001', undefined, empToken);
  refuse('C. 403 employé lit le dossier d un autre', r.status === 403, r);
  r = await call('GET', '/api/dossiers/user/EMP001', undefined, empToken);
  refuse('C2. 200 employé lit SON dossier', r.status === 200, r);

  // D. Employé ne décide pas des congés
  r = await call('PUT', '/api/demande-conges/1/decision-chef-service', { decision_chef_service: 'Autorisée' }, empToken);
  refuse('D. 403 employé décide (chef)', r.status === 403, r);
  r = await call('PUT', '/api/demande-conges/1/decision-directrice', { decision_directrice: 'Autorisée' }, empToken);
  refuse('D2. 403 employé décide (directrice)', r.status === 403, r);

  // E. Matricule immuable
  const lu = await call('GET', '/api/dossiers/user/EMP001', undefined, adm.json.token);
  r = await call('PUT', `/api/dossiers/${lu.json.id_dossier}`, { matricule: 'VOLÉ' }, adm.json.token);
  refuse('E. 400 matricule immuable', r.status === 400, r);

  console.log(echecs === 0 ? '\n== TOUS LES TESTS NÉGATIFS PASSENT ==' : `\n== ${echecs} ÉCHEC(S) ==`);
  process.exit(echecs === 0 ? 0 : 1);
})().catch((e) => {
  console.error('ERREUR :', e.message);
  process.exit(1);
});
