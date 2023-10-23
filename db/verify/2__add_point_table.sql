-- Verify ocaml-backend:2__add_point_table on pg

BEGIN;

DO $$
BEGIN

  ASSERT (
    SELECT EXISTS (
      SELECT FROM information_schema.tables 
      WHERE  table_schema = 'app'
      AND    table_name   = 'point'
   ));

END $$;

ROLLBACK;
