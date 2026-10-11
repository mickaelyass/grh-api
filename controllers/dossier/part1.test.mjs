// controllers/dossier/part1.test.mjs — gardes de creteDossier.
// Usage : node controllers/dossier/part1.test.mjs
//
// On ne crée RIEN en base : on remplace (monkey-patch) les méthodes des modèles
// singletons par des stubs, puis on vérifie que le contrôleur REFUSE dans les
// trois cas où un dossier ne doit pas voir le jour :
//   · 400 — champs requis manquants
//   · 409 — un dossier existe déjà pour ce matricule
//   · 404 — aucun utilisateur pour ce matricule (dossier « fantôme »)
// Ces trois branches sortent AVANT toute écriture, donc aucun stub de création
// (crediterJusqua, socket…) n'est nécessaire.
import assert from 'node:assert';
import sequelize from '../../db.js';
import { Dossier, Utilisateur } from '../../models/association.js';
import { creteDossier } from './part1.js';

let ko = 0;
const check = (libelle, reel, attendu) => {
  const ok = reel === attendu;
  if (!ok) ko++;
  console.log(`  ${ok ? 'OK  ' : 'FAIL'} ${libelle} -> ${reel}`);
};

// Faux `res` express chaînable qui capture status + payload.
const fakeRes = () => {
  const r = { statusCode: null, body: null };
  r.status = (c) => { r.statusCode = c; return r; };
  r.json = (b) => { r.body = b; return r; };
  return r;
};

// Faux objet de transaction (jamais utilisé en écriture dans ces branches).
const fakeTx = { __tx: true, rollback: async () => {}, commit: async () => {} };

// Sauvegarde les vraies méthodes pour tout restaurer à la fin.
const vrais = {
  tx: sequelize.transaction,
  dFindOne: Dossier.findOne,
  uFindOne: Utilisateur.findOne,
};

const bodyComplet = {
  matricule: 'EMP002',
  infoIdent: { nom: 'A' },
  infoPro: { fonctions: 'X' },
  infoBank: { rib: 'Y' },
};

async function run(reqBody, { dossierExiste = false, userExiste = true } = {}) {
  sequelize.transaction = async () => fakeTx;
  Dossier.findOne = async () => (dossierExiste ? { id_dossier: 1 } : null);
  Utilisateur.findOne = async () => (userExiste ? { id_user: 1, matricule: reqBody.matricule } : null);
  const res = fakeRes();
  await creteDossier({ body: reqBody, user: { matricule: 'ADMIN001' } }, res);
  return res;
}

try {
  console.log('== creteDossier : gardes (aucune création) ==');

  // 400 — champs requis manquants.
  let r = await run({ matricule: 'EMP002' });
  check('champs manquants -> 400', r.statusCode, 400);

  // 409 — dossier déjà existant.
  r = await run(bodyComplet, { dossierExiste: true });
  check('dossier existant -> 409', r.statusCode, 409);

  // 404 — aucun utilisateur pour ce matricule (le bug « dossier fantôme »).
  r = await run(bodyComplet, { userExiste: false });
  check('utilisateur inexistant -> 404', r.statusCode, 404);
  check('message 404 explicite', Boolean(r.body?.error?.includes('Aucun utilisateur')), true);

  // Ordre des gardes : le doublon de dossier est vérifié AVANT l'utilisateur,
  // donc un matricule à la fois en doublon ET sans user renvoie 409 (pas 404).
  r = await run(bodyComplet, { dossierExiste: true, userExiste: false });
  check('doublon prioritaire sur user absent -> 409', r.statusCode, 409);
} finally {
  // Restauration systématique, même en cas d'échec d'assertion interne.
  sequelize.transaction = vrais.tx;
  Dossier.findOne = vrais.dFindOne;
  Utilisateur.findOne = vrais.uFindOne;
}

console.log(ko === 0 ? '\n✅ TOUS LES TESTS PASSENT' : `\n❌ ${ko} ECHEC(S)`);
process.exit(ko === 0 ? 0 : 1);
