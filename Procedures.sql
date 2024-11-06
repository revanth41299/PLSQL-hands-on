--PROCEDURES

CREATE TABLE employee_bkp AS
SELECT * FROM hr.employees;
SELECT * FROM EMPLOYEE_BKP;
set serveroutput on;

--EXAMPLE 1 : creating stored procedures to update employee salary

create or replace procedure update_emp_salary is
    increment_amt number :=100;
    v_emp_id number := 107;
    v_emp_name varchar2(20);
    updated_salary number;
begin
    update employee_bkp set salary = salary + increment_amt
    where employee_id = v_emp_id;
    
    select first_name,salary into v_emp_name,updated_salary from employees 
    where employee_id = v_emp_id;

    dbms_output.put_line('Updated salary for employee'||v_emp_name || '' || v_emp_id);
end;
/

exec update_emp_salary ( 1500, 101);

--EXAMPLE 2 USING PARAMETERS

create or replace procedure update_emp_salary (increment_amt number, v_emp_id number)
is
    v_emp_name varchar2(20);
    updated_salary number;
begin
    update employee_bkp set salary = salary + increment_amt
    where employee_id = v_emp_id;
    
    select first_name,salary into v_emp_name,updated_salary from employees 
    where employee_id = v_emp_id;

    dbms_output.put_line('Updated salary for employee '||v_emp_name || ' ' || updated_salary);
end;
/


--EXAMPLE 3 IN OUT INOUT PARAMETERS
create or replace procedure update_emp_salary (increment_amt number, --ALL Parameters
                                                v_emp_id number, -- are IN By default
                                    updated_salary OUT number, --Using OUT Parameter
                                    v_emp_name OUT varchar2) --Using OUT Parameter
                                    
is
    
begin
    update employee_bkp set salary = salary + increment_amt
    where employee_id = v_emp_id;
    
    select first_name,salary into v_emp_name,updated_salary from employee_bkp
    where employee_id = v_emp_id;

end;
/

declare
    updated_salary number; --OUT Parameter is declared before execution.
    v_emp_name varchar2(20); --OUT Parameter is declared before execution.
begin
    update_emp_salary ( 1500, 108, updated_salary,v_emp_name); --OUT Parameter is passed as parameter.
    dbms_output.put_line('Updated salary for employees '||v_emp_name||'is '||updated_salary);
end;
/


-- EXAMPLE 4 INOUT PARAMETER

create or replace procedure update_emp_salary (increment_amt IN OUT number, -- Using INOUT 
                                                v_emp_id number, 
                                    v_emp_name OUT varchar2) --Using OUT Parameter                             
is
    
begin
    update employee_bkp set salary = salary + increment_amt
    where employee_id = v_emp_id;
    
    select first_name,salary into v_emp_name,increment_amt from employee_bkp
    where employee_id = v_emp_id;

end;
/

declare
    salary number := 100; -- new value is declared for passing increment value in parameter.
    v_emp_name varchar2(20); --OUT Parameter is declared before execution.
begin
    update_emp_salary ( salary, 106,v_emp_name); --OUT Parameter is passed as parameter.
    dbms_output.put_line('Updated salary for employees '||v_emp_name||' is '||salary);
end;
/


--EXAMPLE 5 DEFAULT PARAMETERS

create or replace procedure add_number (x number, 
                                        y number, 
                               z number default 0) --default value is set to 0
is 
begin
    dbms_output.put_line('x : '||x);
    dbms_output.put_line('y : '||y);
    dbms_output.put_line('z : '||z);
end;
/


begin
    add_number(10,y=>20,z=>30);  --mixed notation
end;
/

-- RETURN Keyword
create or replace procedure cal_sqr (n number, res out number)
is
begin
    if n < 0 then
        dbms_output.put_line(n || ' is negative value not allowed here!');
        return;
    end if;
    res:= n*n;
end;
/

declare
res number;
begin
cal_sqr(-2,res);
dbms_output.put_line(res);
end;
/


--Procedure Example Transferring amount from SENDER ACCOUNT TO RECEIVER ACCOUNT

---ACCOUNT CREATION----
CREATE TABLE accounts (
    account_id     NUMBER,
    account_number NUMBER,
    account_holder VARCHAR2(30),
    balance        NUMBER
);  

--INSERT DATA INTO ACCOUNT TABLE--
INSERT INTO ACCOUNTS VALUES (1,101,'JOHN',4000);
INSERT INTO ACCOUNTS VALUES(2,102,'RAGU',8500);

---SEQUENCE CREATION---
CREATE SEQUENCE ACCOUNT_SEQUENCE
START WITH 1
INCREMENT BY 1
MINVALUE 1
MAXVALUE 100
CYCLE
CACHE 20;

---ACCOUNT TRANSACTION--
CREATE TABLE TRANSACTIONS (
    TRANSACTION_ID   NUMBER,
    ACCOUNT_ID       NUMBER,
    TRANSACTION_TYPE VARCHAR2(30),
    AMOUNT           NUMBER,
    TRANSACTION_DATE DATE
);
----TRIGGER CREATION FOR SEQUENCE NUMBER GENERATE FOR TRANSACTION_ID COLUMN--
CREATE OR REPLACE TRIGGER transactions_trigger
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    SELECT ACCOUNT_SEQUENCE.NEXTVAL INTO :new.transaction_id FROM dual;
END;
/
SELECT * FROM TRANSACTIONS;
SELECT * FROM ACCOUNTS;

---USE CASE: PROCEDURE FOR TRANSFERRING AMOUNT FROM ONE ACCOUNT TO ANOTHER ACCOUNT---
CREATE OR REPLACE PROCEDURE trans_proc (
    sender_account_id   NUMBER,
    receiver_account_id NUMBER,
    amount              NUMBER,
    msg                 OUT VARCHAR2
) IS
    sender_balance_amount NUMBER;
BEGIN
    SELECT balance INTO sender_balance_amount
    FROM accounts WHERE account_id = sender_account_id;

    IF amount <= sender_balance_amount THEN
        UPDATE accounts SET balance = balance - amount
        WHERE account_id = sender_account_id;

        UPDATE accounts SET balance = balance + amount
        WHERE account_id = receiver_account_id;

        INSERT INTO transactions VALUES (account_sequence.NEXTVAL, sender_account_id, 'DEBIT', amount,sysdate);

        INSERT INTO transactions VALUES (account_sequence.NEXTVAL, receiver_account_id, 'CREDIT', amount,sysdate);

        msg := 'TRANSACTION COMPLETED';
    ELSE
        msg := 'INSUFFICIENT BALANCE';
    END IF;

exception
    WHEN OTHERS THEN
        msg := sqlerrm;
END;
/


DECLARE
    message VARCHAR2(100);
BEGIN
    trans_proc(2, 1, 500, message);
    dbms_output.put_line(message);
END;
/