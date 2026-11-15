-- Step 4: functions
USE ecommerce_sales_db;

-- Query 1: Find the length of each customer name.

SELECT customer_name,
       LENGTH(customer_name) AS name_length
FROM customers;

-- Query 2: Find the number of days since each order was placed.

SELECT order_id,
       DATEDIFF(CURDATE(), order_date) AS days_since_order
FROM orders;

-- Query 3: Find the total quantity of products sold.

SELECT SUM(quantity) AS total_quantity_sold
FROM order_items;

-- Query 4: Count customers who have not provided a city.

SELECT COUNT(*) AS missing_city_count
FROM customers
WHERE city IS NULL; 

-- Query 5: Display customer names in uppercase and their city.

SELECT UPPER(customer_name) AS customer_name,
       COALESCE(city, 'Unknown') AS city
FROM customers;