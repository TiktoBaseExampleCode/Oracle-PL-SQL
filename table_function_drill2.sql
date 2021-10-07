CREATE OR REPLACE TYPE strings_t IS TABLE OF VARCHAR2(100);
/

set SERVEROUTPUT on;
CREATE OR REPLACE FUNCTION random_strings (count_in IN INTEGER) 
    RETURN strings_t 
    AUTHID DEFINER 
IS
    l_strings strings_t := strings_t();
BEGIN
    l_strings.EXTEND(count_in);

    FOR idx IN 1.. count_in
    LOOP
        l_strings(idx) := DBMS_RANDOM.string('u', 10);
    END LOOP;

    return l_strings;
END;
/

DECLARE
    l_strings strings_t := random_strings(5);
BEGIN
    FOR idx IN 1.. l_strings.COUNT
    LOOP
        DBMS_OUTPUT.put_line(l_strings(idx));
    END LOOP;
END;
/

select 'Random ==> ' || COLUMN_VALUE my_string FROM TABLE(random_strings(5))
/

select e.last_name FROM TABLE (random_strings(3)) rs, employees e WHERE LENGTH(e.last_name) <= LENGTH (COLUMN_VALUE)
/

select e.last_name from employees e WHERE ROWNUM < 4 UNION ALL select rs.COLUMN_VALUE from TABLE (random_strings(3)) rs
/

BEGIN
    FOR rec IN (SELECT COLUMN_VALUE my_string from TABLE (random_strings(5)))
    LOOP
        DBMS_OUTPUT.put_line(rec.my_string);
    END LOOP;
END;
/