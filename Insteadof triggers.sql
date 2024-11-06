--INSTEAD OF TRIGGERS

CREATE TABLE trainer (
    name VARCHAR2(30)
);

CREATE TABLE subject (
    sub_name VARCHAR2(30)
);

select * from subject;
insert into trainer values('Binary Buddha');
insert into subject values('SQL');

create view training_view 
as 
select name,sub_name from trainer,subject;

select * from training_view ;
insert into training_view values ('User1409', 'Django');
drop view training_view;


--INSTEAD OF INSERT TRIGGER

CREATE OR REPLACE TRIGGER tr_Io_Insert
INSTEAD OF INSERT ON training_view
FOR EACH ROW
BEGIN
  INSERT INTO trainer (name) VALUES (:new.name);
  INSERT INTO subject (sub_name) VALUES (:new.sub_name);
END;
/

--INSTEAD OF UPDATE TRIGGER

CREATE OR REPLACE TRIGGER tr_Io_Update
INSTEAD OF update ON training_view
FOR EACH ROW
BEGIN
  UPDATE trainer set name = :new.name
  where name = :old.name;
  
  UPDATE subject set sub_name = :new.sub_name
  where sub_name = :old.sub_name;
  
END;
/

update training_view set sub_name = 'Python'
where sub_name = 'Django';


--INSTEAD OF DELETE TRIGGER


CREATE OR REPLACE TRIGGER tr_Io_Delete
INSTEAD OF delete ON training_view
FOR EACH ROW
BEGIN
  delete from trainer where name = :old.name;
  
  delete from subject where sub_name = :old.sub_name;
  
END;
/

delete from training_view where sub_name = 'Python';