CREATE ROLE yaml;
CREATE OR REPLACE FUNCTION refine_dump_data(IN from_role varchar, IN to_schema varchar)
RETURNS varchar AS $$
DECLARE
    r pg_tables%rowtype;
    i int := 0;
BEGIN
    --EXECUTE 'DROP ROLE IF EXISTS ' || to_schema || ';';
    EXECUTE 'DROP SCHEMA IF EXISTS ' || to_schema || ' CASCADE;';
    --EXECUTE 'CREATE ROLE ' || to_schema || ';';
    EXECUTE 'CREATE SCHEMA ' || to_schema || ' AUTHORIZATION postgres;';
    FOR r IN
        SELECT * FROM pg_tables where tableowner = from_role
    LOOP
        EXECUTE 'ALTER TABLE ' || r.schemaname || '."' || r.tablename || '" SET SCHEMA ' || to_schema || ';';
        i := i + 1;
    END LOOP;
    EXECUTE 'REASSIGN OWNED BY ' || from_role || ' TO ' || to_schema || ';';
    RETURN i;
END
$$ LANGUAGE plpgsql;

