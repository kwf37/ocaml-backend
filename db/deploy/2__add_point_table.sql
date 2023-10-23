-- Deploy ocaml-backend:2__add_point_table to pg

BEGIN;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS app.point (
  id uuid DEFAULT uuid_generate_v4(),
  x NUMERIC NOT NULL,
  y NUMERIC NOT NULL,
  PRIMARY KEY (id)
);

COMMIT;
