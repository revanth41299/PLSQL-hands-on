set serveroutput on;
--CURSORS

DECLARE
    v_name employees.first_name%TYPE; --declaring variable
    CURSOR demo_cur IS      --declaring cursor
    SELECT first_name FROM employees
    WHERE employee_id > 105;

BEGIN
    OPEN demo_cur;  -- Open cursor
    LOOP
        FETCH demo_cur INTO v_name;
        dbms_output.put_line(v_name);
        EXIT WHEN demo_cur%notfound;    --%Not Found Attribute
    END LOOP;

    CLOSE demo_cur; --Close cursor
END;
/

--CURSOR WITH RECORDS
DECLARE
      TYPE emp_rec IS RECORD (      --Declaring records
        v_1 employees.first_name%TYPE,
        v_2 employees.salary%TYPE,
        v_3 employees.department_id%TYPE,
        v_4 departments.department_name%TYPE
    );

  v_rec emp_rec;
        
  CURSOR emp_cur IS 
  select EMP.first_name, EMP.salary, EMP.department_id, DEPT.department_name
  from hr.employees EMP, hr.departments DEPT
  where 
  EMP.department_id = DEPT.department_id 
  AND
  EMP.employee_id between 100 and 120;
  
BEGIN
  OPEN emp_cur;

  LOOP
    FETCH emp_cur INTO v_rec;
    dbms_output.put_line(v_rec.v_1 || ' '||  v_rec.v_2 || ' '||v_rec.v_3 || ' '|| v_rec.v_4); --Using Record variables
    EXIT WHEN emp_cur%NOTFOUND;
  END LOOP;
  CLOSE emp_cur;
END;
/


-- Parameterised Cursor
DECLARE

  v_name varchar2(30);
  cursor para_cur_ex (v_e_id varchar2)  -- Declaring Parameter
  IS
  SELECT first_name FROM employees
  where employee_id < v_e_id;
  
BEGIN
  OPEN para_cur_ex(105); --Passing Argument
  LOOP
    FETCH para_cur_ex INTO v_name;
    dbms_output.put_line(v_name);
    EXIT WHEN para_cur_ex%NOTFOUND;
  END LOOP;
  CLOSE para_cur_ex;
END;
/


--Parameterised Cursor with default value.

DECLARE
    v_name varchar2(30);
    v_eid number;
    
    cursor def_para_cur (v_e_id number :=190) --Default Parameter Value.
    IS
    select first_name, employee_id FROM employees
    where employee_id > v_e_id;

BEGIN
    OPEN def_para_cur; --Passing Argument
  LOOP
    FETCH def_para_cur INTO v_name, v_eid;
    dbms_output.put_line(v_name || ' ' || v_eid);
    EXIT WHEN def_para_cur%NOTFOUND;
  END LOOP;
  CLOSE def_para_cur;
  
END;
/


--Cursor For loop
DECLARE
cursor for_cur IS
select first_name,last_name FROM employees
where employee_id > 200;

BEGIN
    FOR l_idx IN for_cur
    LOOP
        dbms_output.put_line(l_idx.first_name || ' ' || l_idx.last_name);
    END LOOP;
END;
/


--Parameterised Cursor For loop

DECLARE
cursor for_cur_para (v_e_id NUMBER) -- Declaring Parameter
IS 
select first_name,employee_id FROM employees
where employee_id > v_e_id;

BEGIN
    FOR l_idx IN for_cur_para(200) -- Declaring Argument
    LOOP
        dbms_output.put_line(l_idx.first_name || ' ' || l_idx.employee_id);
    END LOOP;
END;
/