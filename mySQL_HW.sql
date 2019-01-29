USE sakila;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM actor;

-- 1a
SELECT first_name, last_name
FROM actor;

-- 1b
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS `Actor Name`
FROM actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c
SELECT *
FROM actor
WHERE last_name LIKE '%LI%' 
ORDER BY last_name, first_name;

-- 2d
SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a
ALTER TABLE actor 
ADD COLUMN description BLOB;

SELECT * FROM actor;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

SELECT * FROM actor;

-- 4a
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4c
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

-- 4d
UPDATE actor
SET first_name = "GROUCHO"
WHERE first_name = "HARPO";

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address
ON staff.address_id = address.address_id;

-- 6b
SELECT staff.staff_id, SUM(august_payment.amount)
FROM staff
JOIN (SELECT * FROM payment WHERE payment_date LIKE "2005-08%") AS august_payment
ON staff.staff_id = august_payment.staff_id
GROUP BY staff.staff_id;

-- 6c
SELECT film.title, COUNT(film_actor.actor_id)
FROM film
JOIN film_actor
ON film.film_id = film_actor.film_id
GROUP BY film_actor.film_id;

-- 6d
SELECT COUNT(film_id)
FROM inventory
WHERE film_id
IN
  (SELECT film_id
   FROM film
   WHERE title = 'Hunchback Impossible'
  );


-- 6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

-- 7a
SELECT title
FROM film
WHERE title LIKE "K%" OR title LIKE "Q%"
AND language_id
IN
  (SELECT language_id
   FROM language
   WHERE name = "English"
  );
   
-- 7b
SELECT first_name, last_name
FROM actor
WHERE actor_id
IN (SELECT actor_id
	FROM film_actor
	WHERE film_id = (SELECT film_id
					 FROM film
					 WHERE title = "Alone Trip"));
                     
-- 7c
SELECT first_name, last_name, email
FROM customer
WHERE address_id
IN
  (
   SELECT address_id
   FROM address
   WHERE city_id
   IN
     (SELECT city_id
      FROM city
      WHERE country_id = (SELECT country_id
					      FROM country
                          WHERE country = "Canada")));
                          
-- 7d
SELECT *
FROM film
WHERE film_id
IN
  (
   SELECT film_id
   FROM film_category
   WHERE category_id = (SELECT category_id 
					    FROM category
					    WHERE name = "Family"));
                        
-- 7e
SELECT title, COUNT(title)
FROM rental
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON film.film_id = inventory.film_id
GROUP BY title
ORDER BY COUNT(title) DESC;

-- 7f
SELECT staff_id AS "Store", SUM(amount)
FROM payment
GROUP BY staff_id;

-- 7g
SELECT store_id, address, city
FROM store
JOIN address
ON store.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id;
