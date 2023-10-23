-- Deploy ocaml-backend:1__add_app_schema to pg

BEGIN;

  CREATE SCHEMA app;

COMMIT;
