set SERVEROUTPUT on;
alter session set "_ORACLE_SCRIPT"=TRUE;

create or replace function camelCaseCounter 
return NUMBER is
    vcamelCase VARCHAR2(1000);
    v_length NUMBER;
    v_out VARCHAR2(100);
    v_count NUMBER;
begin
    vcamelCase := 'saveChangesInTheEditor';
    v_length := LENGTH(vcamelCase);
    DBMS_OUTPUT.PUT_LINE(v_length);
    v_count := 1;

    for i in 0..v_length LOOP
        v_out := SUBSTR(vcamelCase, i,i+1);
        IF v_out >= 'A' and v_out <= 'Z' THEN
            v_count := v_count + 1;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Text printed: ' || v_out);
    END LOOP;
    return v_count;
end camelCaseCounter;

drop function camelCaseCounter;

BEGIN
    dbms_output.put_line('CamelCaseCounter :' || camelCaseCounter());
END;

create or REPLACE FUNCTION helloMyFriend
return VARCHAR2 IS
    v_name VARCHAR2(100);
BEGIN
    v_name := 'Iqbal';
    DBMS_OUTPUT.put_line('Hello => '|| v_name);
    return v_name;
END;
drop function helloMyFriend;

BEGIN
    dbms_output.put_line(helloMyFriend());
END;
/