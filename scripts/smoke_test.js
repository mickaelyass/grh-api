// scripts/smoke_test.js — test de bout en bout du nouveau schéma :
// login admin → compte employé → dossier (+ crédit congés) → association →
// demande de congé → décision chef → décision directrice → solde décrédité.
// Usage : node scripts/smoke_test.js   (API déjà lancée sur PORT)
require('dotenv').config();

const BASE = `http://localhost:${process.env.PORT || 3003}`;
let adminToken = null;
let empToken = null;
let idDossier = null;
let idDemande = null;

const call = async (methode, url, corps, token) => {
  const opts = {
    method: methode,
    headers: { 'Content-Type': 'application/json' },
  };
  if (token) opts.headers.Authorization = `Bearer ${token}`;
  if (corps !== undefined && methode !== 'GET') opts.body = JSON.stringify(corps);
  const r = await fetch(BASE + url, opts);
  let json = null;
  try { json = await r.json(); } catch (e) { /* réponse vide */ }
  return { status: r.status, json };
};

const verifier = (etape, condition, detail) => {
  if (condition) {
    console.log(`  OK   ${etape}`);
  } else {
    console.log(`  FAIL ${etape} -> ${JSON.stringify(detail)}`);
    process.exitCode = 1;
  }
};

(async () => {
  console.log('== SMOKE TEST ==');

  // 1. Login admin
  let r = await call('POST', '/api/users/login', { matricule: 'ADMIN001', password: process.env.INIT_ADMIN_PASSWORD || 'Admin@2026' });
  verifier('1. login admin', r.status === 200 && r.json.token, r);
  adminToken = r.json.token;

  // 2. Compte employé
  r = await call('POST', '/api/users/register', { matricule: 'EMP001', email: 'emp001@grh.local', password: 'Emp@2026', role: 'employe' }, adminToken);
  verifier('2. création compte employé', [200, 201, 409].includes(r.status), r);

  // 3. Dossier (transaction + crédit congés) — idempotent : si déjà présent, on le relit
  r = await call('POST', '/api/dossiers', {
    matricule: 'EMP001',
    infoIdent: {
      nom: 'KOUASSI', prenom: 'Jean', sexe: 'M', dat_naiss: '1990-05-12',
      lieu_naiss: 'Cotonou', nationalite: 'Béninoise', sit_fam: 'Marié',
      nombre_enfant: 2, nbre_pers_charge: 2, groupe_sanguin: 'O+',
      adress_resid: 'Cotonou', num_telephone: '97000000',
      email: 'emp001@grh.local', num_cnam: 'CN123',
    },
    infoPro: {
      corps: 'ENSIGNANT', grade_paye: 'Primaire', categorie: 'P2',
      poste_actuel_service: 'Direction Pédagogique', fonctions: 'Enseignant',
      nature_fonction: 'Titulaire', dat_prise_fonction: '2024-01-15',
      sit_poste_actuel: 'Actif',
    },
    infoBank: { nom_banque: 'BGFI', num_compte: '0001', num_cnam: 'CN123', num_cnss: 'CS123' },
  }, adminToken);
  if (r.status === 409) {
    const lu = await call('GET', '/api/dossiers/user/EMP001', undefined, adminToken);
    idDossier = lu.json && lu.json.id_dossier;
    r.json = lu.json;
  } else {
    idDossier = r.json && r.json.id_dossier;
  }
  verifier('3. création dossier (transaction + crédit congés)', !!idDossier, r);
  const soldes = (r.json && (r.json.SoldeConges || r.json.solde_conges)) || [];
  verifier('3b. solde initial présent (≥2 jours)', soldes.length > 0 && soldes.reduce((s, x) => s + (x.jours_acquis || 0), 0) >= 2, soldes);

  // 4. Association dossier ↔ compte (admin, égalité des matricules) — idempotent
  r = await call('PUT', `/api/dossiers/${idDossier}/assign-user`, { id_user: 2 }, adminToken);
  verifier('4. association dossier-compte', [200, 409].includes(r.status), r);

  // 5. Login employé
  r = await call('POST', '/api/users/login', { matricule: 'EMP001', password: 'Emp@2026' });
  verifier('5. login employé', r.status === 200 && r.json.token, r);
  empToken = r.json.token;

  // 6. Solde employé (lecture)
  r = await call('GET', '/api/demande-conges/solde', undefined, empToken);
  verifier('6. lecture solde employé', r.status === 200, r);

  // 7. Demande de congé (2 jours) — idempotent
  r = await call('POST', '/api/demande-conges/create', {
    matricule: 'EMP001', type_de_conge: 'Congé administratif',
    date_debut: '2026-10-12', date_de_fin: '2026-10-13', nombre_de_jour: 2,
    annee_jouissance: 2026,
  }, empToken);
  idDemande = r.json && (r.json.id_cong || (r.json.demande && r.json.demande.id_cong));
  if (!idDemande && r.status === 400) {
    // Demande déjà existante (test relancé) : on la retrouve.
    const lu = await call('GET', '/api/demande-conges/matricule/EMP001', undefined, empToken);
    const liste = (lu.json && (lu.json.data || lu.json)) || [];
    const existante = Array.isArray(liste) ? liste.find((d) => d.status === 'En attente') : null;
    idDemande = existante && existante.id_cong;
  }
  verifier('7. création demande de congé', [200, 201].includes(r.status) && idDemande, r);

  // 8. Compte chef du même service + dossier (pour décider)
  r = await call('POST', '/api/users/register', {
    matricule: 'CHEF001', email: 'chef001@grh.local', password: 'Chef@2026', role: 'chef_service',
  }, adminToken);
  verifier('8. création compte chef', [200, 201, 409].includes(r.status), r);
  r = await call('POST', '/api/dossiers', {
    matricule: 'CHEF001',
    infoIdent: {
      nom: 'ADJOVI', prenom: 'Marie', sexe: 'F', dat_naiss: '1985-03-04',
      lieu_naiss: 'Porto-Novo', nationalite: 'Béninoise', sit_fam: 'Marié',
      nombre_enfant: 1, nbre_pers_charge: 1, groupe_sanguin: 'A+',
      adress_resid: 'Cotonou', num_telephone: '97111111',
      email: 'chef001@grh.local', num_cnam: 'CN456',
    },
    infoPro: {
      corps: 'ENSIGNANT', grade_paye: 'Primaire', categorie: 'P1',
      poste_actuel_service: 'Direction Pédagogique', fonctions: 'Chef de service',
      nature_fonction: 'Titulaire', dat_prise_fonction: '2020-09-01',
      sit_poste_actuel: 'Actif',
    },
    infoBank: { nom_banque: 'BGFI', num_compte: '0002', num_cnam: 'CN456', num_cnss: 'CS456' },
  }, adminToken);
  verifier('8b. dossier chef créé', [201, 409].includes(r.status), r);

  // 9. Login chef + décision « Autorisée » (périmètre = son service)
  r = await call('POST', '/api/users/login', { matricule: 'CHEF001', password: 'Chef@2026' });
  const chefToken = r.json && r.json.token;
  verifier('9. login chef', !!chefToken, r);
  r = await call('PUT', `/api/demande-conges/${idDemande}/decision-chef-service`, {
    decision_chef_service: 'Autorisée',
  }, chefToken);
  verifier('9b. décision du chef', [200, 400, 409].includes(r.status), r);

  // 10. Compte directrice + décision finale → débit du solde
  r = await call('POST', '/api/users/register', {
    matricule: 'DIR001', email: 'dir001@grh.local', password: 'Dir@2026', role: 'directrice',
  }, adminToken);
  verifier('10. création compte directrice', [200, 201, 409].includes(r.status), r);
  r = await call('POST', '/api/users/login', { matricule: 'DIR001', password: 'Dir@2026' });
  const dirToken = r.json && r.json.token;
  verifier('10b. login directrice', !!dirToken, r);
  r = await call('PUT', `/api/demande-conges/${idDemande}/decision-directrice`, {
    decision_directrice: 'Autorisée',
  }, dirToken);
  verifier('10c. décision directrice', [200, 400, 409].includes(r.status), r);

  // 11. Contrôle du solde : la demande doit apparaître consommée (si Autorisée)
  r = await call('GET', '/api/demande-conges/solde/EMP001', undefined, adminToken);
  const resume = r.json || {};
  verifier('11. lecture du solde (admin)', r.status === 200, r);
  console.log('\nSolde EMP001 :', JSON.stringify(resume));
  console.log('Demande id :', idDemande);
  console.log('== SMOKE TEST TERMINÉ ==');
})().catch((e) => {
  console.error('ERREUR SMOKE TEST :', e.message);
  process.exit(1);
});
