--Non predefined Exceptions

CREATE TABLE emp (
    ename     VARCHAR2(30)NOT NULL,
    hire_date DATE NOT NULL
);
drop table emp;
set serveroutput on;

SELECT * FROM EMP;
truncate table emp;
CREATE OR REPLACE PROCEDURE test_proc (
    ename     VARCHAR2,
    hire_date VARCHAR2
) IS
    v_hire_date DATE; -- variable to store date.
BEGIN
    v_hire_date := TO_DATE ( hire_date, 'mm/dd/yyyy' ); --Date format conversion.
    --dbms_output.put_line(v_hire_date);
    insert into emp values (ename,v_hire_date);
    dbms_output.put_line('Value for Ename : ' || ename || 'Inserted Successfully.');
exception
    when others then /*This exception will print when 
                        user enters unsupported date format.*/
                        
            if sqlcode = -1843 THEN  /*we can also pass the error code 
                                        in IF CONDITION like this.*/
                dbms_output.put_line('Date format should be mm/dd/yyyy');
                
            elsif sqlcode = -1400 THEN /*This condition will handle 
                                if there is any NULL values in User Arguments*/
                dbms_output.put_line('Null values are not accepted');
        end if;
END;
/

DESC EMP;

exec test_proc('Steven', '11/23/2023');

exec test_proc('Steven', '23/11/2023');

exec test_proc('Steven', NULL);


--PRAGMA EXCEPTION_INIT

CREATE OR REPLACE PROCEDURE test_proc (
    ename     VARCHAR2,
    hire_date VARCHAR2
) IS
    v_hire_date DATE; -- variable to store date.
    /* Declaring PRAGMAN EXCEPTION_INIT*/
    date_format exception;  
        PRAGMA exception_init ( date_format, -1843 );
    not_null_excp exception;
        PRAGMA exception_init ( not_null_excp, -1400 );
BEGIN
    v_hire_date := TO_DATE ( hire_date, 'mm/dd/yyyy' ); --Date format conversion.
    --dbms_output.put_line(v_hire_date);
    insert into emp values (ename,v_hire_date);
    dbms_output.put_line('Value for Ename : ' || ename || ' Inserted Successfully.');
exception
    when date_format then --Using PRAGMA_INIT in EXCEPTIONS
        dbms_output.put_line('Date format should be mm/dd/yyyy - Pragma INIT');
    when not_null_excp then
        dbms_output.put_line('Null values are not accepted - Pragma INIT');
END;
/


exec test_proc('Steven', '11/23/2023');

exec test_proc('Steven', '23/11/2023');

exec test_proc('Steven', NULL);
