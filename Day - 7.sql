-- segment all orders into 3 categories: high, medium and low sales
select 
*, 
case 
	when three_buckets = 1 then 'High'
	when three_buckets = 2 then 'Medium'
	else 'low'
end as categorization
from 
(
select 
	orderid, 
	sales,
	ntile(3) over(order by sales desc) as three_buckets
from sales.orders
) as sub_query;



-- find the products that fall within the highest 40% of prices
select 
	* from 
(
select 
	productid,
	product,
	price,
	percent_rank() over(order by price desc) as ranking_percentage
from sales.Products
) as sub_query 
where ranking_percentage <= 0.4;


-- analyze the month- over- month performance by finding the percentage change in sales between the current and previous month
select 
	*,
	round(cast((total_Sales - ranks) as float) /ranks *100, 2) as percentage_change
from 
(
select 
	month(orderdate) as order_month,
	sum(sales) as total_Sales,
	lag(sum(sales)) over(order by month(orderdate)) as ranks
from sales.orders
group by month(orderdate)
) as sub_query;


-- analyze the customer loyalty by ranking customers based on the average number of days between orders
select 
	customerid,
	avg(days_difference) as average_Days,
	rank() over(order by coalesce(avg(days_difference),888888))as ranks
from
(
select 
	orderid,
	customerid,
	orderdate as current_orderdate,
	lead(orderdate) over(partition by customerid order by orderdate) as next_order,
	datediff(day, orderdate, lead(orderdate) over(partition by customerid order by orderdate)) as days_difference
from sales.orders
) as sub_query
group by customerid;


-- fing the lowest and highest sales for each product 
-- find the difference in sales between current and the lowest sales
select 
	*,
	(sales - lowest_Sales) as sales_difference
from 
(
select 
	productid,
	sales,
first_value(sales) over(partition by productid order by sales) as lowest_sales,
last_value(sales) over(partition by productid order by sales rows between current row and unbounded following) as highest_Sales
from sales.orders
) as sub_query;