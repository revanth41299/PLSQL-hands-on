set serveroutput on;

--index by table
DECLARE
    TYPE empdata IS
        TABLE OF VARCHAR2(30) INDEX BY SIMPLE_INTEGER;
    v_emp empdata;
BEGIN
    v_emp(1) := 'Ram';
    v_emp(2) := 'Robert';
    dbms_output.put_line('value of v_emp(1) : '||v_emp(1));
    dbms_output.put_line('value of v_emp(2) : '||v_emp(2));
END;
/

DECLARE
    TYPE empdata IS
    TABLE OF employees%rowtype  --Using %ROWTYPE to display data according to 
    INDEX BY SIMPLE_INTEGER;    --Row
    v_emp empdata;
BEGIN
    SELECT * INTO v_emp(3)
    FROM employees
    WHERE employee_id = 104;

    dbms_output.put_line(v_emp(3).first_name);
END;
/

DECLARE
    TYPE empdata IS
    TABLE OF employees.first_name%type -- Used to declare a variable according to 
    INDEX BY SIMPLE_INTEGER;           -- database column definition.
    v_emp empdata;
BEGIN
    SELECT first_name
    INTO v_emp(3)
    FROM employees
    WHERE employee_id = 102;

    dbms_output.put_line(v_emp(3));
END;
/


-- Nested Tables
DECLARE
    TYPE emp_data is TABLE OF varchar2(20); -- Declaring Nested table
    v_emp emp_data := emp_data(); -- Initialization using constructor
    /* Nested table needs to be 
    initialized before running the query*/
    
BEGIN
    v_emp.extend(5);  --need to extend the variable in nested tables 
    v_emp(1):= 'Raja'; --collection
    v_emp(2):= 'Raghav';
    dbms_output.put_line(v_emp(1));
    dbms_output.put_line(v_emp(2));
END;
/

DECLARE
    TYPE emp_data is TABLE OF varchar2(20); -- Declaring Nested table
    v_emp emp_data := emp_data('Ravi', 'Robert');
    /* Because the variables are declared here 
    there is no need of extending the variable*/
BEGIN
    dbms_output.put_line(v_emp(1));
    dbms_output.put_line(v_emp(2));
END;
/




DECLARE
    TYPE emp_data is TABLE OF employees%rowtype; -- Declaring Nested table
    v_emp emp_data := emp_data(); --Initialization
        
BEGIN
    v_emp.extend(10); -- Extending Collection
    select * into v_emp(1) from employees where employee_id=102;
    dbms_output.put_line(v_emp(1).first_name);
    dbms_output.put_line(v_emp.first);
END;
/



-- Varray

DECLARE
    TYPE emp_data  -- Varray with upper bound limit 10.
    is VARRAY  (10) OF VARCHAR2(20);
    
    v_emp emp_data; -- variable initialized
BEGIN
    v_emp := emp_data(); -- Varray Initialized
    v_emp.extend(10);
    v_emp(1) := 'Jim';
    dbms_output.put_line(v_emp(1));
    dbms_output.put_line(v_emp.limit);
END;
/



