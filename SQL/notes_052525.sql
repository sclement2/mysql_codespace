-- Index -  helps to finds something quickly
/*
when to use index - 1. if u have a big dataset
2. When frequently u have to fetch the data
3. Very rarely u manipulate it ( insert / update/ delete)


When not to use index - 1. when dataset is small and query gives to result quickly.
2. when rarely u have to fetch data
3. Very frequently u manipulate data.
*/

create index i1 on orders(ordernumber);
show indexes  from orders;
alter table orders drop index i1 ;

-- copy table from one database to another
use classicmodels;
create table emp_table as select * from emp_db.emp_table;
select * from emp_table;

/* ER diagram- entity relationship diagram
relation will be there between tables if they have primary key and foreign key
relationaships- One to one-   table 1 1 value occurs just once  sam in table 2
				one to many - team vs players
                many to one - students vs course
                many to many - many student in one course  and one students enroll for many courses
*/

-- add a primary key to the emp_record_table
ALTER TABLE `employee`.`emp_record_table` 
MODIFY COLUMN `EMP_ID` VARCHAR(25) NOT NULL,
ADD PRIMARY KEY (`EMP_ID`);

show TABLES;

DESCRIBE employee.emp_record_table;

-- Check data types of both columns
DESCRIBE employee.emp_record_table;
DESCRIBE employee.proj_table;

-- Align the data types of proj_id in emp_record_table and project_id in proj_table
alter table emp_record_table
MODIFY COLUMN PROJ_ID VARCHAR(25) NULL;

-- Add a primary key to the proj_table
alter table proj_table
MODIFY COLUMN PROJECT_ID VARCHAR(25) NOT NULL,
ADD PRIMARY KEY (project_id);

-- Add a foreign key constraint to emp_record_table referencing proj_table
-- Won't work since proj_id in emp_record_table is not aligned with project_id in proj_table
ALTER TABLE emp_record_table
ADD CONSTRAINT fk_emp_project
FOREIGN KEY (proj_id)
REFERENCES proj_table(project_id);

-- Check for any proj_id values in emp_record_table that do not exist in proj_table
-- This query will help identify any proj_id values that are not present in proj_table
SELECT DISTINCT proj_id
FROM emp_record_table
WHERE proj_id IS NOT NULL
AND proj_id NOT IN (
    SELECT PROJECT_ID FROM proj_table
);

-- Steps to drop index and primary keys
SHOW INDEX FROM employee.emp_record_table;
DROP INDEX projid_idx ON employee.emp_record_table;
ALTER TABLE  employee.emp_record_table DROP PRIMARY KEY;
ALTER TABLE  employee.proj_table DROP PRIMARY KEY;