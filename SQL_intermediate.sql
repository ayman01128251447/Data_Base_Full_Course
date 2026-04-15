-- ============ Intermediate level =========
/*
comparison operator = , <> != , > , < <= , >=
logical operator And , Or , Not 
Range operator Between inclusive --> include boundries
Membership operator In , Not in
search operator Like
*/
-- logical operator
/* retrieve all customers from germany */
select * 
from Sales.Customers
where country = 'Germany'
/* Retrieve all customers who are from
the usa and have a score greater than 5000*/
select * 
from sales.customers
where country = 'USA' and score > 500
/* Retrieve all customers with a score 
not less thatn 500 */
select *
from sales.customers
where not (score<500)
-- where score >= 500 
/* Retrieve all customers whose score 
falls in the range between 100 and 500 */
select *
from sales.customers
where score between 100 and 500 
-- where score >= 100 and score <= 500 

/* Retrieve all customers from either 
Germany or USA */
select *
from sales.customers
where country in ('Germany', 'USA')
/* Find all customers whose firs name
starts with 'M' */
select * 
from sales.customers
where FirstName like 'M%'
-- where FirstName like '%n' any customer ends with n
-- where FirstName like '%r%' FirstName contains r
-- where FirstName like '__r%' r in the third position

/*
Combining Data 
ex: combine columns --> join
inner , left , right , full
ex: combine rows --> set operators
union , union all , except , intersect
*/

/* Get all customers along with their orders
but only for customers who have placed an order*/
select 
c.id, 
c.first_name,
o.order_id,
o.sales
from customers as c -- this the base of filtering 
inner join orders as o
on c.id = o.customer_id
/* Get all customers along with their orders
including those without orders */
select 
c.id, 
c.first_name,
o.order_id,
o.sales
from customers as c -- this the base of filtering 
right join orders as o
on c.id = o.customer_id


