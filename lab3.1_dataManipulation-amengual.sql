--

-- Lab 3.1

USE sakila;


--

-- 1. Drop column picture from staff.


select * from staff;

alter table staff
drop column picture;



--

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.

select * from staff;
select * from customer;

select * from customer
where last_name = 'SANDERS';

-- delete from staff where username = 'TAMMY';

-- customer_id: 75, address_id: 79 

-- answer
insert into staff (first_name, last_name, address_id, email, store_id, username)
select first_name, last_name, address_id, concat(first_name,'.',last_name,'@sakilastaff.com'), store_id, first_name
from customer
where customer_id = 75;



-- trying to deal with strings -- done!

-- select customer_id, concat(left(first_name,1),lower(first_name)) from customer;

insert into staff (first_name, last_name, address_id, email, store_id, username)
select concat(left(c.first_name,1),lower(right(c.first_name,char_length(c.first_name)-1))) as first_name
, concat(left(c.last_name,1),lower(right(c.last_name,char_length(c.last_name)-1))) as last_name
, c.address_id
, concat(concat(left(c.first_name,1),lower(right(c.first_name,char_length(c.first_name)-1))), '.'
	, concat(left(c.last_name,1),lower(right(c.last_name,char_length(c.last_name)-1))), '@sakilastaff.com')
, c.store_id
, concat(left(c.first_name,1),lower(right(c.first_name,char_length(c.first_name)-1)))
from customer as c
where customer_id = 75;





--

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
-- You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. 
-- You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:


select * from rental where rental_date > curdate(); 
-- cast(curdate() as datetime); -- where isnull(return_date); -- isnull;

-- select * from rental order by rental_date desc; -- rental_id: 16051, 16050;

-- -- answer -- --
insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (curdate()
	, 1
    , (select customer_id from sakila.customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER')
    , (select staff_id from staff where username = 'Mike'))
;

-- info queries
select film_id from film where title = 'ACADEMY DINOSAUR';

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select staff_id from staff where username = 'Mike';

select *, inventory_id from inventory
where store_id = 1 and film_id = (
	select film_id from film where title = 'ACADEMY DINOSAUR')
;


-- personal tests
select * from inventory order by inventory_id;
select curdate();
select cast(curdate() as datetime);









