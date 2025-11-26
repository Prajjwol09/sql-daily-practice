# Day 1 – SQL Basics

Welcome to **Day 1** of my SQL Daily Practice!
Today I explored several core SQL concepts and commands that form the backbone of querying relational databases. This file will act as a structured summary of everything covered.

---

## Topics Covered

* SQL Query Structure
* `SELECT` Statement
* `FROM` Clause
* `WHERE` Clause
* `ORDER BY` and Nested Ordering
* `GROUP BY`
* `HAVING`
* Difference Between `WHERE` and `HAVING`
* `DISTINCT`
* `TOP` 
* SQL Commands (DDL, DML, DQL)
* Database Structure
* SQL Data Types

---

## 🧪 Practiced Queries (Day 1)

Below are the SQL queries practiced today:

```sql
-- Switch to the database
USE MyDatabase;

-- Retrieve all customer data
SELECT *
FROM dbo.customers;

-- Retrieve all sales data
SELECT *
FROM orders;

-- Retrieve specific columns
SELECT 
    order_id,
    customer_id
FROM orders;

-- Retrieve name, country, and scores
SELECT 
    first_name,
    country,
    score
FROM customers;

-- Customers with a score not equal to zero
SELECT *
FROM customers
WHERE score != 0;

-- Customers from Germany
SELECT *
FROM customers
WHERE country = 'Germany';

-- Sort customers by highest score
SELECT *
FROM customers
ORDER BY score DESC;

-- Sort customers by lowest score
SELECT *
FROM customers
ORDER BY score ASC;

-- Nested ORDER BY: country ASC, score DESC
SELECT *
FROM customers
ORDER BY 
    country ASC,
    score DESC;

-- Total score per country (highest first)
SELECT 
    country,
    SUM(score) AS sum_of_scores
FROM customers
GROUP BY country
ORDER BY sum_of_scores DESC;

-- Total score and number of customers per country
SELECT 
    country,
    SUM(score) AS total_score,
    COUNT(id) AS Count_Of_Customers
FROM customers
GROUP BY country;

-- Average score per country (score != 0) and avg > 430
SELECT 
    country,
    AVG(score) AS average_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;

-- Unique list of countries
SELECT DISTINCT country
FROM customers;

-- Retrieve only three customers
SELECT TOP 3 *
FROM customers;

-- Top 3 highest-scoring customers
SELECT TOP 3 *
FROM customers
ORDER BY score DESC;

-- Lowest 2 customers by score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

-- Two most recent orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;
```
---

## WHERE vs HAVING

| `WHERE`                        | `HAVING`                      |
| ------------------------------ | ----------------------------- |
| Filters rows before grouping   | Filters groups after grouping |
| Cannot use aggregate functions | Can use aggregate functions   |
| Comes before `GROUP BY`        | Comes after `GROUP BY`        |

---

## ⚙️ SQL Commands

### DDL – Data Definition Language

* `CREATE`
* `ALTER`
* `DROP`
* `TRUNCATE`

### DML – Data Manipulation Language

* `SELECT`
* `INSERT`
* `UPDATE`
* `DELETE`

---

## Database Structure

* **Database** → collection of data
* **Tables** → store data in rows and columns
* **Rows** → individual records
* **Columns** → fields with specific data types
* **Primary Key** → unique ID for rows
* **Foreign Key** → creates relationships between tables

---

## SQL Data Types

Common categories:

* **Numeric:** INT, BIGINT, DECIMAL, FLOAT
* **String:** VARCHAR, CHAR, TEXT
* **Date/Time:** DATE, TIME, DATETIME, TIMESTAMP
* **Boolean:** TRUE/FALSE

---

This concludes Day 1! More coming tomorrow.

--- 

# Day 2 – SQL Execution Order, DDL/DML, INSERT, WHERE, LIKE, and JOINs

Welcome to **Day 2** of my SQL Daily Practice!  
Today I explored deeper SQL fundamentals including execution order, multi-query execution, creating/modifying tables, inserting data, copying data, filtering with operators, pattern matching with `LIKE`, and working with JOINs.

---

## Topics Covered

* SQL Execution Order  
* Multi-Query Execution  
* Static Values in `SELECT`
* DDL – `CREATE`, `ALTER`, `DROP`, `TRUNCATE`
* DML – `INSERT`, `UPDATE`, `DELETE`
* Insert Using `SELECT`
* Difference Between `DROP`, `DELETE`, and `TRUNCATE`
* `WHERE` Operator & Conditions  
* `LIKE` Pattern Matching  
* Reading Data From Multiple Tables  
* No Join (separate queries)  
* `INNER JOIN`  
* `LEFT JOIN`

---

## Practiced Queries (Day 2)

```sql
-- Switch to the database
USE MyDatabase;

-- Retrieve all customer data
SELECT * 
FROM customers;

-- Using static values in SELECT
SELECT 
    first_name,
    score,
    'Thapa' AS last_name
FROM customers;

-- Create a new table called persons
CREATE TABLE persons (
    id INT NOT NULL,
    person_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    phone VARCHAR(10) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

-- Add a new column named email
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;

-- Remove the column phone
ALTER TABLE persons
DROP COLUMN phone;

-- Delete the table persons
DROP TABLE persons;

-- Insert data into customers
INSERT INTO customers (id, first_name, country, score)
VALUES 
    (100, 'Prajjwol', 'Nepal', NULL),
    (200, 'Niraj', NULL, 300);

-- Copy data from customers into persons
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT 
    id,
    first_name,
    NULL,
    'Not Known'
FROM customers;

-- Update score and id for customer with id 100
UPDATE customers
SET 
    score = 0,
    id = 6
WHERE id = 100;

-- Update customer 200
UPDATE customers
SET 
    id = 0,
    country = 'UK'
WHERE id = 200;

-- Update all customers with NULL score
UPDATE customers
SET score = 0
WHERE score IS NULL;

-- Delete customers with id greater than 5
DELETE FROM customers
WHERE id > 5;

-- Truncate table
TRUNCATE TABLE persons;

-- Customers from Germany
SELECT *
FROM customers
WHERE country = 'germany';

-- Customers not from Germany
SELECT *
FROM customers
WHERE country != 'germany';

-- Score greater than 55
SELECT *
FROM customers
WHERE score > 55;

-- Score 100 or higher
SELECT *
FROM customers
WHERE score >= 100;

-- Customers from USA and score > 55
SELECT *
FROM customers
WHERE country = 'USA' AND score > 55;

-- USA or score > 55
SELECT *
FROM customers
WHERE country = 'USA' OR score > 55;

-- Not less than 100
SELECT *
FROM customers
WHERE score >= 100;

-- Using NOT
SELECT *
FROM customers
WHERE NOT score < 100;

-- Score between 50 and 100
SELECT *
FROM customers
WHERE score BETWEEN 50 AND 100;

-- From Germany or USA
SELECT *
FROM customers
WHERE country IN ('germany', 'usa');

-- First name starts with M
SELECT *
FROM customers
WHERE first_name LIKE 'M%';

-- First name ends with n
SELECT *
FROM customers
WHERE first_name LIKE '%n';

-- First name contains r
SELECT *
FROM customers
WHERE first_name LIKE '%r%';

-- 'r' in 3rd position
SELECT *
FROM customers
WHERE first_name LIKE '__r%';

-- No join – separate queries
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN (only customers with orders)
SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;

-- LEFT JOIN (include customers without orders)
SELECT 
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;
```

---

## WHERE Operator Highlights

Used for row-level filtering:  
* `=`  
* `!=`, `<>`  
* `>`, `<`, `>=`, `<=`  
* `BETWEEN`  
* `IN`  
* `NOT`

---

## LIKE Pattern Matching

| Pattern | Meaning | Example Match |
|---------|---------|---------------|
| `'M%'` | starts with M | Mark |
| `'%n'` | ends with n | John |
| `'%r%'` | contains r | Harry |
| `'__r%'` | r in 3rd position | Aaron |

---

## SQL Commands

### DDL – Data Definition Language

* `CREATE`
* `ALTER`
* `DROP`
* `TRUNCATE`

### DML – Data Manipulation Language

* `INSERT`
* `UPDATE`
* `DELETE`

### DQL – Data Query Language

* `SELECT`

---

This concludes **Day 2**! More practice coming tomorrow.

---
