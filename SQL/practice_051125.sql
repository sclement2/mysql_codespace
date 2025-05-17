create database maydb;
use classicmodels;
select emp_id, last_name, dept from Emp_table limit 5;
select year(orderdate), orderdate  from orders;
select month(orderdate), orderdate  from orders;
select monthname(orderdate), orderdate  from orders;
select day(orderdate), orderdate  from orders;
select dayname(orderdate), orderdate  from orders;
select hour(now());
select year(orderdate) as yr, count(orderDate) from orders group by yr;
select weekofyear(orderdate), orderdate  from orders;
select * from customers;
select * from orders;
select c.customerNumber, customerName, creditLimit, orderNumber, orderDate from customers as c
right join orders as o on c.customerNumber=o.customerNumber;
select c.customerNumber, c.customername,sum(quantityordered) as Total_QTY from customers as c
join orders as o on c.customerNumber=o.customerNumber
join orderdetails as od on o.orderNumber=od.orderNumber
group by c.customerNumber, customerName;
/* homework :
1. List all customers who have placed at least one order, along with their
order dates.
2. List all customers and any orders they have placed. Include customers who haven't placed any orders.
3. Show product names and quantities ordered by each customer.*/