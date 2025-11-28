use MyDatabase;

-- get all customers along with their orders, including orders without matching customers
select 
	c.id,
	c.first_name,
	o.order_id
from customers c
right join orders o
on c.id = o.customer_id;


-- get all customers along with their orders, including orders without matching customers(using left join) 
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


-- get all customers who have not placed any order
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


-- get all orders without matching customers(using left join) 
select *
from orders o
left join customers c
on o.customer_id = c.id
where c.id is null;


-- find customers without orders and orders wihtout customers
select 
	c.id,
	c.first_name,
	o.customer_id,
	o.order_id
from customers c
full join orders o
on c.id = o.customer_id
where c.id is null 
or 
	o.customer_id is null;


-- get all customers along with their orders, but only for customers who have placed an order (without using inner join)
select 
	c.id,
	o.customer_id,
	c.first_name,
	o.order_id
from customers c
left join orders o 
on c.id = o.customer_id
where o.order_id is not null;


-- generate all possible combination of customers and orders 
select *
from customers
cross join orders;


/* 
using sales db, retrieve a list of all orders, along with the related customer, product and employee details. 
for each order, display:
- order id 
- customers name
- product name
- sales amount
- product price
- sales persons name 
*/
use SalesDB;

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


-- combine the data from employees and customers into one table 
select 
	FirstName,
	LastName
from sales.Employees
union 
select 
	FirstName,
	LastName
from sales.Customers;


-- combine the data from employees and customers into one table including duplicates
select 
	FirstName,
	LastName
from sales.Customers
union all 
select 
	firstname,
	lastname
from sales.Employees;


-- find employess who are not customers at the same time
select 
	firstname,
	lastname
from sales.Employees
except 
select 
	firstname,
	lastname
from sales.Customers;


-- find the employees who are also customers
select 
	firstname, 
	lastname 
from sales.Employees
intersect 
select
	firstname, 
	lastname 
from sales.Customers;


-- orders are stored in separate tables (orders and orders archive). Combine all orders into one report wihout duplicates.
select 
'Order' as SourceTable
	   ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.Orders
union
select 
'OrderArchive' as SourceTable	
	   ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
from sales.OrdersArchive
Order by OrderID asc;


-- concatenate the first name and country into one column 
select 
	CONCAT(FirstName,' ', country) as ConcatenatedColumn
from sales.Customers ;


-- find customers whose firstname contains leading or trailing spaces
select 
	first_name
from customers
	where first_name != TRIM(first_name);


-- replace '-' with '/'
select 
	order_date,
	replace (order_date, '-', '/') as replaced_Date
from orders;


-- calculate the length of each customers first name 
select 
	first_name, 
	len(first_name) as name_length
from customers;


-- retrieve the first two and last two characters of each first name
select 
	first_name,
	left(trim(first_name), 2) as left_extract,
	right(trim(first_name), 2) as right_extract
from customers;


-- retrieve a list of customers first names removing the first character 
select 
	first_name,
	substring(trim(first_name), 2, len(trim(first_name))) as extracted_name
from customers;


-- numeric functions
select 
9.912,
	round(9.912, 2) as rounded_2,
	round(9,912, 0) as rounded_0,
	round(9.912, 1) as rounded_1;


-- ABS 
select 
	-100 as random_number,
	abs(-100) as changed_column;


-- Date and Time 
select 
	orderid,
	creationtime,
	GETDATE() as today_Date
from sales.orders;


select 
	creationtime,
	day(creationtime) as day_number,
	month(creationtime) as month_number,
	year(creationtime) as month_number
from sales.orders;



select 
	creationtime,

-- date part
	datepart(year, creationtime) as year,
	datepart(week, creationtime) as week,
	datepart(hour, creationtime) as hour,

-- date name
	datename(month, creationtime) as month_name,

--date trunc
	datetrunc(month, creationtime) as month_truncated,

-- end of month 
	eomonth(creationtime) as eom
from sales.orders;


-- how many orders were placed each year?
select 
	year(orderdate) as YearOfOrder,
	count(*) as order_numbers
from sales.orders
group by year(orderdate);


-- how many orders were placed each month?
select 
	datename(month, orderdate) as MonthOfOrder,
	count(*) as order_numbers
from sales.orders
group by datename(month, orderdate)
order by count(*) asc;


-- show all orders that were placed during the month of february
select 
datename(month, orderdate) as month_name,
count(*) as order_number
from sales.orders
where datename(month, orderdate) = 'February'
group by datename(month, orderdate);