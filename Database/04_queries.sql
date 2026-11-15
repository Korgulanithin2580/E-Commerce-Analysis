-- Step 4: Ten mixed SQL queries
USE ecommerce_sales_db;

-- Query 1: Display all customers from Hyderabad.
SELECT *
FROM customers
WHERE city = 'Hyderabad';

-- Query 2: Display products from highest to lowest price.
SELECT product_name, category, price
FROM products
ORDER BY price DESC;

-- Query 3: Count the total number of orders.
SELECT COUNT(*) AS total_orders
FROM orders;

-- Query 4: Find the average product price.
SELECT ROUND(AVG(price), 2) AS average_product_price
FROM products;

-- Query 5: Display customer names with their order IDs and dates (INNER JOIN).
SELECT c.customer_name, o.order_id, o.order_date, o.status
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY o.order_date;

-- Query 6: List all customers, including customers who have not ordered (LEFT JOIN).
SELECT c.customer_name, o.order_id
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- Query 7: Calculate completed sales revenue for each product.
SELECT p.product_name,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.price_at_purchase) AS product_revenue
FROM products AS p
JOIN order_items AS oi ON p.product_id = oi.product_id
JOIN orders AS o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY product_revenue DESC;

-- Query 8: Find products priced above the average product price (subquery).
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Query 9: Find customers who have not placed any orders (subquery).
SELECT customer_id, customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- Query 10: Calculate month-wise completed sales revenue.
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
       SUM(oi.quantity * oi.price_at_purchase) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;
