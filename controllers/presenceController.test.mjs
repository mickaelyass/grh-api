// controllers/presenceController.test.mjs — logique de normalisation des fiches.
// Usage : node controllers/presenceController.test.mjs
// Couvre normaliserFiche : la validation AVANT transaction qui garantit qu'on
// n'enregistre jamais un jour à moitié (une fiche invalide refuse le lot).
import { normaliserFiche, STATUTS } from './presenceController.js';

let ko = 0;
const check = (libelle, reel, attendu) => {
  const ok = JSON.stringify(reel) === JSON.stringify(attendu);
  if (!ok) ko++;
  console.log(`  ${ok ? 'OK  ' : 'FAIL'} ${libelle} -> ${JSON.stringify(reel)}`);
};
const leve = (fiche) => {
  try { normaliserFiche(fiche); return null; } catch (e) { return e.message; }
};

console.log('== normaliserFiche : cas valides ==');
const complet = normaliserFiche({
  matricule: ' EMP001 ', date_presence: '2026-10-10', statut: 'Présent',
  heure_arrivee: '07:55', heure_depart: '16:30', observations: '  RAS  ',
});
check('matricule trim', complet.matricule, 'EMP001');
check('statut conserve', complet.statut, 'Présent');
check('observations trim', complet.observations, 'RAS');

console.log('== normaliserFiche : vides -> null ==');
const vide = normaliserFiche({
  matricule: 'EMP002', date_presence: '2026-10-10', statut: 'Absent',
  heure_arrivee: '', heure_depart: '  ', observations: '',
});
check('heure_arrivee vide -> null', vide.heure_arrivee, null);
check('heure_depart vide -> null', vide.heure_depart, null);
check('observations vide -> null', vide.observations, null);

console.log('== normaliserFiche : rejets ==');
const sansMatricule = leve({ date_presence: '2026-10-10', statut: 'Présent' });
check('matricule manquant rejete', Boolean(sansMatricule && sansMatricule.includes('matricule')), true);
const sansDate = leve({ matricule: 'EMP001', statut: 'Présent' });
check('date manquante rejetee', Boolean(sansDate && sansDate.includes('date')), true);
const mauvaisStatut = leve({ matricule: 'EMP001', date_presence: '2026-10-10', statut: 'En vacances' });
check('statut hors ENUM rejete', Boolean(mauvaisStatut && mauvaisStatut.includes('En vacances')), true);
check('aucun rejet silencieux (message exact)', String(mauvaisStatut).includes('Présent, Absent, Retard, Permission, Congé, Maladie'), true);

console.log('== STATUTS : alignement avec le modele API ==');
check('6 statuts', STATUTS.length, 6);
check('valeurs', STATUTS, ['Présent', 'Absent', 'Retard', 'Permission', 'Congé', 'Maladie']);
// Le code du controller doit-les utiliser telles quelles (accents compris).
import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
const ici = dirname(fileURLToPath(import.meta.url));
const src = readFileSync(join(ici, 'presenceController.js'), 'utf8');
check('upsert transactionnel', src.includes('sequelize.transaction()'), true);
check('pas de Promise.all sans transaction', src.includes('await Promise.all('), false);
check('socket best-effort (try/catch)', src.includes("catch (e) { /* socket optionnel */ }"), true);

console.log(ko === 0 ? '\n✅ TOUS LES TESTS PASSENT' : `\n❌ ${ko} ECHEC(S)`);
process.exit(ko === 0 ? 0 : 1);