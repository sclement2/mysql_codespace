-- 17- May

use classicmodels;

select customerNumber from customers
union
select customernumber from orders; -- 122 rows

select customerNumber from customers
union all
select customernumber from orders; -- 448 rows

-- full outer join
SELECT c.customerName, o.orderNumber, o.orderDate
FROM customers c LEFT JOIN orders o ON c.customerNumber = o.customerNumber
union
SELECT c.customerName, o.orderNumber, o.orderDate
FROM customers c right JOIN orders o ON c.customerNumber = o.customerNumber; -- 350 rows

select DISTINCT customerNumber from orders; -- 98 rows

select customerNumber from orders
union
select customerNumber from orders; -- 98 rows

-- cross join
select * from products;-- 110
select * from productlines;-- 7
select p.productname, pd.productline  from products as p
cross join  productlines as pd; -- 770 rows

use classicmodels;

/* Type of commands in SQL
1. DDL- Data definition Language- for structure of table
	a.D- drop - to delete the complete table permanently
    Syntax-
    Drop table table_name;
    Drop database database_name;
    b.R- Rename- used to change the name of table.
    syntax-
    Rename table oldtable_name to newtable_name;
    c.C- Create- used to create table/ database/ view...
    syntax :-
    Create table tablename( col1name datatype, col2name datatype..);
    Create database databasename;
    d.A- Alter- used to modify the structure of table (columns)
    i) to add a column:-
    Syntax:- alter table table_name  add column col_name data_types;
    ii) to drop a column :-
     Syntax:- alter table table_name  drop column col_name ;
    iii) to change the name of a column:-
    Syntax:- alter table table_name  rename column old_col_name to new_col_name ;
    iv) to change datatype of the column :-
    Syntax:- alter table table_name modify column col_name  new__datatype;
    e.T- Truncate - used to delete not table but whole data(rows) inside the table
    syntax-
    truncate table_name;

2. DML - Data Manipulation Language- it works with rows only
	a. Insert - to insert new rows in table
    syntax:-
     insert into table name values( value1, value2, ...);-- to insert 1 row
     insert into table name values(value1, value2, ...),(value1, value2, ...);
     -- to add mutiple rows in one go
     insert into table_name ( col1, col3) values( val1,  val3)..;
     -- to add value to few col only
	Note- by default swl will not allow u do update or delete any row dute to safe mode on . So,
    first we need turn off the safe mode only then we can update or delete the records
    syntax-
    set sql_safe_updates= 0;
    b. delete- to delete the records/ rows from table
    syntax :- delete from table_name where colname= value;
    c. Update - to change the data of a row of a particular col
    syntax:- update table_name  set col_name = new _value where col= condition;

3. DQL - Data Query Language - to read/ fetch the data
	select
4. TCL- Transaction Control Language- it works with dml only(insert/update/delete)
	it only works if u start the transaction
    syntax - Start Transaction;
    a.Commit- Save - to save the changes permanenly.
    b.Rollback- Undo - to reverse what u just did.
5. DCL - Data Control Language - Dba- Database Administrators
	a) Grant- To give permission to a user to select / update/ delete/ insert data
    b) Revoke- To take permission back of using data.
*/

create table students (
studentID int,
name varchar(50),
email varchar(50),
courseid	int
);

alter table students add column age int;

rename table students to learners;

/*
DML - Data Manipulation Language- it works with rows only
*/

insert into learners values (1, "Suman", 35, "suman@gmail.com", 10);
insert into learners values (2,'Riya',30,'sriya@gmail.com',10),
(3,'john',40,'john@gmail.com',20),
(4,'Rohit',25,'rohit@gmail.com',20);
insert into learners values (5,'Nitin','Nitin@gmail.com',30);-- error col and val count doesn't match
insert into learners (studentid,name,email,courseid) values (5,'Nitin','Nitin@gmail.com',30);
set sql_safe_updates= 0;
update  learners set name = "nitin Kumar"  where studentid=5;
delete from learners where studentid =5;

truncate table learners; -- deletes all the rows but not the table
describe learners; -- to see the structure of table

/*
TCL- Transaction Control Language- it works with dml only(insert/update/delete)
	it only works if u start the transaction
*/

select * from learners;


start transaction;
insert into learners values (5,'Nitin',30, 'Nitin@gmail.com',30);
select * from learners;
commit;

start transaction;
insert into learners values (1, "Suman", 35, "suman@gmail.com", 10);
select * from learners;

delete  from learners where name="Nitin";
select * from learners;
insert into learners values (5,'Nitin',30, 'Nitin@gmail.com',30);
select * from learners;
delete  from learners;
select * from learners;
rollback;

select * from learners;

insert into learners values
    (1, "Suman", 35, "suman@gmail.com", 10),
    (2,'Riya',30,'sriya@gmail.com',10),
    (3,'John',40,'john@gmail.com',20),
    (4,'Rohit',25,'rohit@gmail.com',20);
-- insert into learners values (5,'Nitin',30, 'Nitin@gmail.com',30);
insert into learners values (1, "Suman", 35, "suman@gmail.com", 10);

alter table learners add column sno int unique auto_increment after name;

insert into learners (studentid, name, age, email, courseid) values
(1, "Suman", 35, "suman@gmail.com", 10);


select * from learners;

select  * from learners as a join  learners as b
where
    a.studentid=b.studentid
    and a.name=b.name
    and a.age= b.age
    and a.email=b.email
    and a.courseid=b.courseid and a.sno>b.sno;

delete a from learners as a join learners as b on a.studentid=b.studentid and a.name=b.name and a.age= b.age and a.email=b.email and
a.courseid=b.courseid and a.sno>b.sno;

select * from learners;

/* Text Function
1.upper- it  is used to see string in capital letters
2. Lower- it  is used to see string in small letters
3. Trim- it  is used to see string without any extra space on left or right side
4. Ltrim- it  is used to see string without any extra space on left
5. Rtrim-  it  is used to see string without any extra space on right
6. Concat- to see the string togethers
7. substring
8. Left
9. Right
*/
select name, upper(name) from learners;
select name, lower(name) from learners;
select "     Suman    " as name,trim("     Suman    " );
select "     Suman    " as name,ltrim("     Suman    " );
select "     Suman    " as name,rtrim("     Suman    " );
select "suman", "Deep";
select concat("suman", "Deep");
select concat(contactFirstName," ", contactlastname) as full_name from customers;
select "Data Science", substring("Data Science", 6, 5);
select "Data Science", left("Data Science", 4);
select "Data Science", right("Data Science", 4);
select monthname(orderdate) , left(monthname(orderdate), 3)  from orders;

select * from learners;

/* homework
1. Create a table  with name Course- columns- cid, cname, duration, fees
2. insert the data:
	cid,	 cname, 	duration,	 fees
	10		DA			1yr			 1000
    20		DS			1yr			 1200
    30		commerce	3yrs		 3000
    40		IT			2 yrs		 2000
    50		Fullstack	1.5 yrs		 1500
*/

-- Homework results
use classicmodels;
create table course (
    cid int,
    cname varchar(50),
    duration varchar(25),
    fees int
);

insert into course values
(10, 'DA', '1yr', 1000),
(20, 'DS', '1yr', 1200),
(30, 'commerce', '3yrs', 3000),
(40, 'IT', '2 yrs', 2000),
(50, 'Fullstack', '1.5 yrs', 1500);

select * from course;