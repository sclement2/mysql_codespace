-- 18- May

-- change the course table to reflect the new structure
use classicmodels;

-- Drop the course table if it exists and create a new one
 drop table course;
create table course (cid int, cname varchar(50), duration_yr double,
fees int);
insert into course values(10, "DA", 1, 1000);
insert into course values(20, "DS", 1, 1200);
insert into course values(30, "Commerce", 3, 3000);
insert into course values(40, "IT", 2, 2000);
insert into course values(50, "Fullstack", 1.5, 1500);
select * from course;

-- Constraint examples
Create table voterid(
    id int unique, 
    name varchar(20) not null, 
    age int check(age>18),
    country varchar(10) default "India");

insert into voterid values
(1, "Suman", 20, "USA"),
(2, "Nitin", 35, "USA"),
(3, "John", 40, "USA");

-- rename the id column to cid
alter table voterid rename COLUMN id to cid;
alter table course modify column cid int primary key;

-- require to specify which columns entered if all columns are not entered
insert into voterid (cid, name, age) values(4, "Riya", 30);

-- TRUNCATE table voterid;
SELECT * FROM voterid;

-- Another table example with constraints
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    status VARCHAR(10) DEFAULT 'active',
    country varchar(10) DEFAULT 'USA'
);
INSERT INTO users (user_id, username) VALUES (1, 'John');
INSERT INTO users (user_id, username) VALUES (2, 'Kate');
INSERT INTO users (user_id, username, status, country)
VALUES (3, 'Riya', 'active', 'India');
INSERT INTO users (user_id, username, country)
VALUES (4, 'Nitin', 'India');

drop table users;

-- Show table data
SELECT * from learners;
select * from course;

/* syntax for having for. key - 
alter table child table_name add constraint constraint_name foreign key(column of child table) 
 references Parent_table(column with primary key) on update cascade on delete cascade;
*/
alter table learners add constraint c_fk foreign key(courseid) 
references course(cid) on update cascade on delete cascade;

insert into learners (studentid,name, age, email, courseid)values 
(6, "Sumandeep", 34, "suman12@gmail.com", 60); -- 60  cid does not exist in course
insert into learners (studentid,name, age, email, courseid)values 
(6, "Sumandeep", 34, "suman12@gmail.com", 40);
update course set cid= 300 where cid=30;

update learners set courseid= 50 where name="Nitin";

/*
-- to add primary key 
alter table voterid add primary key(id);
-- to remove primary key 
alter table voterid drop primary key;
alter table course drop primary key;-- error it is in use for foreign key
-- to remove foreign key '
show indexes from learners;
alter table learners drop foreign key c_fk;
alter table course drop primary key;
*/

show INDEXES from voterid;
alter table voterid drop index id;
-- to remove primary key 
ALTER TABLE voterid drop PRIMARY KEY;
ALTER TABLE course drop PRIMARY KEY; -- can't drop primary key if it is referenced in other table as foreign key

-- to remove foreign key
alter table learners drop foreign key c_fk;
alter table learners drop INDEX c_fk; -- needed to drop the foreign key first and then the index???
ALTER TABLE course drop PRIMARY KEY;

-- table information
show INDEXES from learners;
show INDEXES from course;
DESCRIBE course;
DESCRIBE learners;

/* Handling NULL values
*/
select * from offices;
select * from offices where state is null;
select * from offices where state is not null;
select *, isnull(state) from offices;
select *, ifnull(state, "NA") from offices;
select *, COALESCE(state, addressLine1, addressLine2) from offices;

/* Window Functions
*/
