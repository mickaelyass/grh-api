const cron = require('node-cron');
const { crediterTousLesAgents, reporterAnnee } = require('../services/soldeService');

/**
 * Planification des congés :
 *  - quotidien 03:05 : crédit de rattrapage idempotent (+2 jours/mois à partir
 *    du mois de `dat_prise_fonction`). Idempotent = relancer n'a aucun effet
 *    de bord : un mois n'est crédité qu'une fois (table acquittement_cron) ;
 *  - 1er janvier 00:10 : report du solde restant de N-1 vers N
 *    (contrepartie jours_transferes : le total est conservé, jamais doublé).
 */
const executer = async (libelle, tache) => {
  try {
    const r = await tache();
    console.log(`[conges-cron] ${libelle} OK :`, JSON.stringify(r));
  } catch (err) {
    console.error(`[conges-cron] ${libelle} ERREUR :`, err.message);
  }
};

const planifierCronConges = () => {
  // Crédit mensuel : le 1er jour du mois à minuit.
  cron.schedule('0 0 1 * *', () =>
    executer('crédit mensuel', () => crediterTousLesAgents({ auteur: 'CRON' })));

  // Rattrapage quotidien : garantit l'absence de dérive si un run a échoué.
  cron.schedule('5 3 * * *', () =>
    executer('crédit de rattrapage', () => crediterTousLesAgents({ auteur: 'CRON' })));

  // Report annuel : le 1er janvier à 00:10 (avant les crédits de janvier).
  cron.schedule('10 0 1 1 *', () => {
    const anneePrecedente = new Date().getFullYear() - 1;
    return executer(`report annuel ${anneePrecedente}`, () => reporterAnnee(anneePrecedente));
  });

  console.log('[conges-cron] Tâches Cron pour les congés programmées.');
};

module.exports = { planifierCronConges };
