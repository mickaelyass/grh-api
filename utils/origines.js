// utils/origines.js — origine(s) du frontend acceptée(s) par CORS et utilisées
// pour les liens sortants (reset-password).
//
// Source unique de vérité : la variable FRONTEND_URL. Elle accepte UNE ou
// PLUSIEURS origines séparées par des virgules, sans slash final :
//
//   FRONTEND_URL=https://grh-web.onrender.com
//   FRONTEND_URL=https://grh-web.onrender.com,http://localhost:3000,http://localhost:3001
//
// ⚠️ Aucune origine n'est écrite en dur ici : si FRONTEND_URL est absent on
//    retombe sur les origines de développement locales, et un warning est loggé
//    pour rendre le problème visible au démarrage (cf. index.js).

// Origines de repli (dev local uniquement — jamais en production).
const ORIGINES_DEV = [
  'http://localhost:3000',
  'http://localhost:3001',
  'http://localhost:4173',
];

const nettoyer = (origine) => origine.trim().replace(/\/+$/, '');

// Liste complète des origines autorisées (tableau, format attendu par `cors`).
const originesAutorisees = () => {
  const brut = process.env.FRONTEND_URL || '';
  const configurees = brut.split(',').map(nettoyer).filter(Boolean);

  if (process.env.NODE_ENV === 'production') {
    if (!configurees.length) {
      console.warn(
        '⚠️  FRONTEND_URL est absent : CORS n\'accepte que les origines de dev ' +
        `(${ORIGINES_DEV.join(', ')}). Le front déployé sera bloqué.`
      );
      return ORIGINES_DEV;
    }
    return configurees;
  }

  // En dev : FRONTEND_URL + les origines locales, pour que le port réellement
  // occupé par le front (3000, 3001, 4173...) ne déclenche jamais de blocage.
  // Le localhost ne peut pas être usurpé par un site distant : sans risque.
  return [...new Set([...configurees, ...ORIGINES_DEV])];
};

// Base des liens sortants (emails) : on choisit de préférence l'origine de
// production, et à défaut la première origine déclarée.
const baseFront = () => {
  const liste = originesAutorisees();
  const prod = liste.find((o) => !/^https?:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/i.test(o));
  return prod || liste[0];
};

module.exports = { originesAutorisees, baseFront };
