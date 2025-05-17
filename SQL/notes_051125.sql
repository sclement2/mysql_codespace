-- 11th May
-- aggregation functions  with group by
-- no of emp in each dept
 select count(emp_id) as Total_EMP from EMP_TABLE;
select dept, count(emp_id) as Total_EMP from EMP_TABLE
group by dept;
-- show me no of emp for each gender
select  gender,count(emp_id) as Total_EMP
from emp_table group by GENDER with rollup;


-- show me avg salary as per each role
select role,avg(SALARY) as Avg_sal from emp_table
 group by ROLE with rollup;
-- total salary of each dept
select dept, sum(salary) from emp_table
group by dept with rollup;
-- to filter data  individually for each row we have -where
-- to filter the entire group  -- having
select dept, sum(salary) from emp_table
group by dept  having sum(salary) > 30000;
-- show me total emp working in each dept but only of
-- those dept who have more than 5 emp
select dept, count(emp_id) from emp_table group by
dept having count(emp_id) > 5;
/* show me the total salary of each role if  max
salary of the role is above 7k just for females.*/
select role, sum(salary) from emp_table where GENDER="F"
group by role having max(salary) > 7000;
-- Get the highest salary in each department.
select dept, max(salary) from emp_table group by dept;
-- if we more than one condition
-- show me the details of emp from asia who are females
select * from emp_table where CONTINENT="Asia" and gender =
"F";
-- show me the details of emp  who are from asia or who are females
select * from emp_table where CONTINENT="Asia" or gender =
"F";
--  Get all employees who are from Asia and
-- have more than 5 years of experience.
select * from emp_table where continent ='Asia' and exp >5;
-- get the detail of emp from india, China, France
select * from emp_table where country= "India" or
country="China" or country= "France";
-- if u have multiple conditions based on a single col u can use in
select * from emp_table where country in ("India" ,"China" ,"France");
-- show we emp who are not from india, china, france
select * from emp_table where country not in ("India" ,"China" ,"France");
-- use classicmodels database
select * from orders;
select count(ordernumber) from orders;
/* date and time function
1. year -- to fetch only year no out of date
2. month-  to fetch only month no out of date
3. Monthname - it wil fetch month names as january , ..
4. day - it will give u date value
5. dayname - it will give u name of the day like monday , tuesday..
6. weekofyear- it will give u week no out 52  bcz in a year we have 52 weeks
7. hour- to get the hour value
8. minute- to get minute value
9. second- to get the  value in second
10. now -- it will give u current date and time
*/
 select year(orderdate), orderdate  from orders;
 select month(orderdate), orderdate  from orders;
select monthname(orderdate), orderdate  from orders;
select day(orderdate), orderdate  from orders;
select dayname(orderdate), orderdate  from orders;
select weekofyear(orderdate), orderdate  from orders;
select now();-- to see current date and time
select hour(now());
select minute(now());
select second(now());
-- how many  orders i got in each year
select  year(orderdate) as yr, count(ordernumber) from orders group by yr;
-- join-- when we need the data which is not present in a single table
/*
Note : for joining tables atleast one common col is required
types of joins:-
1. Inner join :- it show only the matching rows from both the tables
2. Left Join :- It shows all the rows from left table and only matching data
from right table
3. Right Join - It shows all the rows from right table and only the matching
 data from left table
4. Full outer join :- it shows u all the records from both the tables
5. Self Join :- joining one table with itself as inner join
6. Cross Join :- it join every row of table 1 with every row of table 2
Union :
Union All :
*/
/*
1. what is the common col
2. Which join is required ?
Syntax of join :
select colnames  from table1(left table)  join type  table 2 (right table)
on table1. common col= table2.common col ;
*/


select * from orders;
select * from customers;
-- i want  to see the customer id, name , credit limit, order id , order date
select customers.customernumber, customername, creditlimit, ordernumber, orderdate
from customers  inner join  orders on customers.customerNumber=orders.customerNumber;
select c.customernumber, customername, creditlimit, ordernumber, orderdate from
customers as c inner join  orders as o  on c.customerNumber=o.customerNumber;
-- left join
-- i want  to see the customer id, name , credit limit, order id , order date
-- of all the customers even if they are not ordering anything
select c.customernumber, customername, creditlimit, ordernumber, orderdate from
customers as c left join  orders as o  on c.customerNumber=o.customerNumber;
-- right join
-- -- i want  to see the customer id, name , credit limit, order id , order date
-- of all the orders even if their cust detail is missing
select c.customernumber, customername, creditlimit, ordernumber, orderdate from
customers as c right join  orders as o  on c.customerNumber=o.customerNumber;
-- "List all customers names and the total quantity of products they ordered,
-- using orders as the bridge table."
select * from customers;
select * from orders;
select * from orderdetails;
select c. customerNumber,c.customername,sum(quantityordered) as Total_QTY
from customers as c join orders as o  on c.customerNumber=o.customerNumber
join orderdetails as od on o.orderNumber=od.orderNumber group by
c.customerNumber, customername;
/* homework :
1.  List all customers who have placed at least one order, along with their
order dates.
2. List all customers and any orders they have placed.
Include customers who haven't placed any orders.
3. Show product names and quantities ordered by each customer.*/
