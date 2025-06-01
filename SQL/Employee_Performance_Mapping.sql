/*
1.	Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.
*/
CREATE DATABASE IF NOT EXISTS employee;
USE employee;

-- Importing data from CSV files into the employee database
LOAD DATA INFILE '/path/to/data_science_team.csv'
INTO TABLE data_science_team
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE '/path/to/proj_table.csv'
INTO TABLE proj_table
FIELDS TERMINATED BY ','    
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
LOAD DATA INFILE '/path/to/emp_record_table.csv'
INTO TABLE emp_record_table
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- Note: Replace '/path/to/' with the actual path where the CSV files are located.
-- Ensure that the CSV files are accessible by the MySQL server and that the user has the necessary permissions to load data.
-- Ensure that the tables data_science_team, proj_table, and emp_record_table are created before loading data.
-- The tables can be created using the following SQL commands:

DROP TABLE IF EXISTS `proj_table`;
CREATE TABLE `proj_table` (
  `PROJECT_ID` text,
  `PROJ_NAME` text,
  `DOMAIN` text,
  `START _DATE` text,
  `CLOSURE_DATE` text,
  `DEV_QTR` text,
  `STATUS` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `emp_record_table`;
CREATE TABLE `emp_record_table` (
  `EMP_ID` text,
  `FIRST_NAME` text,
  `LAST_NAME` text,
  `GENDER` text,
  `ROLE` text,
  `DEPT` text,
  `EXP` int DEFAULT NULL,
  `COUNTRY` text,
  `CONTINENT` text,
  `SALARY` int DEFAULT NULL,
  `EMP_RATING` int DEFAULT NULL,
  `MANAGER_ID` text,
  `PROJ_ID` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `data_science_team`;
CREATE TABLE `data_science_team` (
  `EMP_ID` text,
  `FIRST_NAME` text,
  `LAST_NAME` text,
  `GENDER` text,
  `ROLE` text,
  `DEPT` text,
  `EXP` int DEFAULT NULL,
  `COUNTRY` text,
  `CONTINENT` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*
2.	Create an ER diagram for the given employee database.
*/
-- The ER diagram can be created using a database design tool like MySQL Workbench,
-- Lucidchart, or any other ER diagram tool. The diagram should include the following entities:
-- 1. Employee (emp_record_table)
-- 2. Data Science Team (data_science_team)
-- 3. Project (proj_table)
-- The relationships between these entities can be defined as follows:
-- 1. Employee has a one-to-many relationship with Project (one employee can manage multiple projects).
-- 2. Data Science Team is a subset of Employee (one employee can be part of the data science team).
-- 3. Employee has a one-to-many relationship with itself (one employee can manage multiple employees).
-- The ER diagram should include the attributes of each entity and the relationships between them.
-- The ER diagram can be visualized using the following SQL commands to describe the relationships:
--
-- Employee (emp_record_table):
--   - EMP_ID (Primary Key)

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
SELECT `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `ROLE`, `EXP`, `DEPT`, `SALARY`, `COUNTRY`
FROM
    employee.emp_record_table
WHERE 
    SALARY > 6000;
/*
Logic - use “Create View” and specify the query to “Select” employees “Where” their “salary” is greater than 6000
*/

-- To view the data in the created view
SELECT * FROM high_salary_employees;

/*
12.	Write a nested query to find employees with experience of more than ten years. 
Take data from the employee record table.
*/
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, ROLE, EXP, DEPT, COUNTRY from employee.emp_record_table
where EMP_ID IN (select EMP_ID from employee.emp_record_table where `EXP` > 10);
/* Logic - Using a nested query the idea is to find a list of “emp_id” “WHERE” the employee’s “exp” 
is greater than 10. This list is then used as part of the “WHERE” clause for the outer query. 
“SELECT” “emp_id” that are in the list obtained from the subquery.
*/

/*
13.	Write a query to create a stored procedure to retrieve the details of the employees 
whose experience is more than three years. Take data from the employee record table.
*/
DELIMITER //
CREATE PROCEDURE get_experienced_employees()
BEGIN
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, ROLE, EXP, DEPT, COUNTRY 
FROM employee.emp_record_table 
WHERE EXP > 3;
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

/*
Logic - First, create a stored function that returns the standard job title based on experience. 
The input to the function is the experience. Next, use that function to check whether each 
employee's assigned role matches the expected role based on their experience. 
The function is used in a Query to Compare Assigned Role vs.Standard Role
*/

DELIMITER //

CREATE FUNCTION GetStandardJobProfile(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE profile VARCHAR(50);

    IF exp <= 2 THEN
        SET profile = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET profile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp > 5 AND exp <= 10 THEN
        SET profile = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET profile = 'LEAD DATA SCIENTIST';
    ELSEIF exp > 12 AND exp <= 16 THEN
        SET profile = 'MANAGER';
    ELSE
        SET profile = 'UNKNOWN';
    END IF;

    RETURN profile;
END //


DELIMITER ;

SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,
    ROLE AS assigned_role,
    GetStandardJobProfile(EXP) AS expected_role,
    CASE 
        WHEN ROLE = GetStandardJobProfile(EXP) THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS role_check
FROM employee.data_science_team;

drop INDEX firstname_idx on employee.emp_record_table;
/*
15.	Create an index to improve the cost and performance of the query to find the employee 
whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
*/
-- First, check the execution plan without an index
select * from employee.emp_record_table
where FIRST_NAME = 'Eric';

EXPLAIN select * from employee.emp_record_table where FIRST_NAME = 'Eric';
EXPLAIN FORMAT=JSON select * from employee.emp_record_table where FIRST_NAME = 'Eric';

-- Now, create an index on the FIRST_NAME column
alter table employee.emp_record_table
modify column FIRST_NAME VARCHAR(30);
create index firstname_idx on employee.emp_record_table(first_name);
select * from employee.emp_record_table
where FIRST_NAME = 'Eric';

-- Check the execution plan again after creating the index
EXPLAIN select * from employee.emp_record_table where FIRST_NAME = 'Eric';
EXPLAIN FORMAT=JSON select * from employee.emp_record_table where FIRST_NAME = 'Eric';

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
select ROUND(AVG(SALARY),2) as avg_salary, CONTINENT, COUNTRY from employee.emp_record_table
group by CONTINENT, COUNTRY
ORDER BY CONTINENT, COUNTRY;
