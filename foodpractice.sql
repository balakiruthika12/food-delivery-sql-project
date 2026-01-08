create database FoodDelivery;
use FoodDelivery;
create table customers(
cust_id int primary key,
c_name varchar(50) not null,
email varchar(50) not null,
city varchar(50) not null,
phone_no bigint unique);
create table restaurants(
restaurant_id int primary key,
res_name varchar(50) not null,
location varchar(50) not null);
create table menu_items(
item_id int primary key,
restaurant_id int,
Foreign key(restaurant_id)references restaurants(restaurant_id),
item_name varchar(40) not null,
price Decimal(10,2) check(price>0));
create table orders(
order_id int primary key,
cust_id int,
foreign key(cust_id) references customers(cust_id),
order_date Date,
total_amount decimal(10,2) not null);
create table orderitems(
order_item_id int auto_increment primary key,
order_id int,
foreign key(order_id)references orders(order_id),
item_id int unique,
quantity int);
create table payments(
payment_id int primary key,
order_id int,
foreign key(order_id) references orders(order_id),
payment_date date,
payment_status varchar(20) default 'pending');
INSERT INTO customers (cust_id, c_name, email, city, phone_no) VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', 'Delhi', 9876543210),
(2, 'Anita Verma', 'anita@gmail.com', 'Mumbai', 9123456780),
(3, 'Suresh Kumar', 'suresh@gmail.com', 'Chennai', 9988776655),
(4, 'Priya Singh', 'priya@gmail.com', 'Bangalore', 9871234567),
(5, 'Amit Patel', 'amit@gmail.com', 'Ahmedabad', 9090909090);
INSERT INTO restaurants VALUES
(1, 'Spice Hub', 'Chennai'),
(2, 'Food Court', 'Bangalore'),
(3, 'Tandoori Treats', 'Delhi'),
(4, 'Ocean Delight', 'Mumbai'),
(5, 'Green Leaf', 'Coimbatore');
INSERT INTO menu_items VALUES
(101, 1, 'Chicken Biryani', 250.00),
(102, 2, 'Veg Burger', 120.00),
(103, 3, 'Paneer Butter Masala', 220.00),
(104, 4, 'Fish Curry', 300.00),
(105, 5, 'Veg Meals', 150.00);
INSERT INTO orders VALUES
(201, 1, '2025-01-01', 250.00),
(202, 2, '2025-01-02', 120.00),
(203, 3, '2025-01-03', 220.00),
(204, 4, '2025-01-04', 300.00),
(205, 5, '2025-01-05', 150.00);
INSERT INTO orderitems (order_id, item_id, quantity) VALUES
(201, 101, 1),
(202, 102, 2),
(203, 103, 1),
(204, 104, 3),
(205, 105, 2);
INSERT INTO payments VALUES
(301, 201, '2025-01-01', 'Paid'),
(302, 202, '2025-01-02', 'Paid'),
(303, 203, '2025-01-03', 'Pending'),
(304, 204, '2025-01-04', 'Paid'),
(305, 205, '2025-01-05', 'Pending');
--  Find total number of customers
select count(*) from customers;

-- Calculate total revenue
select sum(total_amount)from orders;

--  Find average order amount
select avg(total_amount)from orders;

--  Find maximum order value
select max(total_amount)from orders;

--  Find minimum item price
select min(price) from menu_items;

-- Count orders per customer
select cust_id,count(order_id) from orders group by cust_id;

-- Total sales per restaurant
select restaurant_id,res_name,(select count(total_amount)from orders where order_id in
(select order_id from orderitems where item_id in
(select item_id from menu_items where menu_items.restaurant_id=restaurants.restaurant_id)))from restaurants;

--   Completed payments count
select count(payment_status)from payments where payment_status='Paid';

-- Customers from Chennai.
select c_name from customers where city='Chennai';

-- Orders above 200
select order_id from orders where total_amount>200;

--  Group orders by restaurant
select res_name from restaurants group by res_name;

-- Total sales per restaurant
select restaurant_id,res_name,(select total_amount from orders where order_id in
(select order_id from orderitems where item_id in
(select item_id from menu_items where menu_items.restaurant_id=restaurants.restaurant_id)))from restaurants;

-- Restaurants with sales above 200
select res_name,restaurant_id from restaurants where (select total_amount from orders where order_id in
(select order_id from orderitems where item_id in
(select item_id from menu_items where menu_items.restaurant_id=restaurants.restaurant_id)))>200;

-- Latest 5 orders
select order_id from orders order by order_date desc limit 5;

-- Menu items priced between 100–300
select* from menu_items where price between 100 and 300;

-- Orders placed today
select*from orders where order_date=current_date();

--  Orders in last 7 days
select order_id from orders where order_date>=date_sub(current_date(),interval 7 day);

--   Extract year from order_date
select order_id,date_format(order_date,'%y') from orders;

--  Extract month from payment_date
select payment_id,date_format(payment_date,"%m") from payments;

-- Orders in specific month
select order_id,month(order_id)=1,year(order_id)=2025 from orders;

-- Display current date and time
select now() as currentdatetime;

-- Customers with orders above average
SELECT cust_id,
       SUM(total_amount) AS total_orders
FROM orders
GROUP BY cust_id
HAVING SUM(total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
);

--  Restaurant with highest sales
select restaurant_id,(select sum(total_amount) from orders where order_id in(select order_id from orderitems where item_id in
(select item_id from menu_items where menu_items.restaurant_id=restaurants.restaurant_id)))as totalsales
 from restaurants order by totalsales desc limit 1;
 
 -- Customers with no orders
 select cust_id,c_name from customers where cust_id not in(select cust_id from orders);
 
 -- Items priced above average
 select*from menu_items where price>(select avg(price) from menu_items);
 
 -- Order with maximum amount
 SELECT *
FROM orders
WHERE total_amount = (
    SELECT MAX(total_amount)
    FROM orders
);

-- Identify customers who ordered from more than one restaurant
select c.cust_id,c.c_name ,count(distinct m.restaurant_id) 
from customers c 
join orders o on c.cust_id=o.cust_id
join orderitems oi on o.order_id=oi.order_id
join menu_items m on oi.item_id=m.item_id 
group by cust_id,c_name having count(distinct m.restaurant_id)>1; 

-- Display customers whose latest order value is higher than their average order value
select c.cust_id,c.c_name from customers c 
join orders o1 on c.cust_id=o1.cust_id
where o1.order_date=(Select max(o2.order_date) from orders o2 where o2.cust_id=c.cust_id) 
AND o1.total_amount > (select avg(o3.total_amount) from orders o3 where o3.cust_id=c.cust_id);

-- Identify peak sales day of the week.
select dayname(order_date),sum(total_amount) as totalsales from orders group by order_date order by totalsales desc limit 1;

-- Find customers whose order frequency is higher than the average frequency
select cust_id,count(order_id)from orders group by cust_id having count(order_id)>(select avg(freq)
 from (select count(order_id)as freq from orders group by cust_id)t);



