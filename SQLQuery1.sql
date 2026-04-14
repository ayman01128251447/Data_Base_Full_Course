-- in this file we will explain the whole content of the course of the SQL server 
-- DDL data definition language for create the database
-- DML data manipulation language for manipulate in database
-- DQL data query language for retrieving/showing the data 
-- <-- this called object explorer
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
