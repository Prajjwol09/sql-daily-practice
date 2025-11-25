# Day 1 – SQL Basics

Welcome to **Day 1** of my SQL Daily Practice!
Today I explored several core SQL concepts and commands that form the backbone of querying relational databases. This file will act as a structured summary of everything covered.

---

## 📌 Topics Covered

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
* SQL Commands (DDL, DML, DCL, TCL)
* Database Structure
* SQL Data Types

---

## 🧪 Practiced Queries (Day 1)

Below are the refined SQL queries practiced today:

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

## ⚖️ WHERE vs HAVING

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

## 🏗️ Database Structure

* **Database** → collection of data
* **Tables** → store data in rows and columns
* **Rows** → individual records
* **Columns** → fields with specific data types
* **Primary Key** → unique ID for rows
* **Foreign Key** → creates relationships between tables

---

## 📑 SQL Data Types

Common categories:

* **Numeric:** INT, BIGINT, DECIMAL, FLOAT
* **String:** VARCHAR, CHAR, TEXT
* **Date/Time:** DATE, TIME, DATETIME, TIMESTAMP
* **Boolean:** TRUE/FALSE

---

This concludes Day 1! More coming tomorrow.
