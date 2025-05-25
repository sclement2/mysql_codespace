-- co- related queries
-- Eaxmple 1 Find the list of employee who earns more than avg salary of their own dept-- use emp_table
use emp_db;
-- list of departments. 2 approaches
-- 5 rows
select dept from emp_db.emp_table group by dept;
select DISTINCT e.dept from emp_db.emp_table e;

-- Average salary of each department
select  dept, avg(salary) from emp_db.emp_table group by dept;
-- co-related query to find the list of employee who earns more than avg salary of their own dept.
select e.`EMP_ID`, e.`LAST_NAME`, e.`DEPT`, e.`SALARY` from emp_db.emp_table e
where e.salary >
(select avg(e2.salary) from emp_db.emp_table e2
where e2.dept = e.Dept)
ORDER BY e.dept, e.salary DESC;
-- 11 rows
/*
- For each employee e, we compare their salary to the average salary in their own department (e.DEPT).
- The subquery SELECT AVG(e2.SALARY) runs once per outer row, with e.DEPT passed into it.
*/
-- Example 2 Find the employees who manage at least 1 person.
select e.`MANAGER_ID`
from emp_db.emp_table e
GROUP BY e.`MANAGER_ID`;


select * from emp_db.emp_table sub where sub.`MANAGER_ID` =

-- Find products that are more expensive than the average price(buy price ) of products in the same product line.
-- 55 rows
select * from products p where p.buyPrice >(
select avg(buyprice) from products where productLine=p.productLine);
select * from products;
-- List customers who have made a payment greater than the average payment for their country. 124 rows
--  col - customer name, country, amount . table- Customers, Payment
SELECT     c.customerName, c.country, p.amount FROM    customers c JOIN    payments p
 ON c.customerNumber = p.customerNumber WHERE    p.amount >
    (SELECT AVG(amount)  FROM payments p1    JOIN   customers c1
    ON p1.customerNumber = c1.customerNumber  WHERE  c1.country = c.country);


-- CTE - Common table expression  -- when u have a condition on the basis o calc
 -- details of emp who  is/are  getting second highest salary.
select * from emp_db.emp_table where salary = (
select max(salary) from emp_db.emp_table where salary <
	( select max(salary) from emp_db.emp_table)
    );
-- nth  highest
 with a as (select  *, dense_rank()over (order by salary desc)  as drnk from emp_db.emp_table)
  select * from a where  drnk=2;

-- list employee and how many customers they manage. Table customers, employees
with a as (select * from customers)
, b as (select * from employees)
select b.employeeNumber, b.firstName, b.lastName, count(a.customerNumber) as Total_Customers
from a join b on a.salesRepEmployeeNumber = b.employeeNumber
group by b.employeeNumber, b.firstName, b.lastName
order by b.employeeNumber;

select e.employeeNumber, count(*) from employees e inner join customers c on c.salesRepEmployeeNumber=e.employeeNumber
group by e.employeeNumber;

-- list top 4 employee and how many customers they manage. If multiple employees have the same number of customers include the each of the multiple employess. For instance if 1 employee has 10 customers and 1 employee has 9 customers and 2 employees have 8 customers and 3 employess have 7 customers the total number of items returned should be 7. Tables to use: customers, employees
with base as (Select e.employeenumber, count(*) customers
 from employees e join customers c
 on e.employeenumber = c.salesrepemployeenumber
 group by e.employeenumber),

 base2 as (select employeenumber,customers,
 dense_rank() over (order by customers desc) d_rank
 from base )
 select * from base2
 where d_rank <= 5

-- view :- Virtual table- its not physically storing the data . it is used for security reason
 -- dynamic - any update in main will reflesct in view also.
 -- 17 rows
 select *  from employees;
 create view salesemp as(
 select employeenumber, firstname, lastname, email, jobtitle from employees where jobtitle="Sales Rep");
select * from salesemp; -- 17 rows

/* Materialized view - doesn't exist in Mysql. but it a view that stores the data physically. so to see the update data we need to refresh it manually
create materialized view view name as (); */

/* Stored Procedure -  we are saving the steps to perform any task -- for code reusablity
-- Types Of Stored procedure
a. Simple - no parameter stored procedures
b. Stored Procedure with in Parameter(it can take input from user)
c. Stored Procedure with Out Parameter(it can give an output to user)
1. Create procedure :
	a. i)right click on the stored procedure folder under the database name then select create
    new procedure . A window will appear on ur screen with with pre written line of code. Write ur steps
    to do the tasks inside the begin and End block .
    ii) to save it -   click on apply on botom right corner - click apply -- click finish
    iii) refresh ur schemas to see the stored procedure
/
CREATE PROCEDURE `top5emp`()
BEGIN
with base as (Select e.employeenumber, count(*) as no_of_customers
 from employees e join customers c
 on e.employeenumber = c.salesrepemployeenumber
 group by e.employeenumber),
 base2 as (select employeenumber, no_of_customers,
 dense_rank() over (order by no_of_customers desc) d_rank
 from base )
 select * from base2  where d_rank <= 5;
END
/
2. Call the procedure :-
a. click on the flash like icon on the produre name under store procedure folder in db .
b. write query as- call procdurename();
*/
use classicmodels;
DROP PROCEDURE top5emp;

CREATE PROCEDURE `top5emp`()
BEGIN
with base as (Select e.employeenumber, count(*) as no_of_customers
 from employees e join customers c
 on e.employeenumber = c.salesrepemployeenumber
 group by e.employeenumber),
 base2 as (select employeenumber, no_of_customers,
 dense_rank() over (order by no_of_customers desc) d_rank
 from base )
 select * from base2  where d_rank <= 5;
END

call top5emp();

/*b. Stored Procedure with in Parameter(it can take input from user)/ CREATE DEFINER=`root`@`localhost` PROCEDURE `topnemp`(in n int)
BEGIN
with base as (Select e.employeenumber, count(*) as no_of_customers
 from employees e join customers c
 on e.employeenumber = c.salesrepemployeenumber
 group by e.employeenumber),
 base2 as (select employeenumber, no_of_customers,
 dense_rank() over (order by no_of_customers desc) d_rank
 from base )
 select * from base2  where d_rank <= n;
END
*/

use classicmodels;
DROP PROCEDURE topnemp;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `topnemp`(in n int)
BEGIN
with base as (Select e.employeenumber, count(*) as no_of_customers
 from employees e join customers c
 on e.employeenumber = c.salesrepemployeenumber
 group by e.employeenumber),
 base2 as (select employeenumber, no_of_customers,
 dense_rank() over (order by no_of_customers desc) d_rank
 from base )
 select * from base2  where d_rank <= n;
END $$
DELIMITER ;

call topnemp(4);
call topnemp(3);

  /*
  c. Stored Procedure with Out Parameter(it can give an output to user)
  CREATE DEFINER=`root`@`localhost` PROCEDURE `avg_sal`(out a float)
BEGIN
select avg(Salary) into a  from maydb.emp_table;
END
  */

DROP PROCEDURE avg_sal;
-- call store procedure with out parameter
CREATE DEFINER=`root`@`localhost` PROCEDURE `avg_sal`(out a float)
BEGIN
select avg(Salary) into a  from emp_db.emp_table;
END;

call classicmodels.avg_sal(@a);
select @a;

-- list of perople who earns more than avg salary
-- 9 rows
select * from emp_db.emp_table where salary>@a;

/* functions
CREATE DEFINER=`root`@`localhost` FUNCTION `cube`( a int) RETURNS int
    DETERMINISTIC
BEGIN
declare b int;
set b=a*a*a;
RETURN b;
END
*/
CREATE DEFINER=`root`@`localhost` FUNCTION `cube`( a int) RETURNS int
    DETERMINISTIC
BEGIN
declare b int;
set b=a*a*a;
RETURN b;
END
select classicmodels.cube(3);
select classicmodels.cube(buyprice) from products;
