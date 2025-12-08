-- step 1: create a partition function
create partition function partition_by_year (date)
as range left for values ('2023-12-31', '2024-12-31', '2024-12-31')


-- query the lists of all existing partition function
select
	*
from sys.partition_functions;


-- step 2: create file groups
alter database salesdb add filegroup fg_2023;
alter database salesdb add filegroup fg_2024;
alter database salesdb add filegroup fg_2025;
alter database salesdb add filegroup fg_2026;


-- remove the filegroup
alter database salesdb remove filegroup fg_2023;


-- query all existing filegroups
select 
	*
from sys.filegroups;


-- step 3: create data files and add .ndf files to each filegroup
alter database salesdb add file 
(
	name = P_2023,  -- logical name 
	filename = 'D:\SQL With Bara\P_2023.ndf'
)
to filegroup fg_2023;


alter database salesdb add file 
(
	name = P_2024,  -- logical name 
	filename = 'D:\SQL With Bara\P_2024.ndf'
)
to filegroup fg_2024;


alter database salesdb add file 
(
	name = P_2025,  -- logical name 
	filename = 'D:\SQL With Bara\P_2025.ndf'
)
to filegroup fg_2025;


alter database salesdb add file 
(
	name = P_2026,  -- logical name 
	filename = 'D:\SQL With Bara\P_2026.ndf'
)
to filegroup fg_2026;



-- checking meta data
select 
	f.name as filegroup_name,
	m.name as logical_filename,
	m.physical_name as file_path,
	m.size as file_size
from sys.filegroups f
join sys.master_files m 
on f.data_space_id = m.data_space_id
where m.database_id = DB_ID('salesdb')


-- step 4: create partition scheme
create partition scheme scheme_by_year 
as partition partition_by_year
to (fg_2023, fg_2024, fg_2025, fg_2026)


-- query the lists of all partition scheme
select 
	ps.name as scheme_name,
	pf.name as function_name,
	dds.destination_id as number,
	fg.name as filegroup_name
from sys.partition_schemes ps
join sys.partition_functions pf on ps.function_id = pf.function_id
join sys.destination_data_spaces dds on ps.data_space_id = dds.data_space_id
join sys.filegroups fg on dds.data_space_id = fg.data_space_id


-- step 5: create partitioned table
create table sales.partitioned_order
(
	orderid int,
	orderdate date,
	sales int
) on scheme_by_year(orderdate);


-- inserting data into the table
insert into sales.partitioned_order 
values 
(1, '2023-12-31', 1000),
(2, '2024-12-31', 1000),
(3, '2025-12-31', 1000),
(4, '2026-12-31', 1000),
(1, '2027-12-31', 1000),
(1, '2028-12-31', 1000)


-- accessing the table
select * from sales.partitioned_order


-- checking the meta data
select 
	p.partition_number as number,
	f.name as filegroup_name,
	p.rows as rows_number
from sys.partitions p 
join sys.destination_data_spaces dds on p.partition_number = dds.destination_id
join sys.filegroups f on dds.data_space_id = f.data_space_id
where OBJECT_NAME(p.object_id) = 'partitioned_order';
