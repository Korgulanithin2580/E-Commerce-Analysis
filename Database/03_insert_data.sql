-- Step 3: Insert sample data
USE ecommerce_sales_db;

INSERT INTO customers (customer_id, customer_name, city, email) VALUES
(1, 'Rahul', 'Hyderabad', 'rahul@example.com'),
(2, 'Priya', 'Siddipet', 'priya@example.com'),
(3, 'Arjun', 'Warangal', 'arjun@example.com'),
(4, 'Sneha', 'Hyderabad', 'sneha@example.com'),
(5, 'Kiran', 'Karimnagar', 'kiran@example.com'),
(6, 'Meena', 'Nizamabad', 'meena@example.com');

INSERT INTO products (product_id, product_name, category, price, stock) VALUES
(101, 'Laptop', 'Electronics', 50000.00, 10),
(102, 'Mobile', 'Electronics', 20000.00, 15),
(103, 'Headphones', 'Electronics', 2000.00, 30),
(104, 'T-Shirt', 'Fashion', 500.00, 50),
(105, 'Shoes', 'Fashion', 1500.00, 25),
(106, 'Mixer', 'Home Appliances', 3000.00, 12),
(107, 'Smart Watch', 'Electronics', 4000.00, 20);

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(1001, 1, '2026-01-05', 'Completed'),
(1002, 2, '2026-01-10', 'Completed'),
(1003, 3, '2026-02-02', 'Completed'),
(1004, 1, '2026-02-15', 'Completed'),
(1005, 4, '2026-03-05', 'Pending'),
(1006, 5, '2026-03-12', 'Completed'),
(1007, 2, '2026-03-20', 'Completed'),
(1008, 6, '2026-03-25', 'Cancelled');

INSERT INTO order_items (item_id, order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1001, 101, 1, 50000.00),
(2, 1001, 103, 2, 2000.00),
(3, 1002, 102, 1, 20000.00),
(4, 1002, 104, 2, 500.00),
(5, 1003, 105, 1, 1500.00),
(6, 1003, 106, 1, 3000.00),
(7, 1004, 107, 2, 4000.00),
(8, 1004, 103, 1, 2000.00),
(9, 1005, 101, 1, 50000.00),
(10, 1006, 104, 3, 500.00),
(11, 1006, 105, 1, 1500.00),
(12, 1007, 102, 1, 20000.00),
(13, 1008, 106, 1, 3000.00);
