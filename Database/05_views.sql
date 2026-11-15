-- Step 5: Create views
USE ecommerce_sales_db;

-- View 1: Customer order summary
CREATE OR REPLACE VIEW vw_customer_orders AS
SELECT c.customer_id, c.customer_name, c.city,
       o.order_id, o.order_date, o.status
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- View 2: Product sales summary (completed orders only)
CREATE OR REPLACE VIEW vw_product_sales AS
SELECT p.product_id, p.product_name, p.category,
       COALESCE(SUM(oi.quantity), 0) AS units_sold,
       COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS total_revenue
FROM products AS p
LEFT JOIN order_items AS oi
    ON p.product_id = oi.product_id
LEFT JOIN orders AS o
    ON oi.order_id = o.order_id AND o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category;

-- Run these to view the results:
-- SELECT * FROM vw_customer_orders;
-- SELECT * FROM vw_product_sales;