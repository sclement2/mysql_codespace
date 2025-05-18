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

/* Window Functions-
1. aggregation function as window function
	sum, avg, max, min, count
 syntax :-AGG(column) over ()-- total salary of all emp
 AGG(column) over (partition by gender)-- total salary of emp gender wise
2. Ranking Function- 
	Rank -- to assign positions- if 2 or ore member are sharing same rank next
			rank will be skipped
		eg 100, 99, 99, 98, 97:- 1,2,2,4,5 
        eg 100, 99, 99, 99, 97:- 1,2,2,2,5 
    Dense_rank - to assign positions-  but never skip any position even if mutiple 
			members are sharing same rank
		eg 100, 99, 99, 98, 97:- 1,2,2,3,4 
        eg 100, 99, 99, 99, 97:- 1,2,2,2,3
Syntax- select rank/dense_rank() over([partition by col]order by col) from tablename
3. Value Function-
	Lead- it just to check next value
    lag - it just to see previous values
    first value- to see first value 
    last value- to see last value 

select * from maydb.emp_table;
select *,sum(salary) over() from maydb.emp_table;
select *,sum(salary) over(partition by gender) from maydb.emp_table;
-- show me all column along with max yrs of  exp in each dept
select *, max(exp) over (partition by dept) from maydb.emp_table;
select *, rank() over (order by exp desc) from maydb.emp_table;
select *, dense_rank() over (order by exp desc) from maydb.emp_table;
select *, rank() over (order by exp desc) as Rnk, 
dense_rank() over (order by exp desc) as drnk from maydb.emp_table;
select *, rank() over (partition by dept order by exp desc) as Rnk, 
dense_rank() over (partition by dept order by exp desc) as drnk from maydb.emp_table;
select *, dense_rank() over (partition by dept order by exp desc) as drnk from maydb.emp_table;
*/

SELECT * from classicmodels.orders;
SELECT *, lead(shippedDate) OVER () from classicmodels.orders;
SELECT *, lag(shippedDate) OVER () from classicmodels.orders;
SELECT *, FIRST_VALUE(shippedDate) OVER () from classicmodels.orders;
select *, last_value(ordernumber) over( range between UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING) from classicmodels.orders;
select *, last_value(shippedDate) over( ORDER BY shippedDate range between UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING) from classicmodels.orders;

select * , row_number() over(order by exp) as sno from maydb.emp_table;
/* Sub - Query- when a task can be solved with single query so need to use two or more queries
together it is called sub query or nested query
*/

-- show me the details of emp who have max salary
SELECT max(salary) FROM emp_db.emp_table; ;
SELECT * FROM emp_db.emp_table WHERE
salary = (SELECT max(salary) FROM emp_db.emp_table);


-- show me the emp detail who are working in usa with out using join
-- table required- Employees, offices
select *  from employees;
select * from offices;

USE classicmodels;
select * from employees where officeCode in (select officeCode from offices where country="USA");

-- show me the detail of emp who earns salary more than avg salary of comp
select * from emp_db.emp_table where salary > (select avg(salary) from emp_db.emp_table);

-- show me the detail of person with second highest salary 
select * from emp_db.emp_table where salary = (select max(salary) from emp_db.emp_table where salary < (select max(salary) from emp_db.emp_table));

/* homework-  try the Employee mapping project */

