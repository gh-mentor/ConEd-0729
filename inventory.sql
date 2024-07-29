/*
This file contains a script of Transact SQL 'T-SQL' command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- database 'Inventory' already exists.
Details:
- Checks if the database 'Inventory' exists, if not, exit with an error message.
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table if they do not already exist.
- Remove all rows from the tables.
- Populates the 'categories' table with sample data.
- Populates the 'products' table with sample data.
- Create a stored procedure 'GetAllCategories' to get all categories.
- Creates a stored procedure to get all products in a specific category.
- Creates a stored procudure to get all products in a specific price range sorted by price in ascending order.
*/

-- Check if the database 'Inventory' exists otherwise exit with an error message
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'Inventory')
BEGIN
    PRINT 'Database [Inventory] does not exist. Please create the database and run this script again.'
    RETURN
END

-- Set the default database to 'Inventory'
USE Inventory
GO

-- Create a 'categories' table if it does not already exist. 
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE categories (
        id INT PRIMARY KEY,
        name NVARCHAR(50) NOT NULL,
        -- add a column 'description' to store the description of the category
        description NVARCHAR(255)
    )
END

-- Create a 'products' table if it does not already exist.
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'products')
BEGIN
    CREATE TABLE products (
        id INT PRIMARY KEY,
        name NVARCHAR(50) NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        category_id INT NOT NULL,
        -- add a column 'description' to store the description of the product
        description NVARCHAR(255),
        FOREIGN KEY (category_id) REFERENCES categories(id),
        -- add a created_at column to store the creation date of the product
        created_at DATETIME DEFAULT GETDATE(),
        -- add a updated_at column to store the last update date of the product
        updated_at DATETIME DEFAULT GETDATE()
    )
END

-- Remove all rows from the products and categories tables
TRUNCATE TABLE products
TRUNCATE TABLE categories

-- Populate the 'categories' table with sample data
INSERT INTO categories (id, name, description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Clothing and fashion accessories'),
(3, 'Books', 'Books and reading materials')

-- Populate the 'products' table with sample data
INSERT INTO products (id, name, price, category_id, description) VALUES
(1, 'Laptop', 999.99, 1, 'High-performance laptop for work and gaming'),
(2, 'Smartphone', 499.99, 1, 'Latest smartphone with advanced features'),
(3, 'T-shirt', 19.99, 2, 'Comfortable and stylish t-shirt for everyday wear'),
(4, 'Jeans', 39.99, 2, 'Classic denim jeans for casual and formal occasions'),
(5, 'Programming Book', 29.99, 3, 'Learn programming with this comprehensive guide'),
(6, 'Novel', 9.99, 3, 'Best-selling novel for entertainment and relaxation')

-- Create a stored procedure 'GetAllCategories' to get all categories
IF OBJECT_ID('GetAllCategories', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE GetAllCategories
END

CREATE PROCEDURE GetAllCategories
AS
BEGIN
    SELECT * FROM categories
END

-- Create a stored procedure to get all products in a specific category
IF OBJECT_ID('GetProductsByCategory', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE GetProductsByCategory
END

CREATE PROCEDURE GetProductsByCategory
    @category_id INT
AS
BEGIN
    SELECT * FROM products WHERE category_id = @category_id
END

-- Create a stored procedure to get all products in a specific price range sorted by price in ascending order
IF OBJECT_ID('GetProductsByPriceRange', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE GetProductsByPriceRange
END

CREATE PROCEDURE GetProductsByPriceRange
    @min_price DECIMAL(10, 2),
    @max_price DECIMAL(10, 2)
AS
BEGIN
    SELECT * FROM products WHERE price BETWEEN @min_price AND @max_price ORDER BY price ASC
END

-- End of script


