-- generate the sequence of numbers from 1 to 20

-- anchor query
with number_cte as 
(
select 
	1 as number 
union all 

-- recursive query
select 
	number + 1
from number_cte
where number < 20
)

-- main query
select 
	*
from number_cte
option (maxrecursion 20);


-- show the employee hierarchy by displaying each employee level within the organisation
select * from sales.employees;
 
-- anchor query
with level_cte as 
(
select 
	employeeid,
	firstname,
	managerid,
	1 as levels
from sales.Employees
where ManagerID is null

union all 

-- recursive query 
select 
	e.employeeid,
	e.firstname,
	e.managerid,
	levels + 1
from sales.Employees as e
inner join level_cte as l
on e.ManagerID = l.employeeid
)

-- main query 
select 
	*
from level_cte;


-- find the running total of sales for each month

-- creating a view
create view sales.running_total as 
(
select 
	month(orderdate) as month_of_order,
	sum(sales) as total_Sales,
	count(orderid) as total_orders,
	sum(quantity) as total_quantity
from sales.Orders
group by month(orderdate)
)


-- accessing the view
select * from sales.running_total;


-- finding the running sales per month
select 
	month_of_order,
	total_Sales,
	sum(total_sales) over(order by month_of_order) as running_Sales
from sales.running_total;


-- dropping the default view
drop view dbo.running_total;


-- provide a view that combines details from orders, products, customer and employees
create  view sales.all_details as
(
select 
	o.orderid,	
	o.OrderDate,
	coalesce (c.FirstName, ' ') + ' ' + coalesce (c.LastName, ' ') as customer_name,
	c.Country,
	p.Product,
	o.Sales,
	o.Quantity,
	e.Department,
	e.Salary
from sales.orders o
left join sales.Customers c
on o.CustomerID = c.CustomerID
left join sales.Products p
on o.ProductID = p.ProductID
left join sales.Employees e
on o.SalesPersonID = e.EmployeeID
)


-- accessing the all details view
select * from sales.all_details;


-- provide a view for the EU Sales team that combines details from all tables and excludes data related to the USA.
-- row level security 
select * from sales.all_details
where country != 'USA';