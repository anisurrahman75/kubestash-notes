-- Check if db_one exists
SHOW DATABASES LIKE 'db_one';
-- If exists, check for the users table and count rows
USE db_one;
SHOW TABLES LIKE 'users';
SELECT COUNT(*) AS user_count FROM users;

-- Check if db_two exists
SHOW DATABASES LIKE 'db_two';
-- If exists, check for the products table and count rows
USE db_two;
SHOW TABLES LIKE 'products';
SELECT COUNT(*) AS product_count FROM products;
