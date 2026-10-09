require('dotenv').config(); // Charger le fichier .env
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const http = require('http');
const path = require('path');
const sequelize = require('./db');
const utilisteurRoutes = require('./routes/utilisateurRoutes');
const dossierRoutes = require('./routes/dossierRoutes');
const congeRoutes = require('./routes/congeRoutes');
const uploadRouter = require('./routes/userProfileRoute');
const notificationRoutes = require('./routes/notificationRoute');
const evaluationRoutes = require('./routes/evaluationRoute');
const fs = require('fs');
const { init: initSocket } = require('./utils/socket');
const { originesAutorisees } = require('./utils/origines');
const { planifierCronConges } = require('./cronjob/congesCron');

const app = express();

// En-têtes de sécurité (CSP désactivée : l'API sert PDF/images au frontend
// via /doc et /uploads ; CORP cross-origin pour autoriser le chargement).
app.use(
  helmet({
    contentSecurityPolicy: false,
    crossOriginResourcePolicy: { policy: 'cross-origin' },
  })
);

// ... reste de tes middlewares (express.json, cors, etc.)
const server = http.createServer(app);

// Middleware
app.use(express.json({ limit: '100mb' }));
app.use(express.urlencoded({ limit: '100mb', extended: true }));
// Origines CORS : FRONTEND_URL (une ou plusieurs, séparées par des virgules).
// Aucune valeur en dur — voir utils/origines.js.
const origines = originesAutorisees();
console.log('CORS — origines autorisées:', origines.join(', '));
app.use(
  cors({
    origin: origines,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
  })
);

// Static Files
app.use('/uploads', express.static(path.join(__dirname, 'frontend/public/uploads')));
app.use('/doc', express.static(path.join(__dirname, 'frontend/public/doc')));

// Socket.io
initSocket(server);

// Routes
app.use('/api', uploadRouter);
app.use('/api/users', utilisteurRoutes);
app.use('/api/dossiers', dossierRoutes);
app.use('/api', congeRoutes);
app.use('/api/notifications', notificationRoutes);
app.use('/api/evaluations', evaluationRoutes);



// Synchronisation avec la base de données et démarrage du serveur
const port = process.env.PORT ;
const dbName = process.env.DB_NAME;
console.log('Nom de la base de données:', dbName,port);

// Index additionnels (idempotents : CREATE INDEX IF NOT EXISTS).
const appliquerIndex = async () => {
  const chemin = path.join(__dirname, 'migrations', '010_index.sql');
  if (!fs.existsSync(chemin)) return;
  const sql = fs.readFileSync(chemin, 'utf8');
  await sequelize.query(sql);
};

server.listen(port, () => {
  console.log(`Serveur en cours d'exécution sur le port ${port}.`);

  // Connexion à la base de données APRÈS le démarrage du serveur
  sequelize.authenticate()
    .then(() => {
      console.log('Connexion à la base de données établie avec succès.');
      // JAMAIS d'`alter: true` : l'historique sync({alter:true}) a généré des
      // centaines d'index/FK dupliqués. sync() crée les tables manquantes sans
      // modifier le schéma existant ; les migrations/ sont la référence.
      return sequelize.sync();
    })
    .then(() => appliquerIndex())
    .then(() => {
      console.log('Base de données synchronisée (index inclus).');
      planifierCronConges();
    })
    .catch((err) => {
      console.error('Erreur de base de données :', err.message);

      // Message d'aide ciblé quand PostgreSQL n'est simplement pas démarré
      if (err.name === 'SequelizeConnectionRefusedError') {
        const address = err.parent?.address || '127.0.0.1';
        const port = err.parent?.port || process.env.DB_PORT || 5432;
        console.error(
          `\n👉 Aucune instance PostgreSQL n'écoute sur ${address}:${port}.`
        );
        console.error('   Démarrez le service, puis relancez le serveur :');
        console.error('     sudo systemctl start postgresql      # démarre la base');
        console.error('     sudo systemctl enable postgresql     # démarre aussi au boot');
        console.error('\n   Vérification :  pg_lsclusters   (doit afficher "online")');
        console.error('   Le serveur Node reste démarré, il suffit de le relancer pour reconnecter la base.');
      }

      if (err.parent) {
        console.error('Détail technique :', err.parent.code || err.parent.message);
      }
    });
});
  
