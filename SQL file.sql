create database intern;
use intern;

-- -----------------------------------
-- 1. Create Tables
-- -----------------------------------

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- -----------------------------------
-- 2. Insert Sample Data
-- -----------------------------------

INSERT INTO Customers (customer_id, name, country) VALUES
(1, 'Alice', 'USA'),
(2, 'Bob', 'UK'),
(3, 'Charlie', 'India');

INSERT INTO Orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2024-01-01', 250.00),
(102, 2, '2024-01-05', 400.00),
(103, 1, '2024-01-10', 150.00),
(104, 3, '2024-02-01', 300.00);

-- -----------------------------------
-- 3. SELECT + WHERE + ORDER BY
-- -----------------------------------

SELECT * FROM Orders
WHERE amount > 200
ORDER BY amount DESC;

-- -----------------------------------
-- 4. GROUP BY + Aggregate Function
-- -----------------------------------

SELECT customer_id, SUM(amount) AS total_spent
FROM Orders
GROUP BY customer_id;

-- -----------------------------------
-- 5. JOINS (INNER, LEFT, RIGHT)
-- -----------------------------------

-- INNER JOIN
SELECT c.name, o.order_date, o.amount
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

-- LEFT JOIN
SELECT c.name, o.order_date, o.amount
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN (Note: Only works in MySQL/PostgreSQL, not in SQLite)
SELECT c.name, o.order_date, o.amount
FROM Customers c
RIGHT JOIN Orders o ON c.customer_id = o.customer_id;

-- -----------------------------------
-- 6. Subquery
-- -----------------------------------

SELECT name FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders WHERE amount > 200
);

-- -----------------------------------
-- 7. View Creation
-- -----------------------------------

CREATE VIEW CustomerOrdersView AS
SELECT c.name, o.order_date, o.amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id;

-- -----------------------------------
-- 8. Index Creation
-- -----------------------------------

CREATE INDEX idx_order_date ON Orders(order_date);
