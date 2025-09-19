show databases;
use sakila;

select * from payment;

select a.title, a.film_id,
count(c.rental_id) as times_rented,
sum(d.amount) as total_amount
from film a
left join inventory b on b.film_id = a.film_id
left join rental c on c.inventory_id = b.inventory_id
left join payment d on d.rental_id = c.rental_id
group by a.title, a.film_id
order by times_rented desc
limit 10;


select b.film_id, c.rating, c.title, d.name,
count(a.rental_id) as times_rented,
substring_index(
group_concat(
concat(f.first_name, ' ', f.last_name) ORDER BY f.last_name separator ', '),', ', 1)
as actors
from rental a
left join inventory b on b.inventory_id = a.inventory_id
left join film c on c.film_id = b.film_id
left join language d on d.language_id = c.language_id
JOIN film_actor e ON e.film_id = c.film_id
JOIN actor f ON f.actor_id = e.actor_id
group by b.film_id, c.rating, c.title, d.name
order by times_rented desc
limit 10;

select a.title, f.city, g.country,
sum(a.rental_duration) as days_rented
from film a 
left join inventory b on b.film_id = a.film_id
left join rental c on c.inventory_id  = b.inventory_id
left join customer d on d.customer_id = c.customer_id
left join address e on e.address_id = d.address_id
left join city f on f.city_id = e.city_id
left join country g on g.country_id = f.country_id
group by a.title, f.city, g.country
order by days_rented desc limit 10;

select a.first_name, a.last_name, c.store_id,
count(a.staff_id) as total_staff,
COUNT(b.rental_id) AS times_rented
from staff a
left join rental b on b.staff_id = a.staff_id
left join store c on c.store_id = a.store_id
group by a.first_name, a.last_name, c.store_id
order by times_rented;
