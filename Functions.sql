CREATE TABLE table_name (
    employee_id        NUMBER,
    employee_name      VARCHAR2(20),
    base_salary        NUMBER,
    hours_worked       NUMBER,
    performance_rating NUMBER
);

RENAME  table_name TO EMPLOYEE_RATING;
INSERT INTO table_name VALUES (1,'JOHN DOE',5000, 45, 4);
INSERT INTO table_name VALUES (2,'JANE SMITH',5500, 37, 5);
INSERT INTO table_name VALUES (3,'ALICE JOHN',4800, 42, 3);


SELECT * FROM employee_rating;

commit;
set serveroutput on;

--FUNCTION

create or replace function salary_bonus (v_emp_id number) -- Argument passed
return number -- Datatype the function is going to return

is
    v_salary NUMBER;
    v_rating NUMBER;
    v_bonus NUMBER := 0;
begin
    select base_salary, performance_rating into v_salary, v_rating 
    from employee_rating where employee_id = v_emp_id;
    
    if v_rating >=4 then
        v_bonus := v_salary * 0.10; --Bonus 10%
    
    end if;     
    
    return v_bonus;
end;
/

declare
v_salary number;

begin
    v_salary := salary_bonus(v_emp_id=>1);
    dbms_output.put_line(v_salary);
end;
/

create or replace function salary_bonus (v_emp_id number) -- Argument passed
return number -- Datatype the function is going to return

is
    v_salary NUMBER;
    v_rating NUMBER;
    v_bonus NUMBER := 0;
begin
    select base_salary, performance_rating into v_salary, v_rating 
    from employee_rating where employee_id = v_emp_id;
    
    if v_rating >=4 then
        v_bonus := v_salary * 0.10; --Bonus 10%
        
        UPDATE employee_rating
        SET base_salary = base_salary + v_bonus  -- DML Commands can be used 
        WHERE                         --when calling function inside pl/sql block
        employee_id = v_emp_id;       -- we cannot use it in sql statement
        
    end if;     
    
    return v_bonus;
end;
/



select salary_bonus(2) from dual;

