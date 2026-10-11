-- migrations/011_role_securite.sql
-- Rôle « securite » (agent de sécurité : pointage des présences).
-- Le front avait déjà tout le workspace /securite/* mais l'ENUM de la table
-- utilisateur ne contenait pas la valeur : aucun compte ne pouvait jamais
-- être créé avec ce rôle. ADD VALUE IF NOT EXISTS = idempotent.
-- NB : s'exécute hors transaction (sequelize.query autocommit dans index.js).
ALTER TYPE public.enum_utilisateur_role ADD VALUE IF NOT EXISTS 'securite';