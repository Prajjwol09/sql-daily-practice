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

## Practiced Queries (Day 1)

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

## SQL Commands

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

# Day 3 – SQL Joins, Set Operations & Functions

Welcome to **Day 3** of my SQL Daily Practice!  
Today I explored different types of SQL joins, set operators, string functions, numeric functions, and date/time functions. This file summarizes everything covered along with all the queries I practiced.

---

## Topics Covered

* `RIGHT JOIN`
* `LEFT JOIN`
* `FULL JOIN`
* `CROSS JOIN`
* Multi-table joins  
* `UNION`, `UNION ALL`, `EXCEPT`, `INTERSECT`
* String functions (`TRIM`, `CONCAT`, `REPLACE`, `LEFT`, `RIGHT`, `SUBSTRING`, `LEN`)
* Numeric functions (`ROUND`, `ABS`)
* Date & Time Functions  
  * `GETDATE()`
  * `DAY`, `MONTH`, `YEAR`
  * `DATEPART`
  * `DATENAME`
  * `DATETRUNC`
  * `EOMONTH`

---

## Practiced Queries (Day 3)

```sql
USE MyDatabase;

-- get all customers along with their orders, including orders without matching customers
select 
	c.id,
	c.first_name,
	o.order_id
from customers c
right join orders o
on c.id = o.customer_id;

-- using left join for the same result
select 
	o.order_id,
	c.first_name
from orders o 
left join customers c 
on o.customer_id = c.id;

-- get all customers and all orders, even if there is no match
select *
from customers c
full join orders o
on c.id = o.customer_id;

-- get customers who have not placed any order
select 
	c.id,
	c.first_name,
	o.order_id
from customers c
left join orders o 
on c.id = o.customer_id
where o.customer_id is null;

-- get all orders without matching customers
select *
from customers c
right join orders o 
on c.id = o.customer_id
where c.id is null;

-- same using left join
select *
from orders o
left join customers c
on o.customer_id = c.id
where c.id is null;

-- customers without orders AND orders without customers
select 
	c.id,
	c.first_name,
	o.customer_id,
	o.order_id
from customers c
full join orders o
on c.id = o.customer_id
where c.id is null 
or o.customer_id is null;

-- customers with orders (without using inner join)
select 
	c.id,
	o.customer_id,
	c.first_name,
	o.order_id
from customers c
left join orders o 
on c.id = o.customer_id
where o.order_id is not null;

-- generate all possible combinations
select *
from customers
cross join orders;

-----------------------------------------------------------
-- MULTI TABLE JOIN (SalesDB)
-----------------------------------------------------------

USE SalesDB;

select 
	o.OrderID,
	o.Sales,
	c.FirstName as Customer_FName,
	c.LastName as Customer_LName,
	p.Product as ProductName,
	p.Price,
	e.FirstName as Employee_FName,
	e.LastName as Employee_LName
from sales.orders as o 
	left join sales.Customers as c
	  on o.CustomerID = c.CustomerID
	left join sales.Products as p 
	  on o.ProductID = p.ProductID
	left join sales.Employees as e
	  on o.SalesPersonID = e.EmployeeID;

-----------------------------------------------------------
-- SET OPERATIONS
-----------------------------------------------------------

-- combine employees and customers (remove duplicates)
select 
	FirstName,
	LastName
from sales.Employees
union 
select 
	FirstName,
	LastName
from sales.Customers;

-- include duplicates (UNION ALL)
select 
	FirstName,
	LastName
from sales.Customers
union all 
select 
	firstname,
	lastname
from sales.Employees;

-- employees who are not customers
select 
	firstname,
	lastname
from sales.Employees
except 
select 
	firstname,
	lastname
from sales.Customers;

-- employees who are also customers
select 
	firstname, 
	lastname 
from sales.Employees
intersect 
select
	firstname, 
	lastname 
from sales.Customers;

-----------------------------------------------------------
-- MERGING ORDERS + ORDERS ARCHIVE
-----------------------------------------------------------

select 
'Order' as SourceTable,
	[OrderID], [ProductID], [CustomerID], [SalesPersonID],
	[OrderDate], [ShipDate], [OrderStatus], [ShipAddress],
	[BillAddress], [Quantity], [Sales], [CreationTime]
from sales.Orders
union
select 
'OrderArchive' as SourceTable,
	[OrderID], [ProductID], [CustomerID], [SalesPersonID],
	[OrderDate], [ShipDate], [OrderStatus], [ShipAddress],
	[BillAddress], [Quantity], [Sales], [CreationTime]
from sales.OrdersArchive
order by OrderID asc;

-----------------------------------------------------------
-- STRING FUNCTIONS
-----------------------------------------------------------

-- concatenation
select 
	CONCAT(FirstName,' ', country) as ConcatenatedColumn
from sales.Customers;

-- find names with leading/trailing spaces
select 
	first_name
from customers
where first_name != TRIM(first_name);

-- replace '-' with '/'
select 
	order_date,
	replace (order_date, '-', '/') as replaced_Date
from orders;

-- length of first name
select 
	first_name, 
	len(first_name) as name_length
from customers;

-- extract first and last two characters
select 
	first_name,
	left(trim(first_name), 2) as left_extract,
	right(trim(first_name), 2) as right_extract
from customers;

-- remove first character
select 
	first_name,
	substring(trim(first_name), 2, len(trim(first_name))) as extracted_name
from customers;

-----------------------------------------------------------
-- NUMERIC FUNCTIONS
-----------------------------------------------------------

select 
	9.912,
	round(9.912, 2) as rounded_2,
	round(9.912, 0) as rounded_0,
	round(9.912, 1) as rounded_1;

-- ABS
select 
	-100 as random_number,
	abs(-100) as changed_column;

-----------------------------------------------------------
-- DATE & TIME FUNCTIONS
-----------------------------------------------------------

select 
	orderid,
	creationtime,
	GETDATE() as today_Date
from sales.orders;

select 
	creationtime,
	day(creationtime) as day_number,
	month(creationtime) as month_number,
	year(creationtime) as year_number
from sales.orders;

select 
	creationtime,
	datepart(year, creationtime) as year,
	datepart(week, creationtime) as week,
	datepart(hour, creationtime) as hour,
	datename(month, creationtime) as month_name,
	datetrunc(month, creationtime) as month_truncated,
	eomonth(creationtime) as eom
from sales.orders;

-----------------------------------------------------------
-- AGGREGATIONS WITH DATES
-----------------------------------------------------------

-- orders per year
select 
	year(orderdate) as YearOfOrder,
	count(*) as order_numbers
from sales.orders
group by year(orderdate);

-- orders per month
select 
	datename(month, orderdate) as MonthOfOrder,
	count(*) as order_numbers
from sales.orders
group by datename(month, orderdate)
order by count(*) asc;

-- orders placed in February
select 
	datename(month, orderdate) as month_name,
	count(*) as order_number
from sales.orders
where datename(month, orderdate) = 'February'
group by datename(month, orderdate);
```

---

This concludes **Day 3** of my SQL journey!  
More coming tomorrow.

---

# Day 4 – SQL Date, Time & Conversion Functions

Welcome to **Day 4** of my SQL Daily Practice!  
Today’s focus was on working with **dates**, **times**, **formatting**, **conversion**, **aggregations**, and **string operations**. This file serves as a structured summary of everything covered.

---

## Topics Covered

* `FORMAT()` for custom date & time formatting  
* `DATENAME()` and `DATEPART()`  
* `CONVERT()` vs `CAST()`  
* `DATEADD()` for date arithmetic  
* `DATEDIFF()` for calculating differences  
* Handling `NULL` values  
* String concatenation  

---

## Practiced Queries (Day 4)

```sql
-- Formatting date and time
SELECT 
    creationtime,
    FORMAT(creationtime, 'dd-MM-yyyy') AS formatted_date,
    FORMAT(creationtime, 'ss:mm:hh') AS formatted_hours,
    FORMAT(creationtime, 'dddd') AS day
FROM sales.orders;

-- Custom formatted output example
SELECT 
    creationtime,
    'Day ' + FORMAT(creationtime, 'ddd MMM ') + 'Q' + DATENAME(quarter, creationtime) 
    + FORMAT(creationtime, ' yyyy hh:mm:ss tt') AS formatted_date
FROM sales.orders;

-- Monthly aggregation using FORMAT()
SELECT 
    FORMAT(orderdate, 'MMM yy') AS dates,
    COUNT(*) AS no_of_orders
FROM sales.orders
GROUP BY FORMAT(orderdate, 'MMM yy');

-- Using CONVERT()
SELECT 
    creationtime,
    CONVERT(date, creationtime) AS converted_Date
FROM sales.orders;

-- Using CAST()
SELECT 
    creationtime,
    CAST(creationtime AS date) AS converted_to_date
FROM sales.orders;

-- Using DATEADD()
SELECT 
    orderdate,
    DATEADD(year, 3, orderdate) AS afterThreeYears,
    DATEADD(month, 8, orderdate) AS afterEightMonths
FROM sales.orders;

-- Calculate age from birthdate
SELECT 
    birthdate,
    GETDATE() AS today_Date,
    DATEDIFF(year, birthdate, GETDATE()) AS age_of_employees
FROM sales.employees;

-- Average shipping duration (in days) by month
SELECT 
    MONTH(orderdate) AS shipped_month,
    AVG(DATEDIFF(day, orderdate, shipdate)) AS avg_shipping_duration
FROM sales.orders
GROUP BY MONTH(orderdate);

-- Average score using COALESCE with window function
SELECT 
    score,
    AVG(COALESCE(score, 0)) OVER() AS avg_score
FROM sales.customers;

-- Combine first and last name + add bonus points
SELECT 
    firstname,
    lastname,
    firstname + ' ' + COALESCE(lastname, 'Thapa') AS fullname,
    score,
    COALESCE(score, 0) + 10 AS bonus_score
FROM sales.customers;

-- Sort scores (NULL values last)
SELECT 
    COALESCE(score, 1000000) AS scores_sorted
FROM sales.customers
ORDER BY COALESCE(score, 1000000) ASC;

-- Sales price per order
SELECT 
    sales,
    quantity,
    sales / NULLIF(quantity, 0) AS sales_price
FROM sales.OrdersArchive;

-- Customers with no scores
SELECT 
    customerid,
    firstname,
    score
FROM sales.customers
WHERE score IS NULL;

-- Customers with scores
SELECT 
    customerid,
    firstname,
    lastname,
    score
FROM sales.customers
WHERE score IS NOT NULL;

-- Customers who have NOT placed any orders
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country,
    c.score,
    o.CustomerID,
    o.OrderID
FROM sales.customers AS c
LEFT JOIN sales.orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;
```

---

That wraps up **Day 4**! More to come as the consistency continues.

---

# Day 5 – SQL CASE, Aggregations & Window Functions

Welcome to **Day 5** of my SQL Daily Practice!  
This session focused on conditional logic using `CASE`, aggregation techniques, analytical window functions, ranking, and frame clauses. Here’s a structured summary of everything covered today.

---

## Topics Covered

* Conditional logic with `CASE`
* Categorizing data using custom conditions
* Aggregations: `SUM()`, `COUNT()`, `AVG()`, `MAX()`, `MIN()`
* Handling conditional counts inside aggregates
* Window functions with `OVER()`
* Partitioning window functions by columns
* Ranking rows with `RANK()`
* Frame clauses for sliding-window calculations
* Basic statistics on tables (totals, averages, counts)

---

## Practiced Queries (Day 5)

```sql
/* Report showing total sales for each category
   high: sales > 50
   medium: 20 < sales <= 50
   low: sales <= 20
   Sorted from lowest to highest
*/
SELECT
    category,
    SUM(Sales) AS total_Sales
FROM (
    SELECT 
        orderid,
        sales,
        CASE
            WHEN sales > 50 THEN 'high'
            WHEN sales > 20 THEN 'medium'
            ELSE 'low'
        END AS category 
    FROM sales.orders
) AS sub_query
GROUP BY category
ORDER BY total_Sales;

/* Display employee gender as full text */
SELECT 
    gender,
    CASE 
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
    END AS FullText_Gender
FROM sales.Employees;

/* Customer details with abbreviated country code */
SELECT 
    CustomerID,
    FirstName,
    Country,
    CASE 
        WHEN country = 'Germany' THEN 'DE'
        WHEN country = 'USA' THEN 'US'
    END AS country_code
FROM sales.Customers;

/* Short form CASE syntax (works only for equality checks) */
SELECT 
    CustomerID,
    FirstName,
    Country,
    CASE country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN 'US'
    END AS country_code
FROM sales.Customers;

/* Count how many orders each customer made with sales above 30 */
SELECT 
    customerid,
    SUM(
        CASE 
            WHEN sales > 30 THEN 1
            ELSE 0
        END
    ) AS higher_orders,
    COUNT(*) AS total_orders
FROM sales.orders
GROUP BY CustomerID;

/* Total number of customers */
SELECT 
    COUNT(CustomerID) AS total_customers 
FROM sales.Customers;

/* Total sales across all orders */
SELECT 
    SUM(Sales) AS total_sales
FROM sales.Orders;

/* Average sales across all orders */
SELECT 
    AVG(sales) AS average_Sales
FROM sales.orders;

/* Analyze scores in customers table */
SELECT 
    COUNT(customerid) AS no_of_customer,
    AVG(ISNULL(Score,0)) AS average_score,
    SUM(ISNULL(Score,0)) AS total_Score,
    MAX(score) AS max_score,
    MIN(score) AS min_Score
FROM sales.customers;

/* Total sales across all orders */
SELECT 
    SUM(Sales) AS total_Sales
FROM sales.orders;

/* Total sales for each product */
SELECT 
    productid,
    SUM(sales) AS total_sales
FROM sales.orders
GROUP BY productid;

/* Total sales for each product with row-level details */
SELECT 
    productid,
    orderid,
    orderdate,
    SUM(sales) OVER(PARTITION BY productid) AS total_sales
FROM sales.orders;

/* Total sales overall with full row details */
SELECT 
    orderid,
    orderdate,
    SUM(sales) OVER() AS total_Sales
FROM sales.orders;

/* Total sales for each product + order status combination */
SELECT
    productid,
    orderstatus,
    sales,
    SUM(sales) OVER (PARTITION BY productid, orderstatus) AS combo 
FROM sales.orders;

/* Rank orders based on sales (highest to lowest) */
SELECT 
    orderid,
    orderdate,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS ranks_basedon_sales
FROM sales.orders;

/* Frame clause: sliding window sum for each order status */
SELECT 
    orderid,
    orderdate,
    orderstatus,
    sales,
    SUM(sales) OVER(
        PARTITION BY orderstatus 
        ORDER BY orderdate 
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS frame
FROM sales.orders;
```

---

That wraps up **Day 5**! The journey continues—on to the next milestone.

---

