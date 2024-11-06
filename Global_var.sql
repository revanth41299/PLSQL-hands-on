<< outer >> -- label 'used to access Global variable inside local block' 
 DECLARE	--Outer Block 
    v_manager_name VARCHAR2(30) := 'PETER';	-- Global Variable 
    v_doj          DATE := '15-JUN-2015';
BEGIN
    DECLARE			-- Inner Block 
        v_emp_name VARCHAR2(20) DEFAULT 'TOMMY';	-- Local Variable 
        v_doj      DATE := '14-SEP-2015';
    BEGIN
        dbms_output.put_line('Local Variable : Employee ' || v_emp_name);
        dbms_output.put_line('EMP_DOJ : ' || v_doj);
        dbms_output.put_line('Global Variable Priniting from Inner Block : Manager ' || v_manager_name);
        dbms_output.put_line('MANAGER_DOJ : '
                             || outer.v_doj
                             || ' Printing from inner block using label');
    END;

    dbms_output.put_line('Global Variable Priniting from Outer Block : Manager ' || v_manager_name);
    dbms_output.put_line('MANAGER_DOJ : ' || v_doj);
END;