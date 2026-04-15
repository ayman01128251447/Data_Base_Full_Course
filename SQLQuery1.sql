-- in this file we will explain the whole content of the course of the SQL server 
-- DDL data definition language for create the database
-- DML data manipulation language for manipulate in database
-- DQL data query language for retrieving/showing the data 
-- <-- this called object explorer

--======== Beginner Level file ============--

/*
Retrieve all customer data
*/
use MyDatabase
select*
from customers
/*
Retrieve all order data
*/
select*
from orders
/*
Retrieve each customer's name, country and score
*/
select
first_name,
country,
score
from customers
/*
Retrieve customers with a score not equal to 0
*/
select*
from customers
where score <> 0 -- will retriev nothing becuse all scores equal 0
/*
Retrieve customers from Germany
*/
select*
from customers
where country = 'Germany'
-- Order by
--Asc is default order in order by
/*
Retrieve all customers and sort the results by the highest score first then country
*/
select*
from customers
order by score Asc , country Asc -- order by score then country if there similarity 
-- for update specific value
update customers
set score = 500
where id = 4
/*
Find the total score for each country
*/
select -- all columns in the select must be either aggregated or included in the Group by
country,
sum(score) as score
from customers
group by country
/*
Find the total score and total number of customers for each country
*/
select
country,
sum(score) As score,
count(first_name) As total_customers
from customers
group by country
-- where filter before the aggregation
-- having filter after the aggregation
/*
Find the average score for each country
considering only customers with a score not equal to 0
And return only those countries with 
an average score greater than 430
*/
select 
country,
sum(score) as total_customers
from customers
where score <> 0
group by country
having sum(score)> 430
-- Distinct give the distinct value 
-- it can slow down your query , be carefull
/*
Return unique list of all countries
*/
select distinct
country,
first_name
from customers
-- top (number) will return the top n rows
/*
Retrieve only 3 customers
*/
select top 3 *
from customers
/*
retrieve the top 3 customers with the highest scores
*/
select top 3 *
from customers
order by score desc
/*
Get the two most recent orders
*/
select top 2 *
from orders
order by order_date desc
/*
coding order

Select distinct top 2 
	col 1,
	sum(col 2)
from  table 
where col = 10 
group by col 1
having sum(col 2)> 30
order by col asc
*/
/*
Excution order

from 
where
group by 
having 
select distinct
order by 
top
*/
-- static value 
select 
'ismail' ayman -- this is column named ayman with value ismail


-- DDL ------------------------------------------------
/*
create a new table called persons
wirh columns: id , preson_name ,birth_date , and phone
*/
create table persons(
id int ,
person_name varchar(50) not null,
birth_date date ,
phone varchar(50) not null
constraint pk_persons primary key (id)
)
/*
add a new column called email to the persons table
*/
alter table persons
add email varchar(50) not null
/*
remove the column phone fromo the persons table
*/
alter table persons
drop column phone
/*
drop the table persons from the database
*/
drop table persons
-- if i want to rename the column
-- DML -------------------------------------------
exec sp_rename 'dbo.persons.person_name','pname','column'
-- insert into (col 1, col 2)
-- values (val 1, val 2) in the same order
/*
insert data form customers into persons
*/
insert into persons(id,person_name, birth_date, phone)
select
id,
first_name,
null,
'unknown'
from customers
/*
insert two rows in persons
*/
insert into persons
values(6,'ayman',null,'011282514117'),
		(7,'ismail',null,'011282514117')
-- you can put the columns if you specify a specific columns
insert into persons(id,person_name,birth_date , phone)
values(8,'ayman',null,'011282514117'),
		(9,'ismail',null,'011282514117')
-- update statement
update persons
set phone = '01556967211'
where id = 3
/*
change the score of customer 6 to 0
*/
update customers
set score = 0 
where id = 6
/*
change the score of customer with id 10 to 0 and update the country to 'uk'
*/
update customers
set score = 0,
	country = 'UK'
where id = 10
/*
update all customers with a null score by setting their score to 0
*/
-- if you want to compare with null use (is null) not ( = null) 
update customers
set score = 0
where score is null
select * from customers
/* delete all customers with an id greater than 5 */
delete from customers
where id > 5
/* delete all data from table persons */
delete from customers
truncate table customers
/*
truncate more faster but don't work with foreign key
delete slow but work with fk
*/
