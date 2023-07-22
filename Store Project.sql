use sql_store;

select * from customers
-- where customer_id = 1
order by first_name;



select first_name, last_name, (points +10) * 100 AS 'Discount factor', points from customers;

select state from customers;

select distinct State from customers;

select * from products;

select name from products;

select unit_price from products;

select unit_price, unit_price *1.1 AS 'new price'from products;

-- where clause

select * from customers
where points >3000;

select * from customers
where state <>'VA';

select * from customers
where birth_date >'1990-01-01';

select * from  orders
where order_date >= '2019-01-01';

-- And OR NOT

Select * from customers
where birth_date >'1990-01-01' or
 (points > 1000 and  state = 'VA');
 
 select * from customers
 where NOT (birth_date = '1990-01-01' or points> 1000);
 
select * from order_items
where Order_id = 6 AND Unit_price * QUantity >30;

-- IN

select * from customers
where state in ('VA','GA','FL');

select * from products
where quantity_in_stock in  (49,38,72);

-- between
select * from customers
where points >=1000 AND points <=3000;

select * from customers
where points between 1000 and 3000;

select * from customers
where birth_date between '1990-01-01' AND '2000-01-01';

-- like

select * from customers
where last_name like 'brush%';

select * from customers
where last_name like '%b%';

select * from customers
where last_name like '%y';

select * from customers
where last_name like 'b____y';

select * from customers
where phone NOT like '%9';

select * from customers
where address like '%trail%' OR
      address like '%Avenue%' ;

-- REGEXP
Select * from customers
where last_name REGEXP 'Field$|MAC|rose';

Select * from customers
where last_name REGEXP '[gim]e';
-- ^ begninning
-- $ end
-- logical or 
-- [abcd]
-- [a-f]

Select * from customers
where first_name REGEXP 'elka|ambur';

Select * from customers
where last_name REGEXP 'ey$|on$';

Select * from customers
where last_name REGEXP '^MY|SE';

Select * from customers
where last_name REGEXP 'br|bu';

-- null
select * from customers
where phone is not null;

select * from orders
where shipped_date is null;

-- order by

select * from customers
order by state desc, first_name;



select order_id,unit_price, unit_price*QUantity AS Total_price from  order_items
where order_id =2
order by Total_price desc;

-- limit 
select * from customers
limit 6,3;
-- 6 means skip first6 records and pick next three records

select * from customers
order by points desc
limit 3;

-- inner join

select order_id, first_name,last_name from orders as  o
join customers  as c
on o.customer_id = c.customer_id;

select * from products;
 select * from order_items;
 
 Select * from order_items AS oi
 join products AS p
 on oi.product_id = p.product_id;
 
 select order_id, oi.product_id, quantity_in_stock,oi.unit_price, name
 from order_items as oi
 join products as p
 on oi.product_id = p.product_id;
 
 use sql_inventory;

select * from sql_store.order_items as oi
join sql_inventory.products as p
on oi.product_id = p.product_id;

-- self join 
use sql_hr;

select e.employee_id,e.First_name, m.first_name as Manager from employees as e
join employees as m
on e.reports_to = m.employee_id;


use sql_store;

select o.order_id, o.order_date, c.first_name, c.last_name, os.name as status  from orders AS o
join customers AS c
on o.customer_id = c.customer_id
join order_statuses as os
on o.status = os.order_status_id;

use sql_invoicing;

Select * from payments AS p
join clients AS c
on p.client_id = c.client_id
join Payment_methods as pm
on p.payment_method = pm.payment_method_id;

Select
p.date,
p.invoice_id,
p.amount,
c.name,
pm.name
 from payments AS p
join clients AS c
on p.client_id = c.client_id
join Payment_methods as pm
on p.payment_method = pm.payment_method_id;

use sql_store;
-- compound join
select * from order_items as oi
join order_item_notes as oin
on oi.order_id= oin.order_id
and 
oi.product_id = oin.product_id;

Select * from orders AS o
join customers as c
on o.customer_id = c.customer_id;

-- Implicit join cyntex try not to use as if u forget to add where it will get converted into cross join

select * from orders as o, customers as c
where o.customer_id = c.customer_id;

-- outer join
select * from customers AS c
join orders as o
on c.customer_id = c.customer_id
order by c.customer_id;

select c.customer_id,c.first_name, o.order_id
from customers AS c
left join orders as o
on c.customer_id = c.customer_id
order by c.customer_id;

select * from products as p
join customers as c
on p.product_id = c.customer_id;

select
c.customer_id,
p.name,
p.quantity_in_stock 
from products as p
right join customers as c
on p.product_id = c.customer_id; 

-- Union 
use sql_store;
select 
order_id,
Order_date,
' Active' As status from orders
where order_date >= '2019,01,01'
union
select 
order_id,
Order_date,
' Archived' As status from orders
where order_date < '2019,01,01';

select first_name
from customers
union
select name
from shippers;

select customer_id, first_name, points, 'Bronze' AS type from customers
where points <2000
union 
select customer_id, first_name, points, 'Silver' AS type from customers
where points between 2000 and 3000
union 
select customer_id, first_name, points, 'Gold' AS type from customers
where points >  3000
order by first_name;


insert into customers (FIRst_name, last_name,birth_date, address,city,state)
values
('john','Smith','1990-01-01', 
'address',
'city',
'ca');

select* from shippers;


Insert into shippers (name)
values 
('Shiper1'),
('shipper2'),
('Shipper3');

-- creating copy of table 
create table orders_acchived as 
select * from orders;

Insert Into Orders_acchived
select* from orders
where order_date <'2019-01-01';

select * from orders_acchived;

use sql_invoicing;

select * from invoices as i
join clients as c
using (client_id);


Create table invoices_archived
select 
i.invoice_id,
i.number,
c.name as client,
i.invoice_total,
i.payment_total,
i.invoice_date,
i.payment_date,
i.due_date
 from invoices as i
join clients as c
using (client_id)
where payment_date is not null;



