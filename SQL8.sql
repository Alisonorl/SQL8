# Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
# Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
# How many films are there for each of the categories in the category table. Use appropriate join to write this query
# Which actor has appeared in the most films?
# Most active customer (the customer that has rented the most number of films)
# Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

use sakila;

select title, length,
rank () over(order by length desc) as ranking
from film
where length > 0 or  length is not null
order by ranking;

select rating, title, length,
rank () over(partition by rating order by length desc) as ranking
from film
where length > 0 or  length is not null
group by rating, title, length
order by rating,ranking;

select c.category_id, c.name, count(f.film_id) from category c
left join film_category fc using (category_id)
left join film f using (film_id)
group by c.category_id , c.name;


select a.first_name, a.last_name, count(film_id) from film f
left join film_actor fa using(film_id)
left join actor a using (actor_id)
group by a.actor_id
order by count(f.film_id) desc;

select c.email, count(r.rental_date) from customer c
left join rental r using(customer_id)
group by c.email
order by count(r.rental_date) desc;

