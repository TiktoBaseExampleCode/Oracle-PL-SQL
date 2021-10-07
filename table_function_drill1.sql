CREATE OR REPLACE TYPE list_of_names_t IS TABLE OF VARCHAR2(100);

set SERVEROUTPUT on;
DECLARE
    happyFamily     list_of_names_t := list_of_names_t();
    children        list_of_names_t := list_of_names_t();
    grandChildren   list_of_names_t := list_of_names_t();
    parents         list_of_names_t := list_of_names_t();
BEGIN
    /* Can extend in "bulk" - 6 at once here */
    happyFamily.EXTEND(7);
    happyFamily(1) := 'Veva';
    happyFamily(2) := 'Chris';
    happyFamily(3) := 'Lauren';
    happyFamily(4) := 'Loey';
    happyFamily(5) := 'Juna';
    happyFamily(6) := 'Eli';
    happyFamily(7) := 'Steven';

    /*Individual extends. */
    children.EXTEND;
    children(children.LAST) := 'Chris';
    children.EXTEND;
    children(children.LAST) := 'Eli';
    children.EXTEND;
    children(children.LAST) := 'Lauren';

    grandChildren.EXTEND;
    grandChildren(grandChildren.LAST) := 'Loey';
    grandChildren.EXTEND;
    grandChildren(grandChildren.LAST) := 'Juna';

    /*Multiset operator on nested tables */
    parents := (happyFamily MULTISET EXCEPT children) MULTISET EXCEPT grandChildren;

    DBMS_OUTPUT.put_line('Grandparents');

    FOR l_row IN 1.. parents.COUNT
    LOOP
        DBMS_OUTPUT.put_line(parents(l_row));
    END LOOP;

    happyFamily.DELETE;
    DBMS_OUTPUT.put_line ('Size of happy family: ' || happyFamily.COUNT);
    DBMS_OUTPUT.put_line(':-)');
END;