-- find the total number of orders of each month
-- Create Table As Select (CTAS)
select 
	month(orderdate) as order_month,
	count(orderid) as number_of_orders
into sales.orders_Table
from sales.orders
group by month(orderdate);


-- accessing the table
select * from sales.orders_Table;


-- dropping the table
drop table sales.orders_Table;


-- creating a temporary table
select 
	* 
into #new_orders
from sales.orders;


-- accessing the table
select
	* 
from #new_orders;


-- delete the orders whose status is delievered
delete from #new_orders
where OrderStatus = 'delivered';


-- load temp table into permanent table
select 
	* 
into sales.orders_test
from #new_orders;


-- step 1: write a query 
-- for US customers, find the total number of customers and the average score
select 
	count(customerid)  as total_customers,
	coalesce(avg(score),0)  as average_Score
from sales.customers
where country = 'USA';


-- step 2: turn the query into a stored procedure 
-- Parameter passing
alter procedure cus_summary @Country nvarchar(50) as
begin
		begin try

				-- use of variables
				declare @totalCustomers int, @totalSales float, @avgScore float, @countCus int;

				-- prepare and cleanup data 
				-- control flow statements
				if exists (select 1 from sales.customers where score is null and country = @Country)
				begin
					print('Updating score to 0');
					update sales.customers
					set score = 0
					where score is null and country = @Country
				end

				else 
				begin
					print('No null values detected')
				end;

				-- generating reports
				select 
					@totalCustomers = count(customerid), 
					@avgScore = avg(score)
				from sales.customers
				where country = @Country;

				PRINT 'The total customer of  ' + @Country + ' is ' + cast(@totalCustomers as nvarchar);
				PRINT 'The average score of ' + @Country + ' is ' + cast(@avgScore as nvarchar);


				-- find the total sales and total customers
				select 
					count(orderid) as total_orders,
					sum(sales) as total_Sales,
					1/0
				from sales.orders o
				join sales.Customers c 
				on o.CustomerID = c.CustomerID
				where country = @Country;
		end try

		begin catch
				print ('an error detected');
				print('Error Message :' + error_message());
				print('error number :' + cast(error_number() as nvarchar));
				print('Error line :' + cast(error_line() as nvarchar));
				print('error procedure :' + error_procedure());
		end catch
end;
go 

-- execute the store procedure
exec cus_summary @Country = 'germany';




