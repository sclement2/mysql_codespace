use classicmodels;

-- Setup for students/learners table
create table students (
    studentID int,
    name varchar(50),
    email varchar(50),
    courseid	int
);

-- Add a new column to students table
alter table students add column age int;

-- Adjust the column order
alter table students modify column age int after name;

-- Change the name of the table from students to learners
rename table students to learners;

-- Add new data to learners table
insert into learners values
    (1, "Suman", 35, "suman@gmail.com", 10),
    (2,'Riya',30,'sriya@gmail.com',10),
    (3,'John',40,'john@gmail.com',20),
    (4,'Rohit',25,'rohit@gmail.com',20);

-- Add a new row to learners table
insert into learners values (5,'Nitin',30, 'Nitin@gmail.com',30);

-- Add a new column with auto-increment
alter table learners add column sno int unique auto_increment after name;

select * from learners;

-- Homework: Add a new table named course and insert data into it
-- Add new table course
create table course (
    cid int,
    cname varchar(50),
    duration varchar(25),
    fees int
);

-- Insert data into course table
insert into course values
(10, 'DA', '1yr', 1000),
(20, 'DS', '1yr', 1200),
(30, 'commerce', '3yrs', 3000),
(40, 'IT', '2 yrs', 2000),
(50, 'Fullstack', '1.5 yrs', 1500);

select * from course;