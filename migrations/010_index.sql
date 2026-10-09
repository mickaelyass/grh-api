-- migrations/010_index.sql
-- Index de performance — idempotents (CREATE ... IF NOT EXISTS).
-- Exécuté automatiquement au démarrage de l'API (index.js, après sync) et
-- manuellement :  psql -d db_pgdp -f migrations/010_index.sql
--
-- NOTE : pg_trgm est créé à part par index.js (tolérance aux droits manquants).

-- ---------------------------------------------------------------------------
-- Congés : recherches et listes fréquentes
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_conges_dossier_date ON demande_conges (matricule, date_debut DESC);
CREATE INDEX IF NOT EXISTS idx_conges_status_chef  ON demande_conges (decision_chef_service);
CREATE INDEX IF NOT EXISTS idx_conges_status       ON demande_conges (status);
CREATE INDEX IF NOT EXISTS idx_conges_periode      ON demande_conges (date_debut, date_de_fin);
CREATE INDEX IF NOT EXISTS idx_conges_type_annee   ON demande_conges (type_de_conge, annee_jouissance);
CREATE INDEX IF NOT EXISTS idx_conges_deleted      ON demande_conges (deleted_at);

-- ---------------------------------------------------------------------------
-- Solde, audit, acquittement (crédit idempotent + journal)
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_solde_annee          ON solde_conge (annee);
CREATE INDEX IF NOT EXISTS idx_audit_cong           ON audit_conges (id_cong);
CREATE INDEX IF NOT EXISTS idx_audit_matricule      ON audit_conges (matricule, "createdAt" DESC);
CREATE INDEX IF NOT EXISTS idx_audit_action         ON audit_conges (action, "createdAt" DESC);
CREATE INDEX IF NOT EXISTS idx_acquittement_periode ON acquittement_cron (annee, mois);

-- ---------------------------------------------------------------------------
-- Notifications : badge « non lues »
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_notif_user_unread ON notifications (id_user) WHERE is_read = false;
CREATE INDEX IF NOT EXISTS idx_notif_date        ON notifications (create_dat DESC);

-- ---------------------------------------------------------------------------
-- Collections 1:N — une FK n'est PAS indexée automatiquement par PostgreSQL
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_diplome_infop     ON diplome (infop);
CREATE INDEX IF NOT EXISTS idx_poste_infop       ON poste_anterieur (infop);
CREATE INDEX IF NOT EXISTS idx_details_infop     ON details (infop);
CREATE INDEX IF NOT EXISTS idx_distinction_infoc ON distinction (infoc);
CREATE INDEX IF NOT EXISTS idx_sanction_infoc    ON sanction (infoc);

-- ---------------------------------------------------------------------------
-- Recherche du personnel (ILIKE '%...%' → trigram) et filtre par service
-- (l'extension pg_trgm est créée par index.js avant l'application du fichier)
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_infoident_nom_trgm ON info_ident USING gin (nom gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_infop_service      ON info_pro (poste_actuel_service);

-- ---------------------------------------------------------------------------
-- Dossiers archivés (soft-delete) et évaluations
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_dossier_deleted ON dossier (deleted_at);
CREATE INDEX IF NOT EXISTS idx_eval_matricule  ON evaluation (matricule);

-- ---------------------------------------------------------------------------
-- Comptes actifs par rôle (connexions / listes d'administration)
-- ---------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_user_role ON utilisateur (role) WHERE is_active = true;
