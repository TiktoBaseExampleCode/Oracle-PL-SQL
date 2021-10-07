CREATE TABLE animals(
    name varchar(10),
    species varchar(20),
    date_of_birth date
);
/

CREATE TYPE animal_ot IS OBJECT(
    name varchar(10),
    species varchar(20),
    date_of_birth date
);
/

CREATE TYPE animals_nt IS TABLE OF animal_ot;
/

CREATE TYPE animals_nt IS VARRAY(10) OF animal_ot;
/



CREATE OR REPLACE FUNCTION animal_family (dad_in IN animal_ot, mom_in IN animal_ot)
    RETURN animals_nt
    AUTHID DEFINER
IS
    l_family animals_nt := animals_nt(dad_in, mom_in);
BEGIN
    FOR idx IN 1 ..
        CASE mom_in.species
            WHEN 'RABBIT' THEN 12
            WHEN 'DOG' THEN 4
            WHEN 'KANGAROO' THEN 1
        END
    LOOP
        l_family.EXTEND;
        l_family(l_family.LAST) := animal_ot('BABY' || idx, mom_in.species, ADD_MONTHS(SYSDATE, -1 * DBMS_RANDOM.VALUE(1,6)));
    END LOOP;

    RETURN l_family;
END;
/

select name, species, date_of_birth FROM TABLE (animal_family(
                                                animal_ot('Hoppy', 'RABBIT', SYSDATE-500),
                                                animal_ot('Hippy', 'RABBIT', SYSDATE-300)))
/

INSERT INTO animals select name, species, date_of_birth FROM TABLE (animal_family(
                                                animal_ot('Hoppy', 'RABBIT', SYSDATE-500),
                                                animal_ot('Hippy', 'RABBIT', SYSDATE-300)));
/

INSERT INTO animals select name, species, date_of_birth FROM TABLE (animal_family(
                                                animal_ot('Bob', 'KANGAROO', SYSDATE-500),
                                                animal_ot('Sally', 'KANGAROO', SYSDATE-300)));
/

select * from animals where species='KANGAROO';
/

