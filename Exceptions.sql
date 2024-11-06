set serveroutput on;
--Predefined Exceptions
CREATE OR REPLACE PROCEDURE proc_excp (emp_id NUMBER) AS
    v_name      number; --Name declared as Number datatype
    v_dept      employees.department_id%TYPE;
    v_dept_name departments.department_name%TYPE;
begin
    select first_name,department_id into v_name,v_dept 
    from employees where employee_id = emp_id;
    
    select department_name into v_dept_name 
    from departments where department_id = v_dept;
    
    dbms_output.put_line('Employee Name : '||v_name );
    dbms_output.put_line('Department Name : '||v_dept_name );
exception

    when VALUE_ERROR then
        dbms_output.put_line('Please Enter valid Datatypes value');
    when NO_DATA_FOUND then
        dbms_output.put_line('Value Not found Enter valid ID');
end;
/

exec proc_excp(1020);


--Detailed Example

CREATE OR REPLACE PROCEDURE proc_excp (emp_id NUMBER) AS
    v_name      number; --Name declared as Number datatype
    v_dept      employees.department_id%TYPE;
    v_dept_name departments.department_name%TYPE;
begin
    begin
        select first_name,department_id into v_name,v_dept 
        from employees where employee_id = emp_id;
    exception
        when others then
            dbms_output.put_line('Error code ' || sqlcode);
            dbms_output.put_line('Error Msg ' || sqlerrm);
    end;
    
    if v_name is NOT NULL then
        select department_name into v_dept_name 
        from departments where department_id = v_dept;
    else
        v_name:= 'Check your data';
        v_dept_name:= 'Check your data';
    end if;   
    
    dbms_output.put_line('Employee Name : '||v_name );
    dbms_output.put_line('Department Name : '||v_dept_name );
exception

    when VALUE_ERROR then
        dbms_output.put_line('Please Enter valid Datatypes value');
    when NO_DATA_FOUND then
        dbms_output.put_line('Value Not found Enter valid ID');
end;
/

exec proc_excp(1020);

--Example 3 for better understanding
declare
    type colle_type is table of number;
    nums colle_type := colle_type(10, 20, 30, 40, 50);
begin
    nums.delete(3);
    for i in nums.first..nums.last 
    loop
        begin
            dbms_output.put_line(nums(i));
        exception
            when no_data_found then
                dbms_output.put_line('Index Not Found at : ' || i);
        end;
    end loop;
exception
    when others then
        null;
end;
            





