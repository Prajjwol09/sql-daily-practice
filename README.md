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

## The Practiced Queries for Day - 1 is listed in the files above.

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

## The Practiced Queries for Day - 2 is listed in the files above.

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

## The Practiced Queries for Day - 3 is listed in the files above.

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

## The Practiced Queries for Day - 4 is listed in the files above.

---

That wraps up **Day 4**! More to come as the consistency continues.

---

# Day 5 – SQL CASE, Aggregations & Window Functions

Welcome to **Day 5** of my SQL Daily Practice!  
This session focused on conditional logic using `CASE`, aggregation techniques, analytical window functions, ranking, and frame clauses.

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

## The Practiced Queries for Day - 5 is listed in the files above.

---

That wraps up **Day 5**! The journey continues on to the next milestone.

---

# Day 6 – SQL Window Functions, Ranking, Aggregations & Duplicate Handling

Welcome to Day 6 of my SQL Daily Practice!  
This session focused on window functions for analysis, ranking techniques, rolling calculations, duplicate detection, and advanced aggregation methods. 

---

## Topics Covered

* Summing values using window partitions  
* Ranking customers and orders with ROW_NUMBER(), RANK(), and DENSE_RANK()  
* Counting total rows and grouped row counts using window functions  
* Identifying duplicate rows using partitioned counts  
* Comparing each row against aggregated values (average, min, max)  
* Rolling and running averages over ordered windows  
* Finding top-performing or lowest-performing groups  
* Assigning unique row identifiers  
* Cleaning duplicate records using partitioned window logic  

---

## The Practiced Queries for Day - 6 is listed in the files above.

---

That wraps up Day 6! The journey continues on to the next milestone.

---

# Day 7 – Advanced SQL Analytics, Ranking Logic & Time-Based Insights

Welcome to **Day 7** of my SQL Daily Practice!  
Today’s session focused on advanced analytical functions, percentile-based segmentation, customer-behavior analysis, and time-series percentage changes. 

---

## Topics Covered

* Dividing sales into 3 groups using NTILE(3)
* Creating High / Medium / Low sales categories
* Identifying products within the top 40% of prices using PERCENT_RANK()
* Calculating month-over-month total sales
* Computing percentage change between current month and previous month
* Measuring days between consecutive orders for each customer
* Ranking customers based on their average ordering interval
* Using LEAD() to access the next order date
* Finding lowest and highest sales for each product using FIRST_VALUE() and LAST_VALUE()
* Calculating the difference between current sales and lowest sales for each product

---

## The Practiced Queries for Day - 7 is listed in the files above.

---

That wraps up **Day 7**! On to the next chapter of SQL mastery.

---

# Day 8 – SQL Subqueries, CTEs & Customer-Level Analytics

Welcome to **Day 8** of my SQL Daily Practice!  
Today’s learning revolved around subqueries, standalone CTEs, multi-CTE pipelines, and combining analytical outputs to build complete customer insights.

---

## Topics Covered

* Using subqueries inside `FROM` and `WHERE` clauses  
* Filtering results using subqueries with window functions  
* Understanding and writing standalone CTEs  
* Working with multiple standalone CTEs in one query  
* Building nested CTE structures for multi-step transformations  
* Using subqueries to count total orders  
* Creating multi-CTE pipelines for:  
  - total sales per customer  
  - last order date  
  - ranking customers by total sales  
  - segmenting customers into High / Medium / Low groups  

---

## The Practiced Queries for Day - 8 is listed in the files above.

---

That wraps up **Day 8**! More SQL building blocks mastered — on to the next one.

---
