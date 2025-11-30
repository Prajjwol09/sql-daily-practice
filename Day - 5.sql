/* Generate a report showing the total sales for each category
high: if the sales higher than 50
medium : if the sales between 20 and 50
low : if the sales equal or lower than 20 
sort the result from lowest to highest.
*/
select
	category,
	sum(Sales) as total_Sales
from(
select 
	orderid,
	sales,
CASE
	when sales > 50 then 'high'
	when sales > 20 then 'medium'
	else 'low'
END as category 
from sales.orders
) as sub_query
group by category
order by total_Sales;


-- retrieve employee details with gender displayed as full text
select 
	gender,
case 
	when gender = 'M' then 'Male'
	when gender = 'F' then 'Female'
end as FullText_Gender
from sales.Employees;


-- retrieve customer details with abbreviated country code 
select 
	CustomerID,
	FirstName,
	Country,
case 
	when country = 'Germany' then 'DE'
	when country = 'USA' then 'US'
end as country_code
from sales.Customers;


-- case statement quick form
select 
	CustomerID,
	FirstName,
	Country,
case country            -- it can only be used for one column and for the equal operator 
	when 'Germany' then 'DE'
	when 'USA' then 'US'
end as country_code
from sales.Customers;


-- count how many times each customer has made an order with sales greater than 30.
select 
	customerid,
sum(case 
	when sales > 30 then 1
	else 0
end) as higher_orders,
count(*) as total_orders
from sales.orders
group by CustomerID;


-- find the total number of customers
select 
	count(CustomerID) as total_customers 
from sales.Customers;


-- find the total sales of all orders
select 
	sum(Sales) as total_sales
from sales.Orders;


-- find the average sales of all orders
select 
	avg(sales) as average_Sales
from sales.orders;


-- analyze the scores in customers table
select 
	count(customerid) as no_of_customer,
	avg(isnull(Score,0)) as average_score,
	sum(isnull(Score,0)) as total_Score,
	max(score) as max_score,
	min(score) as min_Score
from sales.customers;


-- find the total sales across all orders
select 
	sum(Sales) as total_Sales
from sales.orders;


-- find the total sales for each product
select 
	productid,
	SUM(sales) as total_sales
from sales.orders
group by productid;


-- find the total sales for each product, additionally provide details such as orderid and order date 
select 
	productid,
	orderid,
	orderdate,
	sum(sales) over(partition by productid) as total_sales
from sales.orders;


-- find the total sales across all orders, aditionally provide details such as orderid and order date
select 
	orderid,
	orderdate,
	sum(sales) over() as total_Sales
from sales.orders;


-- find the total sales for each combination of product and order status
select
	productid,
	orderstatus,
	sales,
	sum(sales) over (partition by productid, orderstatus) as combo 
from sales.orders;


-- rank each order based on their sales from highest to lowest, additionally provide details such as orderid and order date
select 
	orderid,0
	orderdate,
	sales,
	rank() over (order by sales desc) as ranks_basedon_sales
from sales.orders;


-- frame clause
select 
	orderid,
	orderdate,
	orderstatus,
	sales,
	sum(sales) over(partition by orderstatus order by orderdate rows between current row and 2 following) as frame
from sales.orders;