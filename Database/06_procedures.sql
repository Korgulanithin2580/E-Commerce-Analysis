-- Step 6: Stored procedures (five examples)
USE ecommerce_sales_db;

DROP PROCEDURE IF EXISTS sp_get_customer_orders;
DROP PROCEDURE IF EXISTS sp_get_sales_between_dates;
DROP PROCEDURE IF EXISTS sp_get_products_by_category;
DROP PROCEDURE IF EXISTS sp_get_order_details;
DROP PROCEDURE IF EXISTS sp_get_top_customers;

DELIMITER //

-- Procedure 1: Get orders for one customer.
CREATE PROCEDURE sp_get_customer_orders(IN p_customer_id INT)
BEGIN
    SELECT c.customer_name, o.order_id, o.order_date, o.status
    FROM customers AS c
    JOIN orders AS o ON c.customer_id = o.customer_id
    WHERE c.customer_id = p_customer_id;
END //

-- Procedure 2: Get completed sales within a date range.
CREATE PROCEDURE sp_get_sales_between_dates(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS total_sales
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
      AND o.order_date BETWEEN p_start_date AND p_end_date;
END //

-- Procedure 3: List products in a selected category.
CREATE PROCEDURE sp_get_products_by_category(IN p_category VARCHAR(50))
BEGIN
    SELECT product_id, product_name, price, stock
    FROM products
    WHERE category = p_category
    ORDER BY product_name;
END //

-- Procedure 4: Show all items in a selected order.
CREATE PROCEDURE sp_get_order_details(IN p_order_id INT)
BEGIN
    SELECT o.order_id, o.order_date, o.status,
           p.product_name, oi.quantity, oi.price_at_purchase,
           (oi.quantity * oi.price_at_purchase) AS line_total
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    JOIN products AS p ON oi.product_id = p.product_id
    WHERE o.order_id = p_order_id;
END //

-- Procedure 5: Show top customers by completed-order spending.
CREATE PROCEDURE sp_get_top_customers(IN p_limit INT)
BEGIN
    SELECT c.customer_id, c.customer_name,
           SUM(oi.quantity * oi.price_at_purchase) AS total_spending
    FROM customers AS c
    JOIN orders AS o ON c.customer_id = o.customer_id
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
    ORDER BY total_spending DESC
    LIMIT p_limit;
END //

DELIMITER ;

-- Examples:
-- CALL sp_get_customer_orders(1);
-- CALL sp_get_sales_between_dates('2026-01-01', '2026-03-31');
-- CALL sp_get_products_by_category('Electronics');
-- CALL sp_get_order_details(1001);
-- CALL sp_get_top_customers(3);