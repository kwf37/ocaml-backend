-- Revert ocaml-backend:1__add_app_schema from pg

BEGIN;

  DROP SCHEMA app;

COMMIT;
