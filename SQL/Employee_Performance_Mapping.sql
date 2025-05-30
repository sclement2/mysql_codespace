-- Active: 1747550732943@@127.0.0.1@3306@employee
/*
3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee 
record table, and make a list of employees and details of their department.
*/
select `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPT` from employee.emp_record_table;

/*
4.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four
*/
select `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPT`, `EMP_RATING` from employee.emp_record_table
where `EMP_RATING` < 2; -- Less than two
select `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPT`, `EMP_RATING` from employee.emp_record_table
where `EMP_RATING` > 4;
select `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPT`, `EMP_RATING` from employee.emp_record_table
where `EMP_RATING` between 2 and 4;

/*
5.	Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee 
table and then give the resultant column alias as NAME.
*/
select CONCAT(first_name, ' ', last_name) as NAME from employee.emp_record_table where `DEPT` = 'Finance';

/*
6.	Write a query to list only those employees who have someone reporting to them. Also, show the number of 
reporters (including the President).
*/
SELECT 
    e.EMP_ID, 
    e.FIRST_NAME, 
    e.LAST_NAME, 
    e.ROLE, 
    count(m.EMP_ID) as num_employees from employee.emp_record_table as e
join employee.emp_record_table as m on e.EMP_ID = m.MANAGER_ID
GROUP BY e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE
ORDER BY num_employees DESC;

/*
7.	Write a query to list down all the employees from the healthcare and finance 
departments using union. Take data from the employee record table.
*/
select `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPT` from employee.emp_record_table where `DEPT` = 'Healthcare'
UNION
select `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPT` from employee.emp_record_table where `DEPT` = 'Finance';

/*
8.	Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, 
ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee 
rating along with the max emp rating for the department.
*/
select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
       MAX(EMP_RATING) OVER (PARTITION BY DEPT) as max_emp_rating 
from employee.emp_record_table;

/*
9.	Write a query to calculate the minimum and the maximum salary of the employees in 
each role. Take data from the employee record table.
*/
select max(SALARY) as max_salary, min(SALARY) as min_salary, ROLE from employee.emp_record_table
group by ROLE;

/*
10.	Write a query to assign ranks to each employee based on their experience. Take 
data from the employee record table.
*/
SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,
    DENSE_RANK() OVER (ORDER BY EXP DESC) AS experience_rank
FROM 
    employee.emp_record_table;

/*
11.	Write a query to create a view that displays employees in various countries whose salary is more 
than six thousand. Take data from the employee record table.
*/
CREATE VIEW high_salary_employees AS
SELECT 
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    SALARY, 
    COUNTRY
FROM
    employee.emp_record_table
WHERE 
    SALARY > 6000;
-- To view the data in the created view
SELECT * FROM high_salary_employees;

/*
12.	Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.
*/
select EMP_ID, FIRST_NAME, LAST_NAME, EXP from employee.emp_record_table
where EXP > (select distinct 10 from employee.emp_record_table);

/*
13.	Write a query to create a stored procedure to retrieve the details of the employees 
whose experience is more than three years. Take data from the employee record table.
*/
DELIMITER //
CREATE PROCEDURE get_experienced_employees()
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP FROM employee.emp_record_table WHERE EXP > 3;
END //
DELIMITER ;
-- To call the stored procedure
CALL get_experienced_employees();
-- To drop the stored procedure
DROP PROCEDURE IF EXISTS get_experienced_employees;
-- To check the stored procedure
SHOW PROCEDURE STATUS WHERE Name = 'get_experienced_employees';

/*
14.	Write a query using stored functions in the project table to check whether the job profile assigned 
to each employee in the data science team matches the organization’s set standard.

The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.
*/
select EMP_ID, FIRST_NAME, LAST_NAME, EXP, ROLE,
case 
    when EXP <= 2 then 'JUNIOR DATA SCIENTIST'
    when EXP > 2 and EXP <= 5 then 'ASSOCIATE DATA SCIENTIST'
    when EXP > 5 and EXP <= 10 then 'SENIOR DATA SCIENTIST'
    when EXP > 10 and EXP <= 12 then 'LEAD DATA SCIENTIST'
    when EXP > 12 and EXP <= 16 then 'MANAGER'
end as JOB_PROFILE
from employee.emp_record_table;

/*
15.	Create an index to improve the cost and performance of the query to find the employee 
whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
*/


/*
16.	Write a query to calculate the bonus for all the employees, based on their ratings and 
salaries (Use the formula: 5% of salary * employee rating).
*/
select  EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING, (0.05 * SALARY * EMP_RATING ) as Bonus 
from employee.emp_record_table;

/*
17.	Write a query to calculate the average salary distribution based on the continent and 
country. Take data from the employee record table.
*/
select AVG(SALARY) as avg_salary, CONTINENT, COUNTRY from employee.emp_record_table
group by CONTINENT, COUNTRY
ORDER BY CONTINENT, COUNTRY;

select * from employee.emp_record_table where FIRST_NAME = 'Eric';
EXPLAIN select * from employee.emp_record_table where FIRST_NAME = 'Eric';
EXPLAIN FORMAT=JSON select * from employee.emp_record_table where FIRST_NAME = 'Eric';
