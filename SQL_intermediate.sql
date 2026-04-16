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
-- the same code
select *
from customers as c , orders as o
where c.id = o.customer_id

/* Get all customers along with their orders
including those without orders */
select *
from customers as c
left join orders as o
on o.customer_id = c.id
/* Get all customers along with their orders
including orders without matching cusotmers */
select *
from orders as o 
left join customers as c 
on o.customer_id = c.id
-- the same code
select *
from customers as c 
left join orders as o 
on o.customer_id = c.id
-- Full join
/* get all customers and all orders 
even if there's no match */
select *
from customers as c
full join orders as o
on o.customer_id = c.id
-- left anti join
/* get all customers who haven't place any order */
select *
from customers as c
left join orders as o
on o.customer_id = c.id
where o.customer_id is null
-- full anti join
/* find customers without orders and orders 
without customers */
select *
from customers as c
full join orders as o
on o.customer_id = c.id
where o.customer_id is null or c.id is null
/*get all customers along with their orders 
but only for customers who have placed an 
order without using inner join*/
select *
from customers as c
full join orders as o
on c.id = o.customer_id 
where c.id is not null and o.customer_id is not null
-- cross join
-- gives all combinations from A and B
/* generate all possible combination of customers and orders */
select * 
from customers
cross join orders
/* using SalesDB retrieve a list of all orders, along with
the related customer, product , and employee details */
use SalesDB
select 
o.OrderID,
c.FirstName as customer_first_name,
c.LastName as customer_second_name,
p.[Product] ,
Quantity*Sales as 'sales amount',
p.Price,
e.FirstName as salesperson_second_name,
e.LastName as salesperson_first_name

from sales.orders as o
left join sales.customers as c on o.CustomerID= c.CustomerID
left join sales.Products as p on o.ProductID= p.ProductID
left join sales.Employees as e on o.SalesPersonID= e.EmployeeID

-- set operator 
/*
Union , Union all , except , intersect
-- use order by at the end once 
-- the number of columns must be the same
-- the same data type
-- the name of the columns in the first query
*/
-- union distinct tuples or rows
/* combine the data from employees and customers into one table*/
select CustomerID,FirstName,LastName from sales.Customers
union
select EmployeeID,FirstName,LastName from sales.employees
-- except there are except all but not in sql sever
/* find employees who are not customers at the same time */
select CustomerID,FirstName,LastName from sales.Customers
except
select EmployeeID,FirstName,LastName from sales.employees

-- intersect
/* find employees who are  customers at the same time */
select CustomerID,FirstName,LastName from sales.Customers
intersect
select EmployeeID,FirstName,LastName from sales.employees

/*order data are stored in seprte tables orders and orderArchive
combine all orders data into one report without duplicates*/
select 
'Orders' as SourseTable
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
from sales.orders
union
select 
'OrderArchive' as SourseTable
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

-- funcitons 
/*
single-row funcitons --> string ,numeric, data &time , null
multi-row functions --> aggregate , window
*/
/*
string 
manipulation --> concat, upper , lower, trim , replace
calculation --> len
extracion --> left , right , substring
*/
/* first name and country in one column
firstname is upper and country small */
select 
FirstName,
country,
concat(FirstName,' ',country) as name_counry,
upper(firstname) as capitalize,
lower(country) as small,
trim(FirstName) as NospaceInLeftOrRight,
len(FirstName) - len(trim(FirstName)) flag -- to show there are spaces in right and left or no
from sales.Customers
-- Replace(vlue,'-',' ')
/* replace file extence from txt to csv */
select
'file.txt' [fileName],
replace('file.txt','txt','csv') changeExtence
/* retriev the first and last two char of each first name
and substring */
select 
FirstName,
left(FirstName,2) leftTwoChar,
right(FirstName, 2) rightTwoChar,
substring(firstname,2 , 2) [substring]
from sales.Customers
/* retrieve customer name fom index 2 to the end*/
select 
FirstName,
substring(FirstName,2,len(FirstName)) as name
from sales.customers

-- Numeric Functions

-- Round 
select
3.516 num,
round(3.516,2) as round_2,
round(3.516,1) as round_1,
round(3.516,0) as round_0
-- ABS absolute
select
-10 num,
ABS(-10) absNum

-- Data Time functions
-- timestamp or datetime 2026-04-16 03:15:50:0000000
-- Getdate() give the current datetime
select
getdate() currentDate
