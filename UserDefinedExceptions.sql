--User Defined Exceptions
set serveroutput on;


create or replace procedure usr_dfn_excp(user_id varchar2)
IS
invalid_user_id exception; --exception Declaration

begin
    if substr(user_id,1,5) != 'icode' then
        raise invalid_user_id;  -- Exception using raise statement
    end if;
    dbms_output.put_line('Accepted');
    
exception
        when invalid_user_id then
            dbms_output.put_line('Invalid User ID : ' || user_id);
        /*Exception raised using raise_application_error*/
        raise_application_error(-20001, 'Invalid User ID : ' || user_id);   
end;
/

exec usr_dfn_excp('icod5');




begin
    raise value_error;
exception
    when value_error then
        raise_application_error(-20001,'Invalid User ID ',true);
end;
/