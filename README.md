# GRH — API Backend (Gestion des Ressources Humaines)

API **REST** de l'application **GRH (Gestion des Ressources Humaines)** :
authentification JWT, dossiers du personnel, congés, présences, évaluations,
notifications temps réel et sauvegardes planifiées.

> **Stack** : Node.js · Express · Sequelize · PostgreSQL · JWT · Socket.IO ·
> node-cron · Bcrypt · Morgan · Nodemailer · Multer.

> ℹ️ Ce dépôt ne contient que le **backend**. L'interface d'administration React
> correspondante est dans le dépôt **`grh-web`** (les deux proviennent de la
> scission de l'ancien dépôt `repository_2`, historique préservé via
> `git subtree split`).

---

## 1. Fonctionnalités

- **Authentification** : inscription, connexion, rôles
  (`Admin`, `Chef`, `Directrice`, `Gardien`, `Utilisateur`) + mot de passe oublié.
- **Dossiers du personnel** : identité, informations professionnelles,
  bancaires, complémentaires ; diplômes, distinctions, sanctions, postes
  antérieurs, mutations, pièces jointes.
- **Congés** : demande et circuit de validation (Chef → Directrice).
- **Présences** et **évaluations**.
- **Utilisateurs**, **documents**, **notifications** et **utilitaires**.
- **Notifications temps réel** via **Socket.IO**.
- **Sauvegardes planifiées** avec `node-cron`.

---

## 2. Structure

```text
├── index.js                 # point d'entrée : app, Socket.IO, cron
├── server.js                # création HTTP + WebSocket + uploads
├── db.js                    # connexion Sequelize / PostgreSQL
├── .env                     # configuration (NON versionné)
│
├── auth/                    # routes & contrôleurs d'authentification (JWT)
├── controllers/             # Conge, Dossier, Evalue, FichePresence, Utilisateur, UploadFile
├── routes/                  # express.Router : /user, /dossier, /conge, /evalue, ...
├── models/                  # Sequelize : Utilisateurs, Dossiers, Conges, ...
├── utils/                   # mailer, signatures, environnements
├── cronjob/                 # tâches planifiées (sauvegardes)
├── lib/                     # utilitaires partagés
│
└── uploads/                 # fichiers envoyés (ignoré par Git)
```

---

## 3. Prérequis

- **Node.js** ≥ 18
- **PostgreSQL** ≥ 12 accessible
- Variable d'environnement `PGDATABASE` (et `PGUSER`, `PGPASSWORD`, `PGHOST`)

---

## 4. Installation & exécution

```bash
npm install
npm start        # démarre le serveur
npm test         # tests (si configurés)
```

### Configuration (`.env`)

Créer un fichier **`.env`** local — il est **ignoré par Git** (voir
`.gitignore`) : ne jamais y committer de secrets.

```env
PGDATABASE=grh
PGUSER=postgres
PGPASSWORD=...
PGHOST=localhost
```

---

## 5. Points d'attention

- Les routes montées dans `index.js` sont préfixées par leur chemin
  (ex. `app.use("/user", ...)`).
- `uploads/` reçoit les pièces jointes : il est ignoré par Git mais doit exister
  sur le disque.
- Les chemins d'accès aux documents utilisent `process.env` — les définir dans
  `.env` selon l'environnement (dev / prod).
- ⚠️ **Dépendances** : GitHub indique des vulnérabilités connues dans
  `package.json` — mettre à jour via `npm audit fix` après installation.