use classicmodels;
-- Question 1. List all customers who have placed at least one order, along with their order dates.
Select c.customerName, o.orderDate from customers as c
join orders as o on c.customerNumber = o.customerNumber
order by c.customerNumber, o.orderDate desc;
-- 326 rows returned

-- Question 2. List all customers and any orders they have placed. Include customers who haven't placed any orders.
select c.customerNumber, customerName, o.orderNumber from customers as c
left join orders as o on c.customerNumber = o.customerNumber
order by c.customerNumber, o.orderDate desc;
-- 350 rows returned

-- Customers that have not placed an order yet. Not in the homework
select c.customerNumber, c.customerName from customers as c
left join orders as o on c.customerNumber = o.customerNumber
where o.orderNumber is null
order by c.customerNumber;
-- 24 rows returned

-- Question 3. Show product names and quantities ordered by each customer.
select c.customerNumber, c.customerName, p.productName, sum(od.quantityOrdered) as total_quantity_ordered from customers as c
join orders as o on c.customerNumber = o.customerNumber
join orderdetails as od on o.orderNumber = od.orderNumber
join products as p on od.productCode = p.productCode
group by c.customerNumber, c.customerName, p.productName
order by c.customerNumber;
-- 2532 rows returned

-- If the above is by order and not grouped by productName. Not in the homework. This was the original query and what was desired for homework question 3
select c.customerNumber, c.customerName, p.productName, o.orderNumber, od.quantityOrdered from customers as c
join orders as o on c.customerNumber = o.customerNumber
join orderdetails as od on o.orderNumber = od.orderNumber
join products as p on od.productCode = p.productCode
order by c.customerNumber, o.orderDate desc;
-- 2996 rows returned which suggests the same products appear on multiple orders by a customer.
-- 2996 rows versus 2532 rows when grouped by product

/*
Not a homework problem
Customers that have ordered the same product in multiple orders. Show the following:
	product name,
    the number of orders with the product
	the total quantity of the product across all orders,
    the order numbers the product appears on
*/
SELECT
    c.customerNumber,
    c.customerName,
    p.productName,
    COUNT(DISTINCT o.orderNumber) AS orders_with_product,
    sum(od.quantityOrdered) AS total_quantity_ordered,
    GROUP_CONCAT(DISTINCT o.orderNumber ORDER BY o.orderNumber) AS order_numbers
FROM customers AS c
JOIN orders AS o ON c.customerNumber = o.customerNumber
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
JOIN products AS p ON od.productCode = p.productCode
-- where c.customerNumber = 112 <-- before aggregation
GROUP BY c.customerNumber, c.customerName, p.productName
HAVING COUNT(DISTINCT o.orderNumber) > 1 -- <-- after aggregation
ORDER BY c.customerNumber, orders_with_product desc, p.productName;
-- When only including the orders > 1 the rows returned is 349 rows
-- When not filtering for orders > 1 the total rows returned agrees with the original quantity total result (2532 rows)