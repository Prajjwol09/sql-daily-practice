-- find the total sales for each order status, only for two products 101 and 102 
select 
	sales,
	productid,
	orderstatus,
	sum(sales) over (partition by orderstatus order by productid) as total_sales
from sales.orders
where productid in (101, 102);


-- rank customers based on their total sales
select 
	customerid,
	sum(Sales) as total_Sales,
	rank() over(order by sum(Sales) desc) as ranks
from sales.orders
group by CustomerID;


-- find the total number of orders, aditionally provide details like orderid, orderdate
select 
	orderid,
	orderdate,
	count(orderid) over() as no_of_orders
from sales.orders;


-- find the total orders for each customers
select 
	customerid,
	count(orderid) over(partition by customerid) as order_number
from sales.orders;


-- find the total number of scores for the customers
select 
	customerid,
	score,
	count(score) over() as totalNoOf_Score
from sales.Customers;


-- check whether the table 'orders' contains any duplicate rows
select
	orderid,
	count(orderid) over(partition by orderid) as check_duplicates
from sales.orders;


-- checking duplicates in orderarchive table
select 
	orderid,
	count(orderid) over(partition by orderid) as check_duplicates
from sales.OrdersArchive;


-- find the total sales across all orders, add the total sales for each product, additionally provide details such as orderid, order date
select 
	orderid, 
	productid,
	orderdate, 
	sales,
	sum(Sales) over() as total_Sales_byorders,
	sum(sales) over(partition by productid) as total_Sales_byproduct
from sales.orders;


-- find the percentage contribution of each products sales to the total sales
select 
	productid,
	sales,
	sum(sales) over() as total_Sales,
	round(cast(sales as float)/sum(Sales) over() * 100,2) as total_percentage
from sales.orders;


-- find all orders where sales are higher than the average sales across all orders.
select 
* from (
select 
	orderid, 
	sales,
	avg(sales) over() as average_Sales
from sales.orders
) as sub_query
where sales > average_Sales;


-- find the highest and lowest sales across all orders, and the highest and lowest sales for each product, additionally provide details like orderid and orderdate.
select
	orderid,
	orderdate,
	sales,
	productid,
	max(sales) over() as max_Sales_orders,
	min(sales) over() as min_Sales_orders,
	max(sales) over(partition by productid) as max_Sales_product,
	min(sales) over(partition by productid) as min_Sales_product
from sales.orders;


-- show the employees with the highest salaries
select 
* from (
select 
	employeeid,
	salary,
	max(salary) over() as highest_salary
from sales.Employees
) as sub_query 
where salary = highest_salary;


-- calculate the deviation of each sales from the minimum and maximum sales amount
select 
	orderid,
	sales,
	max(sales) over() as max_Sales,
	min(Sales) over() as min_Sales,
	sales - min(Sales) over() as devaiation_from_minimum,
	max(Sales) over() - sales as deviation_from_maximum
from sales.orders;


-- calculate the moving average of sales for each product over time, including only the next order
select 
	orderid,
	orderdate,
	sales,
	productid,
	avg(sales) over (partition by productid order by orderdate 
	rows between current row and 1 following) as Rolling_Average
from sales.orders;


-- calculate the moving average of sales for each product over time
select 
	orderid,
	orderdate,
	sales,
	productid,
	avg(sales) over (partition by productid order by orderdate) as Running_Average
from sales.orders;


-- rank the orders based on their sales from highest to the lowest 
select 
	orderid, 
	sales,
	row_number() over(order by sales desc) as rank_row_number,
	rank()		 over(order by sales desc) as ranking,
	dense_rank() over(order by sales desc) as dense_Ranking
from sales.orders;


-- find the top highest sales for each product
select 
* from (
select 
	productid,
	sales,
	row_number() over(partition by productid order by sales desc) as sales_ranking
from sales.orders
) as sub_query 
where sales_ranking = 1;


-- find the lowest 2 customers based on their total sales
select 
* from 
(
select 
	customerid,
	sum(sales) as total_Sales,
	row_number() over(order by sum(sales)) as customer_based_Sales_ranks
from sales.orders
group by CustomerID
) as sub_query 
where customer_based_Sales_ranks in (1, 2);


-- assign unique ids to the rows of the 'order archive' table
select 
	row_number() over(order by orderid) as unique_ids,
	*
from sales.OrdersArchive;


-- identify the duplicate rows in the table 'order archive' and return a clean result without any duplicates.
select 
* from 
(
select 
	row_number() over(partition by orderid order by creationtime desc) as time_based,
	*
from sales.OrdersArchive
) as sub_query 
where time_based = 1;