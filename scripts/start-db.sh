#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Démarre PostgreSQL (cluster 16/main sur le port 5432) et vérifie la connexion
# Utilisation :  bash scripts/start-db.sh
# ---------------------------------------------------------------------------
set -uo pipefail

# On se place à la racine du projet pour que dotenv trouve le .env
cd "$(dirname "$0")/.."

echo "==> Etat du cluster avant démarrage :"
pg_lsclusters || true

echo
echo "==> Démarrage de PostgreSQL (mot de passe sudo demandé)..."
if ! sudo systemctl start postgresql; then
  echo "!! 'systemctl start postgresql' a échoué, tentative avec pg_ctlcluster..."
  sudo pg_ctlcluster 16 main start || {
    echo "!! Impossible de démarrer PostgreSQL. Consultez : /var/log/postgresql/postgresql-16-main.log"
    exit 1
  }
fi

# La base doit aussi redémarrer automatiquement après un reboot
sudo systemctl enable postgresql >/dev/null 2>&1

echo
echo "==> Attente de l'ouverture du port 5432..."
for i in $(seq 1 30); do
  if pg_isready -h 127.0.0.1 -p 5432 >/dev/null 2>&1; then
    echo "    PostgreSQL accepte les connexions (après ${i}s)."
    break
  fi
  sleep 1
done

echo
echo "==> Etat du cluster après démarrage :"
pg_lsclusters || true

echo
echo "==> Test de connexion avec les identifiants du .env :"
node -e "require('dotenv').config(); const s=require('./db'); s.authenticate().then(()=>{console.log('OK : connexion à la base établie.'); return s.close();}).catch(e=>{console.error('ECHEC :', e.message); process.exit(1);});"
