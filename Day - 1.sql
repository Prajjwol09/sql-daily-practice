-- Here USE is used to access the DB named "MyDatabase."
USE MyDatabase; 


-- Retrieve all customer data 
SELECT * 
FROM dbo.customers;


-- retrieve all sales data 
SELECT 
* FROM orders;


-- retrieving few columns
SELECT 
	order_id,
	customer_id
FROM orders;


-- retrieving name, country and scores
select 
	first_name, 
	country,
	score 
from customers;


-- retrieving customers with a score not equal to zero
select * 
from customers
where score != 0;


-- retrieve customers from germany
select * 
from customers
where country = 'Germany';


-- retrieve all customers and sort the results by the highest score first
select * 
from customers
order by score desc;


-- retrieve all customers and sort the results by the lowest score first
select *
from customers
order by score asc;


-- nested order by 
select *
from customers
order by 
	country asc,
	score desc;


-- retrieve all coustomers and sort the results by the country and then by the highest score
select *
from customers
order by 
	country asc,
	score desc; 


-- find the total score for each country and arrange then in the highest order
select 
	country, 
	sum(score) as sum_of_scores
from customers
group by country
order by sum_of_scores desc;


-- find the total score and total number of customers for each country
select 
	country,
	sum(score) as total_score,
	count(id) as Count_Of_Customers
from customers
group by country;



-- find the average score for each country considering only customers with a score not equal to zero and return only those countries with an average score greater than 430
select 
	country,
	avg(score) as average_score
from customers
where score != 0
group by country
having avg(score) > 430;


-- return unique list of all countries 
select distinct 
	country
from customers;


-- retrieve only three customer
select top 3 *
from customers;


-- retrieve the top 3 customers with the highest scores
select top 3 * 
from customers
order by score desc;


-- retrieve the lowest 2 customers based on the score
select top 2 *
from customers
order by score asc;


-- get the two most recent orders
select top 2 * 
from orders
order by order_date desc;