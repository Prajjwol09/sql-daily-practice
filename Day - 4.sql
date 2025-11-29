select 
	creationtime,
	format(creationtime, 'dd-MM-yyyy') AS formatted_date,
	format(creationtime, 'ss:mm:hh') as fomatted_hours,
	format(creationtime, 'dddd') as day
from sales.orders;


-- show the creation time using the following format : day wed jan q1 2025 12:34:56 pm
select 
	creationtime,
	'Day ' + format(creationtime, 'ddd MMM ') + 'Q' + datename(quarter, creationtime) 
	+ format(creationtime, ' yyyy hh:mm:ss tt') as formatted_date
from sales.orders;


-- using aggregations 
select 
	format(orderdate, 'MMM yy') AS dates,
	count(*) as no_of_orders
from sales.orders
group by format(orderdate, 'MMM yy');


-- using covert()
select 
	creationtime,
	convert(date, creationtime) as converted_Date
from sales.orders;


--using cast()
select 
	creationtime,
	cast(creationtime as date) as coverted_to_date
from sales.orders;


-- using dateadd()
select 
	orderdate,
	dateadd(year, 3, orderdate) as afterThreeyears,
	dateadd(month, 8, orderdate) as afterEightmonths
from sales.orders;


-- calculate the age of employees
select 
	birthdate,
	getdate()as today_Date,
	datediff(year, birthdate, getdate()) as age_of_employees
from sales.employees;


-- find the average shipping duration in days for each month
select 
	month(orderdate) as shipped_month,
	avg(datediff(day , orderdate, shipdate)) as avg_shipping_duration
from sales.orders
group by (month(orderdate));


-- find the average score of the customer
select 
	score,
	avg(coalesce(score,0)) over() as avg_Score
from sales.customers;


-- display the full name of customers in a single field by merging their first and last name also add 10 bonus points to each customers score
select 
	firstname,
	lastname,
	firstname + ' ' + coalesce(lastname, 'Thapa') as fullname,
	score,
	coalesce(score, 0) + 10 as bonus_score
from sales.customers;


-- sort the customers score from lowest to highest with nulls appearing at the last
select 
coalesce (score, 1000000) as scores_sorted
from sales.customers 
order by coalesce (score, 1000000) asc;


-- find the sales price for each order by dividing the sales by the quantity
select 
	sales,
	quantity,
	sales/nullif(Quantity, 0) as sales_price
from sales.OrdersArchive;


-- identify the customers who have no scores
select 
	customerid,
	firstname,
	score
from sales.customers
where score is null;


-- list all the customers who have scores
select 
	customerid,
	firstname,
	lastname,
	score
from sales.customers 
where score is not null;


--list all the details of the customers who have not placed any orders
select 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.Country,
	c.score,
	o.customerid,
	o.Orderid
from sales.customers as c
left join sales.orders as o
on c.CustomerID = o.CustomerID
where o.CustomerID is null;
