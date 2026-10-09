// controllers/dossierController.js — point d'entrée unique (ancien module
// monolithique découpé en `controllers/dossier/` : helpers + part1..part5).
// Les routes continuent d'importer CE fichier : `require('../controllers/dossierController.js')`.
module.exports = {
  ...require('./dossier/part1'),
  ...require('./dossier/part2'),
  ...require('./dossier/part3'),
  ...require('./dossier/part4'),
  ...require('./dossier/part5'),
};
