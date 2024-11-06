CREATE TABLE hr_evnt_audti (
    event_type  VARCHAR2(30),
    logon_date  DATE,
    logon_time  VARCHAR2(20),
    lofgof_date DATE,
    logof_time  VARCHAR2(15)
);

--LOGON Trigger
create or replace trigger hr_logon_audit
after logon on schema
begin
    INSERT INTO hr_evnt_audti values (
    ora_sysevent,
    sysdate,
    to_char(sysdate, 'HH24:MM:SS'),
    NULL,
    NULL
    );
    
    COMMIT;
END;
/

DISC;
conn hr/HR;

select * from hr_evnt_audti;
truncate table hr_evnt_audti;




--LOGOFF Trigger

create or replace trigger hr_logoff_audit
before logoff on schema

begin
    INSERT INTO hr_evnt_audti values (
    ora_sysevent,
    NULL,
    NULL,
    sysdate,
    to_char(sysdate, 'HH24:MM:SS')
    );
    
    COMMIT;
END;
/

/* For writing database level system triggers we need to change to our High privileage user - system user */

CREATE TABLE db_evnt_audit (
    user_name  VARCHAR2(15),
    event_type VARCHAR2(30),
    logon_date DATE,
    logon_time VARCHAR2(15),
    logof_date DATE,
    logof_time VARCHAR2(15)
);

--DB level logoff trigger
CREATE OR REPLACE TRIGGER db_lgof_audit
BEFORE LOGOFF ON DATABASE
BEGIN
  INSERT INTO db_evnt_audit 
  VALUES(
    user,
    ora_sysevent,
    NULL,
    NULL,
    SYSDATE,
    TO_CHAR(sysdate, 'hh24:mi:ss')
    );
END;
/


select * from db_evnt_audit;
conn system/140900;

--DB level LOGON trigger
CREATE OR REPLACE TRIGGER db_lgon_audit
AFTER  LOGON ON DATABASE
BEGIN
  INSERT INTO db_evnt_audit 
  VALUES(
    user,
    ora_sysevent,
    SYSDATE,
    TO_CHAR(sysdate, 'hh24:mi:ss'),
    NULL,
    NULL    
    );
END;
/