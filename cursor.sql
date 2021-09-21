create table class_room(
    id VARCHAR2(10),
    capacity NUMBER,
    constraint pk_classroom primary key (id)
);

create table student(
    id NUMBER generated ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    student_nim VARCHAR2(12),
    student_name VARCHAR2(50),
    birth_date DATE,
    class_room_id VARCHAR2(10),
    prodi_kode VARCHAR2(10),
    constraint pk_student PRIMARY KEY (id),
    constraint fk_class_room_id foreign key(class_room_id) references class_room(id),
);
drop table student;
alter table student rename column student_id to class_room_id;

insert into class_room(id, capacity) values('K001', 50);
insert into class_room(id, capacity) values('K002', 40);
insert into class_room(id, capacity) values('K003', 30);
select * from class_room;

create table prodi(
    kode VARCHAR2(10),
    prodi_name VARCHAR2(50),
    constraint pk_prodi primary key(kode)
);
insert into prodi values('MI', 'A');
insert into prodi values('TK' 'B');
insert into prodi values('KA', 'C');

--K001
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0001', 'Muhammad', SYSDATE, 'K001');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0002', 'Abu Bakar', SYSDATE, 'K001');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0003', 'Umar', SYSDATE, 'K001');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0004', 'Usman', SYSDATE, 'K001');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0005', 'Ali', SYSDATE, 'K001');

--K002
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0006', 'Sofyan', SYSDATE, 'K002');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0007', 'Ramzi', SYSDATE, 'K002');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0008', 'Ahmad', SYSDATE, 'K002');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N0009', 'Acong', SYSDATE, 'K002');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00010', 'Acung', SYSDATE, 'K002');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00011', 'Omar', SYSDATE, 'K002');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00012', 'Karim', SYSDATE, 'K002');

--K003
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00013', 'Oya', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00014', 'Oye', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00015', 'Oyu', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00016', 'Dongo', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00017', 'Tolol', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00018', 'Idiot', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00019', 'Goblok', SYSDATE, 'K003');
insert into student(student_nim, student_name, birth_date, class_room_id) values('N00020', 'Bego', SYSDATE, 'K003');

select * from student;

set SERVEROUTPUT ON;
-- view capacity of class_room=K001
DECLARE
    v_capacity NUMBER;
BEGIN
    select capacity into v_capacity from class_room where id='K001';
    dbms_output.put_line(v_capacity);
END;

--Total student in class K003
DECLARE
    v_total_student NUMBER;
BEGIN
    select count(student_nim) into v_total_student from student where class_room_id='K003';
    dbms_output.put_line(v_total_student);
END;

--Check if class_room full or not
declare
    v_capacity NUMBER;
    v_total_student NUMBER;
begin
    select capacity into v_capacity from class_room where id=-'K001';
    select count(student_nim) into v_total_student from student where class_room_id='K001';
    
    IF v_total_student < v_capacity THEN
        insert into student values(&student_nim, &student_name, &birth_date, &class_room_id);
        COMMIT;
    ELSE
        UPDATE kelas set capacity=v_capacity+1 where id='K001';
        INSERT INTO student VALUES (&student_nim, &student_name, &birth_date, &class_room_id);
        COMMIT;
    end IF;
end;