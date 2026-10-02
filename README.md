# GRH — Gestion des Ressources Humaines

Application **full-stack** de gestion des ressources humaines : utilisateurs et
rôles, dossiers du personnel, congés (avec circuit de validation), présences,
évaluations, notes de service et **notifications temps réel**.

> **Backend** : Node.js · Express · Sequelize · PostgreSQL · JWT · Socket.IO ·
> node-cron · Resend/nodemailer (e-mails) · multer (upload) · helmet.
> **Frontend** : React 18 · Vite · CoreUI Free React Admin · Redux ·
> FullCalendar · Chart.js · Formik/Yup · socket.io-client.

---

## 1. Fonctionnalités

- **Authentification & rôles** : `Admin`, `Chef`, `Directrice`, `Gardien`,
  `Utilisateur` (guards de routes dédiés côté frontend).
- **Dossiers du personnel** : informations identité, professionnelles, bancaires
  et complémentaires ; diplômes, distinctions, sanctions, postes antérieurs,
  mutations, pièces jointes.
- **Congés** : demande, puis **circuit de validation** (Chef → Directrice) ;
  décompte automatique des jours.
- **Présences** (fiches de présence) et **évaluations**.
- **Notifications** temps réel **Socket.IO** + *cron* mensuel d'incrément des
  jours de congés.
- **Réinitialisation de mot de passe** par e-mail.
- **Tableau de bord** (graphiques) et calendrier (FullCalendar).

---

## 2. Structure

```text
repository_2/
├── index.js                 # Entrée Express : routes, Socket.IO, Sequelize, helmet, CORS
├── db.js                    # Sequelize (PostgreSQL via DATABASE_URL, SSL)
├── package.json
├── .env                     # PORT, DATABASE_URL, FRONTEND_URL, JWT_SECRET, ...
├── controllers/             # utilisateur, dossier, demandeConges, presence,
│                            # evaluation, notification
├── cronjob/
│   └── conguesCron.js       # « 0 0 1 * * » : +2 jours de congés / mois
├── routes/
│   ├── utilisateurRoutes.js # /api/users : register, login, CRUD, reset password
│   ├── dossierRoutes.js · congeRoutes.js · presenceRoutes.js
│   ├── evaluationRoute.js · notificationRoute.js
│   └── userProfileRoute.js  # upload de fichiers
├── models/                  # Sequelize (voir ci-dessous)
├── lib/
│   └── resend.js            # Envoi d'e-mails (Resend)
├── utils/
│   ├── auth.js              # JWT + bcrypt
│   └── socket.js            # Initialisation Socket.IO
└── frontend/                # Application React (CoreUI Admin, Vite)
    ├── package.json
    └── src/
        ├── App.js · routes.js
        ├── AdminRoute.js · ChefRoute.js · DirectriceRoute.js
        │   · SecuriteRoute.js · UserRoute.js      # guards par rôle
        ├── layout/            # DefaultLayout, DirectriceLayout, GardienLayout, ...
        ├── components/        # header, sidebar, breadcrumb, footer
        ├── views/comp/        # CongeComponents, DossierComponents, dashboards...
        ├── _nav*.js           # menus par rôle
        └── assets/
```

---

## 3. Modèles de données (Sequelize)

`utilisateur`, `userProfile`, `dossier`, `infoIdent`, `infoPro`, `infoBank`,
`infoComplementaire`, `diplome`, `distinction`, `sanction`, `posteAnterieur`,
`detailsMutation`, `demandeConge`, `fichePresence`, `notification`,
`piece_jointe`, `association` (définition des relations).

---

## 4. Prérequis

- **Node.js** ≥ 18 et npm
- **PostgreSQL** ≥ 13

---

## 5. Configuration (`.env`)

```env
PORT=3003
DATABASE_URL=postgres://user:password@localhost:5432/db_pgdp
FRONTEND_URL=http://localhost:3001
JWT_SECRET=change_me
```

> ⚠️ Le fichier `.env` **versionné** contient des identifiants réels → à retirer
> du dépôt et régénérer (voir §8).

---

## 6. Installation & exécution

### Backend

```bash
npm install
node index.js       # http://localhost:3003
```

Au démarrage : `sequelize.authenticate()` puis `sequelize.sync({ alter: true })`
et programmation de la tâche *cron* des congés.

### Frontend

```bash
cd frontend
npm install
npm start           # Vite (serveur de développement)
npm run build       # build de production
```

---

## 7. API REST

| Préfixe | Domaine |
|---|---|
| `/api/users` | Utilisateurs (register, login, CRUD, reset password) |
| `/api/dossiers` | Dossiers du personnel |
| `/api` | Congés (`congeRoutes`) |
| `/api/presences` | Fiches de présence |
| `/api/notifications` | Notifications |
| `/api/evaluations` | Évaluations |

**Exemple — authentification** (`/api/users`) :

| Méthode | Route | Description |
|---|---|---|
| `POST` | `/register` | Créer un utilisateur (`matricule`, `password`, `role`) |
| `POST` | `/login` | Connexion → renvoie un JWT, le rôle, l'`id_user` |
| `GET` | `/` | Lister les utilisateurs |
| `PUT` / `DELETE` | `/:id` | Mettre à jour / supprimer |
| `POST` | `/request-reset` | Envoyer un lien de réinitialisation |
| `POST` | `/reset-password/:token` | Réinitialiser le mot de passe |

---

## 8. Points d'attention / pistes d'amélioration

- **Sécurité** :
  - le fichier **`.env` est versionné** avec des identifiants PostgreSQL réels →
    à supprimer du dépôt, révoquer les mots de passe et utiliser des variables
    d'environnement côté hébergeur ;
  - la clé JWT est codée en dur (`utils/auth.js`) ;
  - le *reset password* embarque des identifiants SMTP en clair dans le
    contrôleur → à déplacer dans `.env`.
- **CORS/Socket.IO** : Socket.IO autorise `origin: '*'` → à restreindre.
- **Migrations** : `sequelize.sync({ alter: true })` modifie le schéma au
  démarrage → préférer des migrations versionnées en production.
- **Cohérence des secrets** : vérifier l'unicité de la clé de signature JWT entre
  la génération et la vérification des jetons.
- Nettoyer le dépôt des dossiers générés (`frontend/dist`, `node_modules`).

