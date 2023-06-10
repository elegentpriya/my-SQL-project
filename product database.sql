-- Products: This table will store the products available for sale.
-- Each product has a unique ID, a name, a description, a price, and a category.
create database ONLINE_DATABASE_PRODUCT;
use online_database_product;
CREATE TABLE PRODUCTS(PRODUCT_ID INT PRIMARY KEY,
NAME VARCHAR(50),
DESCRIPTION  VARCHAR(200),
PRICE  DECIMAL(10,2),
CATEGORY INT,FOREIGN KEY (CATEGORY) REFERENCES CATEGORIES (CATEGORY_ID) );

-- Categories: This table will store the different categories of products available in the store. Each category has a unique ID and a name.

CREATE TABLE CATEGORIES(CATEGORY_ID INT PRIMARY KEY,NAME VARCHAR (50));

-- Customers: This table will store the customers who have registered on the online store.
-- Each customer has a unique ID, a name, an email address, and a password.
CREATE TABLE CUSTOMERS(CUSTOMER_ID INT PRIMARY KEY,
NAME VARCHAR(50),EMAIL_ADDRESS VARCHAR(30),
PASSWORD VARCHAR(50));

-- Orders: This table will store the orders placed by customers.
-- Each order has a unique ID, a customer ID (foreign key to Customers table), a date, and a total amount.

CREATE TABLE ORDERS(ORDER_ID INT PRIMARY KEY, CUSTOMERS_ID INT,
 ORDERED_DATE DATETIME,TOTAL_AMOUNT  DECIMAL(10,2), FOREIGN KEY (CUSTOMERS_ID)REFERENCES CUSTOMERS(CUSTOMER_ID));
 INSERT INTO Orders (ORDER_ID,CUSTOMERS_ID,ORDERED_DATE,TOTAL_AMOUNT) VALUES
    (1, 1, '2022-05-13', 19.98),
    (2, 2, '2022-05-14', 859);


 
-- Order Items: This table will store the individual items purchased in each order.
 -- order item has a unique ID, an order ID (foreign key to Orders table), a product ID (foreign key to Products table),
 -- a quantity, and a price.

CREATE TABLE ORDER_ITEMS(ID INT PRIMARY KEY,ORDERED_ID INT,PRODUCT_ID INT,QUANTITY INT,
PRICE DECIMAL(10,2),FOREIGN KEY(ORDERED_ID)REFERENCES ORDERS(ORDER_ID),FOREIGN KEY(PRODUCT_ID) REFERENCES PRODUCTS(PRODUCT_ID));
SELECT * FROM ORDER_ITEMS;
INSERT INTO ORDER_ITEMS(ID,ORDERED_ID,PRODUCT_ID,QUANTITY,PRICE)VALUES(1,1,1,2,19.98),(2,2,2,1,859);

-- Add more sample data to the tables to test your queries with larger datasets.
INSERT INTO Categories (Category_ID, Name) VALUES(4, 'Books'),(5, 'Electronics'),(6, 'Clothing');

INSERT INTO Products (Product_ID, Name, Description, Price, Category) VALUES
    (1, 'The Great Gatsby', 'A novel by F. Scott Fitzgerald', 9.99, 1),
    (2, 'iPhone 12', 'Apple smartphone with 128GB storage', 799.00, 2),
    (3, 'Levi\'s 501 Jeans', 'Classic straight-leg jeans', 59.99, 3);

INSERT INTO Customers (Customer_ID, Name,EMAIL_ADDRESS, Password) VALUES
    (1, 'John Doe', 'johndoe@example.com', 'password123'),
    (2, 'Jane Smith', 'janesmith@example.com', 'qwerty123');
    INSERT INTO Customers (Customer_ID, Name,EMAIL_ADDRESS, Password) VALUES
	(3, 'LENAPILLIP', 'LENA@GMAIL.COM', 'PASSWORD');

-- Adding 10 more products to the Products table
SET FOREIGN_KEY_CHECKS=0;

INSERT INTO Products (Product_ID, Name, Description, Price, Category)
VALUES 
  (1002, 'Samsung Galaxy S21', 'Latest smartphone from Samsung', 799.00, 4),
  (1003, 'Sony WH-1000XM4', 'Noise-cancelling headphones', 349.00, 5),
  (1004, 'Amazon Echo Dot', 'Smart speaker with Alexa', 49.99, 6),
  (1005, 'Apple Watch Series 7', 'Latest smartwatch from Apple', 399.00, 7),
  (1006, 'Kindle Paperwhite', 'Waterproof e-reader', 129.99, 8),
  (1007, 'Nike Air Max 270', 'Athletic shoes for men', 150.00, 9),
  (1008, 'Adidas Ultraboost 21', 'Running shoes for women', 180.00, 10),
  (1009, 'Under Armour HeatGear', 'Compression leggings for women', 60.00, 11),
  (1010, 'Wilson NFL Official', 'Official football of the NFL', 129.99, 12),
  (1011, 'GoPro HERO9 Black', 'Action camera with 5K video', 449.99, 13);

SET FOREIGN_KEY_CHECKS=1;


-- Retrieving all products in a specific category (category ID = 2)
SELECT * FROM Products WHERE Category = 2;

-- Retrieving all orders placed by a specific customer (customer ID = 1)
SELECT * FROM Orders WHERE Customers_id = 1;

-- Retrieving the total revenue generated by the store in May 2023
SELECT SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN Order_items od ON o.order_ID = od.ID
JOIN Products p ON od.Product_ID = p.Product_ID
WHERE o.Ordered_Date BETWEEN '2022-05-15' AND '2022-05-30';
select * from order_items;
-- Retrieving the top 5 best-selling products in the store
SELECT p.Name, SUM(od.Quantity) AS TotalSold
FROM Products p
JOIN Order_items od ON p.Product_ID = od.Product_ID
GROUP BY p.Name
ORDER BY TotalSold DESC
LIMIT 5;

-- Retrieving the average rating for each product
SELECT p.Name, AVG(r.Rating) AS AverageRating
FROM Products p
JOIN Reviews r ON p.Product_ID = r.ProductID
GROUP BY p.Name;
-- Adding a new table for reviews and retrieving average ratings:

-- Adding Reviews table to the schema
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    Rating INT,
    Comment VARCHAR(255),
    FOREIGN KEY (ProductID) REFERENCES Products(Product_ID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(Customer_ID)
);

-- Adding sample data to the Reviews table
INSERT INTO Reviews (ReviewID, ProductID, CustomerID, Rating, Comment)
VALUES (1, 1, 1, 4, 'Great product'),
       (2, 1, 2, 3, 'Good product'),
       (3, 2, 3, 5, 'Excellent product'),
       (4, 3, 1, 2, 'Not so good product'),
       (5, 3, 2, 4, 'Very good product');

-- Retrieving the average rating for each product
SELECT p.Name, AVG(r.Rating) AS AverageRating
FROM Products p
LEFT JOIN Reviews r ON p.Product_ID = r.ProductID
GROUP BY p.Name;
-- Adding a new table for discounts and retrieving discounted prices:

-- Adding Discounts table to the schema
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY,
    ProductID INT,
    DiscountPercentage DECIMAL(5,2),
    StartDate DATE,Enddate date);
   -- Adding a new table for shipping addresses:

-- Adding ShippingAddresses table to the schema
CREATE TABLE ShippingAddresses (
AddressID INT PRIMARY KEY,
CustomerID INT,StreetAddress VARCHAR(255),
City VARCHAR(50),
StateProvince VARCHAR(50),
Country VARCHAR(50),
PostalCode VARCHAR(20),
FOREIGN KEY (CustomerID) REFERENCES Customers(Customer_ID)
);

-- Adding sample data to the ShippingAddresses table
INSERT INTO ShippingAddresses (AddressID, CustomerID, StreetAddress, City, StateProvince, Country, PostalCode)
VALUES (1, 1, '123 Main St', 'Anytown', 'CA', 'USA', '12345'),
       (2, 2, '456 Oak Ave', 'Sometown', 'NY', 'USA', '67890'),
       (3, 3, '789 Pine Blvd', 'Othertown', 'TX', 'USA', '23456');
-- Retrieving the shipping address for each order:

-- Retrieving the shipping address for each order
SELECT o.Order_ID, c.Name, sa.StreetAddress, sa.City, sa.StateProvince, sa.Country, sa.PostalCode
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.name
JOIN ShippingAddresses sa ON o.AddressID = sa.AddressID;
-- Updating data in the tables:

-- Updating the price of a specific product (ProductID = 1)
UPDATE Products SET Price = 12.99 WHERE ProductID = 1;

-- Updating the shipping address of a specific order (OrderID = 1)
UPDATE Orders SET ShippingAddressID = 2 WHERE OrderID = 1;
-- Deleting data from the tables:

-- Deleting a specific product (ProductID = 1) and its related order details and reviews
DELETE FROM Products WHERE ProductID = 1;
DELETE FROM OrderDetails WHERE ProductID = 1;
DELETE FROM Reviews WHERE ProductID = 1;

-- Deleting a specific order (OrderID = 2) and its related order details
DELETE FROM OrderDetails WHERE OrderID = 2;
DELETE FROM Orders WHERE OrderID = 2;




