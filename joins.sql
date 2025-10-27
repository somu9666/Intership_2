use product;
create table customers(customer_id int not null,customer_name varchar(30),city varchar(25));
insert into customers
values
(1, 'Rahul', 'Hyderabad'),
(2, 'Priya', 'Bangalore'),
(3, 'Amit', 'Chennai'),
(4, 'Sneha', 'Delhi'),
(5, 'John', 'Mumbai'),
(6, 'Anjali', 'Pune'),
(7, 'Rohit', 'Kolkata'),
(8, 'Divya', 'Jaipur'),
(9, 'Karan', 'Lucknow'),
(10, 'Neha', 'Nagpur'),
(11, 'Suresh', 'Coimbatore'),
(12, 'Meena', 'Bhopal'),
(13, 'Arjun', 'Patna'),
(14, 'Sanjay', 'Ahmedabad'),
(15, 'Pooja', 'Indore'),
(16, 'Deepak', 'Kochi'),
(17, 'Ritika', 'Visakhapatnam'),
(18, 'Vikas', 'Surat'),
(19, 'Ankita', 'Thane'),
(20, 'Nikhil', 'Rajkot'),
(21, 'Harsha', 'Vijayawada'),
(22, 'Manoj', 'Nashik'),
(23, 'Tanya', 'Varanasi'),
(24, 'Vinay', 'Amritsar'),
(25, 'Swati', 'Aurangabad'),
(26, 'Gaurav', 'Mangalore'),
(27, 'Kavita', 'Mysore'),
(28, 'Yash', 'Trichy'),
(29, 'Bhavna', 'Guwahati'),
(30, 'Tarun', 'Madurai');
select * from customers;

create table products(order_id int, customer_id int,product_name varchar(20),amount int);
insert into products
values
(201, 1, 'Laptop', 55000),
(202, 2, 'Mouse', 800),
(203, 3, 'Keyboard', 1500),
(204, 4, 'Monitor', 12000),
(205, 5, 'Headphones', 3000),
(206, 6, 'Tablet', 25000),
(207, 7, 'Printer', 7000),
(208, 8, 'Webcam', 2200),
(209, 9, 'Router', 1800),
(210, 10, 'Speaker', 4000),
(211, 11, 'Scanner', 6500),
(212, 12, 'Camera', 33000),
(213, 13, 'Power Bank', 1200),
(214, 14, 'Microphone', 2100),
(215, 15, 'Smartwatch', 9000),
(216, 16, 'Hard Drive', 4500),
(217, 17, 'Pen Drive', 700),
(218, 18, 'Graphics Card', 25000),
(219, 19, 'Cooling Pad', 1000),
(220, 20, 'Charger', 1200),
(221, 21, 'SSD', 8500),
(222, 31, 'Bluetooth Speaker', 3500), -- customer_id not in customers
(223, 32, 'VR Headset', 18000),       -- customer_id not in customers
(224, 5, 'Gaming Mouse', 2500),
(225, 2, 'Keyboard', 1600),
(226, 8, 'USB Hub', 900);
select *from products
SELECT 
    customers.customer_id,
    customers.customer_name,
    products.product_name,
    products.amount
    from customers
    inner join
    products
    on 
    customers.customer_id = products.customer_id;
select 
    customers.customer_id,
    customers.customer_name,
    products.order_id,
    products.product_name,
    products.amount
    from customers
    left join
    products
    on
    customers.customer_id = products.customer_id;
select 
    customers.customer_id,
    customers.customer_name,
    products.order_id,
    products.product_name,
    products.amount
    from customers
    right join
    products on
    customers.customer_id = products.customer_id;
select 
    customers.customer_id,
    customers.customer_name,
    products.order_id,
    products.product_name,
    products.amount
    from customers
    full outer join
    products
    on 
    customers.customer_id = products.customer_id;

SELECT 
    c1.customer_name AS customer_1,
    c2.customer_name AS customer_2,
    c1.city
FROM 
    customers c1
JOIN 
    customers c2 
ON 
    c1.city = c2.city AND c1.customer_id = c2.customer_id;

SELECT 
    product_name,  
    SUM(amount) AS total_amount
FROM 
    products
GROUP BY 
    product_name, amount;
select 
    customers.customer_id,
    customers.customer_name,
    sum(products.amount) As total_amount
from
    customers
    inner join
    products
    on customers.customer_id = products.customer_id
    group by customers.customer_id,customers.customer_name;
SELECT 
    customers.customer_id,
    customers.customer_name,
    avg(products.amount) AS total_amount
FROM 
    customers
INNER JOIN 
    products ON customers.customer_id = products.customer_id
GROUP BY 
    customers.customer_id, customers.customer_name
    having  avg(products.amount)>3000;

select
    c.customer_id,
    c.customer_name,
    p.amount
    from customers c
    join
    products p
    on
    c.customer_id = p.customer_id
    where p.amount between 4000 and 10000 order by p.amount ASC;

select 
     c.customer_id,
     c.customer_name,
     p.amount
     from customers c
     inner join
     products p
     on 
     c.customer_id = p.customer_id
     where p.amount >= 5000;

-- Find customers from Hyderabad and show their total spending, ordered by amount
SELECT 
    c.customer_name,
    SUM(p.amount) AS TotalSpent
FROM customers c
JOIN products p ON c.customer_id = p.customer_id
WHERE c.city = 'Hyderabad'
GROUP BY c.customer_name
ORDER BY TotalSpent DESC;


-- Find customers who spent more than the average spending of all customers
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM products
    GROUP BY customer_id
    HAVING SUM(amount) > (
        SELECT AVG(amount) FROM products
    )
);

SELECT 
    c.customer_name,
    SUM(p.amount) AS TotalSpent,
    AVG(p.amount) AS AverageSpent
FROM customers c
JOIN products p ON c.customer_id = p.customer_id
GROUP BY c.customer_name;

CREATE VIEW Customer_Spending AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    SUM(p.amount) AS TotalSpent,
    AVG(p.amount) AS AvgSpent
FROM customers c
JOIN products p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.customer_name, c.city;

select* from Customer_Spending;
SELECT * FROM Customer_Spending WHERE TotalSpent > 10000;
-- Create indexes on frequently used columns
CREATE INDEX idx_city ON customers(city);
CREATE INDEX idx_customer_id ON products(customer_id);
