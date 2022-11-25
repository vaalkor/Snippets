
-- List all functions in the database... Useful!
SELECT routines.routine_name, parameters.data_type, parameters.ordinal_position
FROM information_schema.routines
    LEFT JOIN information_schema.parameters ON routines.specific_name=parameters.specific_name
WHERE routines.routine_name LIKE '%%'
ORDER BY routines.routine_name, parameters.ordinal_position;

SELECT * FROM quote_ident('some string')
SELECT * FROM quote_literal('some string')

-- Terminate connections for specific databases (ignoring your current connection)
select pg_terminate_backend(pid) from pg_stat_activity where datname='Some table name' AND pid<>pg_backend_pid();