-- migrations/020_schema.sql
-- Mise en conformité du schéma existant avec les modèles Sequelize.
-- Idempotent : chaque bloc vérifie l'existence avant d'ajouter.
-- Lancer :  psql -d db_pgdp -f migrations/020_schema.sql

-- ---------------------------------------------------------------------------
-- dossier : + id_user_associe, + createdAt/updatedAt/deleted_at
-- ---------------------------------------------------------------------------
ALTER TABLE dossier ADD COLUMN IF NOT EXISTS id_user_associe INTEGER;
DO $$ BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conname = 'fk_dossier_user_associe' AND conrelid = 'dossier'::regclass
  ) THEN
    ALTER TABLE dossier ADD CONSTRAINT fk_dossier_user_associe
      FOREIGN KEY (id_user_associe) REFERENCES utilisateur(id_user);
  END IF;
END $$;
ALTER TABLE dossier ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE dossier ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE dossier ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ;

-- ---------------------------------------------------------------------------
-- demande_conges : + createdAt/updatedAt/deleted_at
-- ---------------------------------------------------------------------------
ALTER TABLE demande_conges ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE demande_conges ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE demande_conges ADD COLUMN IF NOT EXISTS deleted_at TIMESTAMPTZ;

-- ---------------------------------------------------------------------------
-- info_* : + dossier_id, + createdAt/updatedAt
-- ---------------------------------------------------------------------------
ALTER TABLE info_ident ADD COLUMN IF NOT EXISTS dossier_id INTEGER;
ALTER TABLE info_ident ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE info_ident ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();

ALTER TABLE info_pro ADD COLUMN IF NOT EXISTS dossier_id INTEGER;
ALTER TABLE info_pro ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE info_pro ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();

ALTER TABLE info_bank ADD COLUMN IF NOT EXISTS dossier_id INTEGER;
ALTER TABLE info_bank ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE info_bank ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();

ALTER TABLE info_complementaire ADD COLUMN IF NOT EXISTS dossier_id INTEGER;
ALTER TABLE info_complementaire ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE info_complementaire ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();

-- ---------------------------------------------------------------------------
-- utilisateur : + email, is_active, last_login_at, reset_*, timestamps
-- ---------------------------------------------------------------------------
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS email VARCHAR;
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT true;
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS last_login_at TIMESTAMPTZ;
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS reset_token_hash VARCHAR;
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS reset_token_expire TIMESTAMPTZ;
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS "createdAt" TIMESTAMPTZ NOT NULL DEFAULT now();
ALTER TABLE utilisateur ADD COLUMN IF NOT EXISTS "updatedAt" TIMESTAMPTZ NOT NULL DEFAULT now();
