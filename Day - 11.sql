-- step 1: create a log table 
create table sales.employeelogs
(
LogID int identity(1,1) primary key,
employeeID int,
logmessage varchar(255),
logdate date
)


-- step 2: create trigger on employees table
create trigger employee_trg on sales.employees
after insert 
as
begin
	insert into sales.employeelogs (employeeID, logmessage, logdate)
	select 
		employeeid,
		'New Employee added = ' + cast (employeeid as varchar),
		getdate()
	from inserted
end


-- setp 3: insert new data into employees
insert into sales.Employees
values 
(
6, 'Kriti', 'Ghimire', 'IT Head', '2002-08-08', 'F', 200000, 3
)

select * from sales.employeelogs


-- indexes 
select 
	*
from sales.DBIndexes
where country = 'USA' and score> 500; 




-- creating clustered index
create clustered index index_dbindexes_customerid on sales.dbindexes(customerid)


-- dropping index
drop index index_dbindexes_customerid on sales.dbindexes


-- creating non-clustered index
create index index_DBindexes_lastname on sales.dbindexes(lastname)


-- composite index
create index compindex_dbindexes on sales.dbindexes(country, score) 


-- creating clustered columnstore index
create clustered columnstore index index_DBindexes_customerid on sales.dbindexes


-- create unique index
create unique nonclustered index unique_index_dbindexes on sales.products(product)


-- create filter index
create nonclustered index filtered_index_dbindex on sales.customers(country)
where country = 'usa';


-- list all indexes on a specific table
sp_helpindex 'sales.dbindexes'


-- monitoring index usage
select 
	t.name as table_name,
	i.name as index_name,
	i.type_desc as index_type,
	i.is_primary_key as primary_key_info,
	i.is_unique as unique_key_info,
	s.user_seeks,
	s.user_scans,
	s.user_updates,
	s.last_system_seek,
	s.last_system_scan
from sys.indexes i
join sys.tables t
on i.object_id = t.object_id
left join sys.dm_db_index_usage_stats s
on s.object_id = i.object_id



select * from sys.tables;

select * from sys.dm_db_index_usage_stats;

select * from sys.dm_db_missing_index_details;

