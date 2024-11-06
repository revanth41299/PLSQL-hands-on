DECLARE 
	type rec_demo 	--DECLARING Record as UserDefined datatype 
    is record (v_1 hr.employees.first_name%type, 
    			v_2 hr.employees.salary%type, 
    			v_3 hr.departments.department_name%type); 
 
	v_demo rec_demo; -- DECLARING variable with RECORD DataType. 
BEGIN 
    select emp.first_name, emp.salary, dept.department_name 
    INTO v_demo 
	from hr.employees emp, hr.departments dept 
	where emp.department_id = dept.department_id 
	and emp.employee_id = 102; 
 
	DBMS_OUTPUT.PUT_LINE(V_DEMO.V_2); 
	 
END; 
/


DECLARE 
	type rec_demo 	--DECLARING Record as UserDefined datatype 
    is record (v_1 hr.employees.first_name%type, 
    			v_2 hr.employees.salary%type, 
    			v_3 hr.departments.department_name%type); 
 
	v_demo rec_demo; -- DECLARING variable with RECORD DataType. 
	v_demo_1 rec_demo; -- Reusing the RECORD DataType with Different variable . 
BEGIN 
    select emp.first_name, emp.salary, dept.department_name 
    INTO v_demo -- USING variable to store column names 
	from hr.employees emp, hr.departments dept 
	where emp.department_id = dept.department_id 
	and emp.employee_id = 103; 
 
	select emp.first_name, emp.salary, dept.department_name 
    INTO v_demo_1 -- USING variable to store column names 
	from hr.employees emp, hr.departments dept 
	where emp.department_id = dept.department_id 
	and emp.employee_id = 102; 
 
	DBMS_OUTPUT.PUT_LINE(v_demo.v_1|| ' ' || v_demo.v_2 || ' ' || v_demo.v_3); 
 
	DBMS_OUTPUT.PUT_LINE(v_demo_1.v_1|| ' ' || v_demo_1.v_2 || ' ' || v_demo_1.v_3); 
	 
END; 