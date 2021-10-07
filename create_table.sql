create table EMPLOYEES (  
  empno             number,  
  name              varchar2(50) not null,  
  job               varchar2(50),  
  manager           number,  
  hiredate          date,  
  salary            number(7,2),  
  commission        number(7,2),  
  deptno           number,  
  constraint pk_employees primary key (empno),  
  constraint fk_employees_deptno foreign key (deptno) 
      references DEPARTMENTS (deptno)  
);
/

INSERT ALL
  into employees values(2, 'Abdul Azeez', 'Head of Developers', 1, TO_DATE('2019/01/12', 'yyyy/mm/dd'), 100000, 20000, 1)
  into employees values(3, 'Yazid', 'Java Developer', 0, TO_DATE('2019/01/13', 'yyyy/mm/dd'), 70000, 20000, 1)
  into employees values(4, 'Usamah', 'Java Developer', 0, TO_DATE('2019/01/14', 'yyyy/mm/dd'), 70000, 20000, 1)
  into employees values(5, 'Zaid', 'Java Developer', 0, TO_DATE('2019/01/15', 'yyyy/mm/dd'), 70000, 20000, 1)
  into employees values(6, 'Qomar', 'Senior Java Developer', 0, TO_DATE('2019/01/16', 'yyyy/mm/dd'), 80000, 20000, 1)
  into employees values(7, 'Sahin', 'Senior Java Developer', 0, TO_DATE('2019/01/17', 'yyyy/mm/dd'), 90000, 20000, 1)
  into employees values(8, 'Bakrin', 'Senior Java Developer', 0, TO_DATE('2019/01/18', 'yyyy/mm/dd'), 80000, 20000, 1)
  into employees values(9, 'Krstanto', 'Junior Java Developer', 0, TO_DATE('2019/01/19', 'yyyy/mm/dd'), 50000, 20000, 1)
  into employees values(10, 'Abdullah', 'Scrum Master', 0, TO_DATE('2019/01/20', 'yyyy/mm/dd'), 120000, 20000, 1)
SELECT * FROM employees;
/

ALTER TABLE employees MODIFY job varchar2(150) not null;
/

ALTER TABLE employees MODIFY salary NUMBER(15,2);
/

select * from employees;
/

create table DEPARTMENTS (  
  deptno        number,  
  name          varchar2(50) not null,  
  location      varchar2(50),  
  constraint pk_departments primary key (deptno)  
);
/
insert into departments values(1, 'IT Department', 'Jakarta');
/