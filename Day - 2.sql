use MyDatabase;


select * 
from customers;


-- static values 
select 
first_name,
score,
'Thapa' as last_name 
from customers;


-- create a new table called persons with columns: id, person_name, birth_date and phone
create table persons(
id int not null,
person_name varchar(100) not null,
birth_date date,
phone varchar(10) not null,
constraint pk_persons primary key (id)
)


-- add a new column named email to the persons table
alter table persons
add email varchar(50) not null;


-- remove the column phone from the persons table
alter table persons
drop column phone;


-- delete the table persons from the db
drop table persons;


-- inserting data into the customers table
insert into customers (id, first_name, country, score)
values 
	(100, 'Prajjwol', 'Nepal', Null),
	(200, 'Niraj', null, 300)


-- copy data from customers table into persons table
insert into persons(id, person_name, birth_date, phone)
select
id,
first_name, 
null,
'Not Known'
from customers;


-- change the score of customer with id 100 to 0
update customers
set 
	score = 0,
	id = 6
where id = 100;


-- change the score of customer with id 200 to 0 and update the country to 'uk'
update customers
set 
	id = 0,
	country = 'UK'
where id = 200;


-- update all customers with a null score by settting their score to 0 
update customers
set score = 0
where score is null;


-- delete all customers with id greater than 5 
delete from customers
where id > 5;


-- delete the table persons
truncate table persons;


-- retrieve all customers from germany
select *
from customers
where country = 'germany';


-- retrieve all customers who are not from germany 
select *
from customers
where country != 'germany';


-- retrieve all customers whose score is greater than 55 
select *
from customers
where score > 55;


-- retrieve all customers with score 100 or higher. 
select * 
from customers
where score >= 100;


-- retrieve all customers who are from usa and have a score greater than 55
select * 
from customers 
where country = 'USA' and score > 55;


-- retrieve all customers who are either from usa or have a score greater than 55
select * 
from customers
where country = 'USA' or score > 55;


--  retrieve all customer with a score not less than 100
select *
from customers 
where score >= 100;

-- Alternatilvely 
select *
from customers 
where not score < 100;


-- retrieve all customers whose score falls in the range between 50 and 100 
select *
from customers 
where score between 50 and 100;


-- retrieve all customers from either germany or usa.
select *
from customers 
where country = 'germany' or country = 'usa';

-- alternatively 
select * 
from customers 
where country in ('germany', 'usa');


-- find all customers whose first name starts with 'M'
select *
from customers
where first_name like 'M%';


-- find all customers whose first name ends with "n"
select *
from customers 
where first_name like '%n';


-- find all customers whose firstname contains "r".
select * 
from customers
where first_name like '%r%';


-- find all customers whose first name has 'r' in the third position.
select *
from customers 
where first_name like '__r%';


-- retrieve all data from customers and orders as spearate results
select * from customers;

select * from orders;


-- get all customers along with their orders, but only for customers who have placed an order.
select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from customers as C
inner join orders as O 
on C.id = O.customer_id;


-- get all customers along with their orders including those without orders
select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from customers as c 
left join orders as o 
on c.id = o.customer_id;

















 
		
