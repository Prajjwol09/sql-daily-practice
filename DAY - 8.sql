-- find the products that have a price higher than the average price of all products
select 
	* from
(
select 
	productid,
	price,
	avg(price) over() as average_price 
from sales.products
) as sub_query 
where (price > average_price);


-- rank the customers based on the total amount of sales
select 
	customerid,
	sum(sales) as total_Sales,
	rank() over(order by sum(sales) desc) as sales_Ranking
from sales.orders
group by customerid;



-- show the product ids, names, prices and total number of orders
select 
	productid,
	product, 
	price,
(select 
	count(orderid)  from sales.orders) as total_orders
from sales.products;


-- show all the customer deatils and find the total orders of each customer 
select
	c.*,
	o.total_orders
from sales.customers as c
left join
(
select 
	customerid,
	count(orderid) as total_orders
from sales.orders 
group by customerid
) as o
on c.customerid = o.customerid;


-- step 1: find the total sales per customer
-- step 2: find the last order date for each customer
-- step 3: rank customers based on total sales per customer
-- step 4: segment customers based on their total sales

-- 1st cte
with sales_cte as 
(
select
	customerid,
	sum(sales) as total_Sales
from sales.orders
group by customerid
),

-- 2nd cte
last_orderdate_cte as 
(
select 
	customerid,
	max(orderdate) as last_date_order
from sales.orders
group by CustomerID
),

-- 3rd cte
rank_cte as
(
select 
	customerid,
	total_Sales,
	rank() over(order by total_Sales desc) as ranking
from sales_cte
),

-- 4th cte
segment_cte as 
(
select 
	customerid,
case 
	when total_Sales > 100 then 'high'
	when total_Sales > 50 then 'medium'
	else 'low'
end as customer_segmentation
from sales_cte
)


-- main query
select 
	c.CustomerID,
	c.FirstName,
	c.LastName,
	c.Country,
	c.Score,
	s.total_Sales,
	l.last_date_order,
	r.ranking,
	sc.customer_segmentation
from sales.customers c
left join sales_cte as s
on c.CustomerID = s.CustomerID

left join last_orderdate_cte l
on c.CustomerID = l.CustomerID

left join rank_cte r
on c.CustomerID = r.customerid

left join segment_cte sc
on c.CustomerID = sc.customerid


