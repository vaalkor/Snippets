
-- List all functions in the database... Useful!
SELECT routines.routine_name, parameters.data_type, parameters.ordinal_position
FROM information_schema.routines
    LEFT JOIN information_schema.parameters ON routines.specific_name=parameters.specific_name
WHERE routines.routine_name LIKE '%%'
ORDER BY routines.routine_name, parameters.ordinal_position;

SELECT * FROM quote_ident('some string')
SELECT * FROM quote_literal('some string')