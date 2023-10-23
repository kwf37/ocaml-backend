-- Revert ocaml-backend:2__add_point_table from pg

BEGIN;

DROP TABLE IF EXISTS app.point;

DROP EXTENSION IF EXISTS "uuid-ossp"

COMMIT;
