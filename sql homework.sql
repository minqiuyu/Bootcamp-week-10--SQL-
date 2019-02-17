-- question 1
-- a
select first_name, last_name
from actor;
-- b
set sql_safe_updates = 0;
alter table actor ADD COLUMN actor_name VARCHAR(50);

update actor SET actor_name = CONCAT(first_name,' ', last_name);

select actor_name from actor;

-- question 2
-- a 
select actor_id, actor_name from actor where actor_name like "Joe%"; 
-- b
select actor_name from actor where last_name like "%Gen%"; 
-- c
select last_name, first_name from actor where last_name like "%i%" and last_name like "%l%"; 
-- d 
SELECT country, country_id FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");
-- question 3
-- a 
alter table actor ADD COLUMN description BLOB;
-- b 
alter table actor DROP COLUMN description; 
-- question 4
-- a
SELECT last_name, COUNT(*) AS CountOf FROM actor GROUP BY last_name HAVING COUNT(*)>=1; 
-- b 
SELECT last_name, COUNT(*) AS CountOf FROM actor GROUP BY last_name HAVING COUNT(*)>1; 
-- c  
select actor_id, first_name, last_name, actor_name from actor where actor_name = "Groucho Williams";  
update actor set first_name = upper("Harpo"), actor_name = upper("Harpo Williams") where actor_id = 172; 
select actor_id, first_name, last_name, actor_name from actor where actor_name = "Harpo Williams"; 
-- d 
update actor set actor_name = upper("Groucho Williams"), first_name = upper("Groucho") where actor_id = 172; 
select actor_id, first_name, last_name, actor_name from actor where actor_id = 172;
-- question 5
show create table address; 
-- question 6
-- a
select first_name, last_name, address.address from staff join address on address.address_id = staff.address_id; 
-- b
-- select sum(amount) from payment where payment_date like "2005-08%"; 
select first_name, last_name, sum(payment.amount) from staff join payment on payment.staff_id = staff.staff_id where payment_date like "2005-08%" group by first_name, last_name;
-- c
-- select film.title, inventory_id from inventory join film on film.film_id = inventory.film_id where film.title like "Hunchback Impossible";
-- select film_id FROM film WHERE title like "Hunchback Impossible";
-- SELECT Count(*) FROM inventory WHERE film_id = "439";
select title, COUNT(inventory_id) from film join inventory ON film.film_id = inventory.film_id WHERE title = "Hunchback Impossible";
-- d 
select last_name, first_name, SUM(amount) from payment JOIN customer ON payment.customer_id = customer.customer_id group by payment.customer_id ORDER BY last_name ASC;
-- question 7
-- a 
select title from film WHERE language_id in
	(select language_id 
	FROM language
	WHERE name = "English" )
and (title LIKE "K%") or (title like "Q%");
-- b 
select last_name, first_name
from actor
where actor_id in
	(select actor_id from film_actor
	where film_id in 
		(select film_id from film
		where title = "Alone Trip"));
-- c
select country, last_name, first_name, email from country left join customer on country.country_id = customer.customer_id where country = 'Canada';
-- d
select title, category from film_list where category = 'Family';
-- e 
select inventory.film_id, film_text.title, COUNT(rental.inventory_id) from inventory
join rental on inventory.inventory_id = rental.inventory_id
join film_text on inventory.film_id = film_text.film_id
group by rental.inventory_id order by count(rental.inventory_id) desc;
-- f
select store.store_id, SUM(amount) from store
join staff on store.store_id = staff.store_id
join payment p on p.staff_id = staff.staff_id
group by store.store_id order by sum(amount);
-- g
select store.store_id, city, country from store
join customer on store.store_id = customer.store_id
join staff on store.store_id = staff.store_id
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id;
-- where country = 'CANADA' and country = 'AUSTRAILA';

-- h
select name, sum(payment.amount) from category c
join film_category join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id join payment group by name limit 5;
-- question 8
-- a 
create view top_five_genres as select name, SUM(payment.amount) from category c
join film_category
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment group by name LIMIT 5;
-- b
select * from top_five_genres;
-- c
drop view top_five_genres;






