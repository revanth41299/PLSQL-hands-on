-- Conditional Statements
DECLARE
    v_salary NUMBER := 1000;
BEGIN
    IF v_salary <= 1000 THEN
        dbms_output.put_line('salary is < 1000');
    END IF;
END;
/

set serveroutput on;

DECLARE
    v_salary NUMBER := 2000;
BEGIN
    IF v_salary <= 1000 THEN
        dbms_output.put_line('salary is < 1000');
    ELSE
        dbms_output.put_line('salary is not < 1000');
    END IF;
END;
/

--ELSIF

DECLARE
    v_salary NUMBER := 7000;
BEGIN
    IF v_salary BETWEEN 1000 AND 3000 THEN
        dbms_output.put_line('salary is Between 1000 to 3000');
    ELSIF v_salary BETWEEN 5000 AND 8000 THEN
        dbms_output.put_line('salary is Between 5000 to 8000');
    ELSIF v_salary BETWEEN 8000 AND 10000 THEN
        dbms_output.put_line('salary is Between 8000 to 10000');
    ELSE
        dbms_output.put_line('Not Specified');
    END IF;
END;
/


--CASE Statement
--simple CASE
DECLARE
    v_status VARCHAR2(20);
BEGIN
    v_status := 'NA';
    CASE v_status
        WHEN 'Y' THEN
            dbms_output.put_line('Approved');
        WHEN 'N' THEN
            dbms_output.put_line('Not Approved');
        WHEN 'NA' THEN
            dbms_output.put_line('Rejected');
        ELSE
            dbms_output.put_line('Not Matched');
    END CASE;

END;
/



--Searched CASE
DECLARE
    v_status VARCHAR2(15) := 'Y';
BEGIN
    CASE
        WHEN v_status = 'Y' THEN
            dbms_output.put_line('Approved');
        WHEN v_status = 'N' THEN
            dbms_output.put_line('Not Approved');
        WHEN v_status = 'NA' THEN
            dbms_output.put_line('Rejected');
        ELSE
            dbms_output.put_line('Not Matched');
    END CASE;
END;
/


--Expression Statement
DECLARE
    v_status VARCHAR2(20) := 'NA';
    v_output VARCHAR2(20); --variable initialised
BEGIN
    v_output :=
        CASE v_status
            WHEN 'Y' THEN
                'Approved'
            WHEN 'N' THEN
                'Not Approved'
            WHEN 'NA' THEN
                'Rejected'
        END;

    dbms_output.put_line(v_output);
END;
/



--LOOPS
/*Simple LOOP*/

DECLARE BEGIN
    LOOP
        dbms_output.put_line('Welcome');
    END LOOP;
/*without EXIT this program will create an infinite loop*/
END;
/


-- Using EXIT in IF statement
DECLARE
    var1 NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(var1);
        var1 := var1 + 1;
        IF var1 = 5 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

DECLARE
    var1 NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(var1);
        CASE
            WHEN var1 = 5 THEN
                EXIT;   -- Statement Exits when var1 becomes 5
            ELSE
                var1 := var1 + 1;
        END CASE;

    END LOOP;
END;
/

--EXIT WHEN
DECLARE
    var1 NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(var1);
        var1 := var1 + 1;
        EXIT WHEN var1 = 5;
    END LOOP;
END;
/

--FOR Loop
DECLARE
    v_emp    employees.first_name%TYPE; -- variable declared for emp name
    v_emp_id employees.employee_id%TYPE;
BEGIN
    FOR i IN REVERSE 100..105 LOOP -- REVERSE ORDER
        SELECT
            first_name,
            employee_id
        INTO
            v_emp,
            v_emp_id
        FROM
            employees
        WHERE
            employee_id = i; -- variable i is declared so it will pick  
                             -- emp id based on valuefrom loop
        dbms_output.put_line(v_emp
                             || '-'
                             || v_emp_id);
    END LOOP;
END;
/


--CONTINUE
DECLARE
    v_demo NUMBER(2) := 7; -- variable declared
BEGIN
    LOOP
        v_demo := v_demo + 1; -- variable is getting incremened
        IF v_demo = 11 THEN
            CONTINUE;   -- this statment skips 11 and prints the 
        END IF;         -- remaining value.
        dbms_output.put_line(v_demo);
        EXIT WHEN v_demo = 15; --Loop exits when v_demo =15
    END LOOP;
END;
/

--Continue WHEN
DECLARE
    v_demo NUMBER := 7;
BEGIN
    LOOP
        v_demo := v_demo + 1;
        CONTINUE WHEN v_demo = 10; -- continue when is used.
        dbms_output.put_line('current value is ' || v_demo);
        EXIT WHEN v_demo = 15;
    END LOOP;
END;
/


--while loop
DECLARE
    v_demo NUMBER := 1; -- variable declared
BEGIN
    WHILE v_demo < 10 LOOP -- Loops based on condition
        dbms_output.put_line('current value is ' || v_demo);
        v_demo := v_demo + 2; -- variable is getting incremented
    END LOOP;
END;
/

--GOTO Statement Example

DECLARE
    v_last_name VARCHAR2(25);
    v_emp_id    NUMBER(6) := 105;
BEGIN
    << get_name >> SELECT
                                      last_name
                                  INTO v_last_name
                                  FROM
                                      employees
                   WHERE
                       employee_id = v_emp_id;
    BEGIN
        dbms_output.put_line(v_last_name);
        v_emp_id := v_emp_id + 5;
        IF v_emp_id < 120 THEN
            GOTO get_name;   --This GOTO statement transfers the 
        END IF;              --control to <<get_name>> block.
    END;

END;
/

--NULL
DECLARE
    v_valid BOOLEAN := true;
BEGIN
    GOTO emp_data;
    IF v_valid THEN
        NULL;
    END IF;
    << emp_data >> 
    NULL; --NULL declared
END;
/

