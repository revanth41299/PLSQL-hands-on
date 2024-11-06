set serveroutput on;

/*Package Specification*/
create or replace package pkg_tutorial 
IS
function prnt_strng return varchar2; -- Declaring function
/*Declaring Procedure*/
procedure proc_superhero (f_name varchar2, l_name varchar2); 
end pkg_tutorial;
/


/*Package Body*/
create or replace package body pkg_tutorial
IS
    /*Function Part*/
    function prnt_strng RETURN VARCHAR2 IS
    BEGIN
        RETURN 'FUNCTION FROM PACKAGE BODY';
    end prnt_strng;
    
    /*Procedure Part*/
    procedure proc_superhero (f_name varchar2, l_name varchar2) IS
    BEGIN
        INSERT INTO superheroes (f_name,l_name) VALUES (f_name,l_name);
    end;
    
end pkg_tutorial;
/

create table superheroes(
f_name varchar2(20),
l_name varchar2(20)
);

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE(pkg_tutorial.prnt_strng);
END;
/

exec pkg_tutorial.proc_superhero('Iron','Man');



select * from superheroes;




