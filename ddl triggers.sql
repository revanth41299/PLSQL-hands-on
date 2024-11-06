CREATE TABLE schema_audit (
    ddl_date       DATE,
    ddl_user       VARCHAR2(30),
    object_created VARCHAR2(30),
    object_name    VARCHAR2(30),
    ddl_operation  VARCHAR2(30)
);


create or replace TRIGGER hr_audit
after ddl on schema 
/*Trigger will fire after every 
DDL statement executed on the schema.*/
begin
    insert into schema_audit values(
    sysdate,    
    sys_context('USERENV','CURRENT_USER'), 
    ora_dict_obj_type, 
    ora_dict_obj_name, 
    ora_sysevent);
END;
/

/*
sys_context('USERENV','CURRENT_USER') - Gives current session user name who executed DDL.
     sys_context takes upto 3 parameters and first 2 is mandatory.
        sys_context(Namespace, Parameter, Length)
      USERENV -  Oracle bultin namespace associated with current session.
      CURRENT_USER - Parameter whose value will get returned.
      
ora_dict_obj_type - type of object on which DDL statement occured.
ora_dict_obj_name - gives object name given by the user.
ora_sysevent -  Gives the information about DDL statement executed.
*/

CREATE TABLE dummy (
    dummyrec VARCHAR2(30)
);

drop table dummy;
select * from schema_audit;