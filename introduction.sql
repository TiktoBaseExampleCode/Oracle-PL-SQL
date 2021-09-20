create table DEPARTMENTS (  
  deptno        number,  
  name          varchar2(50) not null,  
  location      varchar2(50),  
  constraint pk_departments primary key (deptno)  
);

create table EMPLOYEES (  
  empno             number,  
  name              varchar2(50) not null,  
  job               varchar2(50),  
  manager           number,  
  hiredate          date,  
  salary            number(7,2),  
  commission        number(7,2),  
  deptno           number, 
  constraint pk_employee PRIMARY KEY (empno),
  constraint fk_employee_deptno foreign key(deptno) references departments(deptno)
  );

create or replace trigger trigger_departments
before insert or update on departments 
for each row
begin
        if inserting and :new.deptno is null then
            :new.deptno := to_number(sys_guid(),
                'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        end if;
end;

create or replace NONEDITIONABLE trigger trigger_employees
before insert or update on employees 
for each row
begin
        if inserting and :new.empno is null then
            :new.empno := to_number(sys_guid(),
                'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
        end if;
end;

insert into departments (name, location) values ('Finance', 'New York');
insert into departments (name, location) values ('Development', 'New York');


insert into EMPLOYEES 
   (name, job, salary, deptno) 
   values
   ('Sam Smith','Programmer', 
    5000, 
  (select deptno 
  from departments 
  where name = 'Development'));

insert into EMPLOYEES 
   (name, job, salary, deptno) 
   values
   ('Mara Martin','Analyst', 
   6000, 
   (select deptno 
   from departments 
   where name = 'Finance'));

insert into EMPLOYEES 
   (name, job, salary, deptno) 
   values
   ('Yun Yates','Analyst', 
   5500, 
   (select deptno 
   from departments 
   where name = 'Development'));
   
select table_name "Table", 
       index_name "Index", 
       column_name "Column", 
       column_position "Position"
from  user_ind_columns 
where table_name = 'EMPLOYEES' or 
      table_name = 'DEPARTMENTS'
order by table_name, column_name, column_position;

create index employee_dept_no_fk_idx on employees(deptno);
create unique index employee_ename_idx on employees (name);

select * from employees;

SELECT
    "A1"."NAME"     "EMPLOYEE",
    "A2"."NAME"     "DEPARTMENT",
    "A1"."JOB"      "JOB",
    "A2"."LOCATION" "LOCATION"
FROM
    "MUHAMAD_IQBAL"."DEPARTMENTS" "A2",
    "MUHAMAD_IQBAL"."EMPLOYEES"   "A1"
WHERE
    "A2"."DEPTNO" = "A1"."DEPTNO" (+)
ORDER BY
    "A1"."NAME";
    


select e.name employee,
          (select name 
           from departments d 
           where d.deptno = e.deptno) department,
           e.job
from employees e
order by e.name;