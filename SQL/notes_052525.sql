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