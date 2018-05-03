USE sakila;

SELECT * FROM actor;

#1a
SELECT first_name, last_name
FROM actor;

#1b
SELECT concat(first_name, ' ', last_name) FROM actor;

#2a
SELECT actor_id, first_name, last_name
FROM actor WHERE first_name = "Joe";

#2b
SELECT * FROM actor WHERE last_name LIKE "%GEN%";

#2c
SELECT * FROM actor WHERE last_name LIKE "%Li%"
ORDER BY last_name, first_name ASC;

#2d
SELECT country_id, country
FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor ADD `middle_name` varchar(50) NOT NULL
AFTER first_name;

#3b
ALTER TABLE actor MODIFY last_name Blob;

#3c
ALTER TABLE actor DROP middle_name;

#4a
SELECT last_name, count(*) from actor
GROUP BY last_name;

#4b
SELECT last_name, count(*) from actor
GROUP BY last_name HAVING COUNT(*) > 1;

#4c
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

#5a
CREATE TABLE address_recreation (
	address_id int NOT NULL AUTO_INCREMENT,
    address varchar(255),
    address2 varchar(255),
    district varchar(255),
    city_id integer(10),
    postal_code integer(5),
    phone integer(10),
    location varchar(255),
    PRIMARY KEY (address_id)
);

#6a
SELECT a.first_name, a.last_name, b.address, b.district, b.postal_code
FROM staff a
INNER JOIN address b ON a.address_id = b.address_id;

#6b
SELECT b.staff_id, b.first_name, b.last_name, a.AM as total_amount
FROM staff b 
INNER JOIN (SELECT staff_id, SUM(amount) as AM 
FROM payment a WHERE payment_date >= '2005-08-01 00:00:00' and payment_date < '2005-09-01 00:00:00' GROUP BY staff_id
) a ON a.staff_id = b.staff_id;

#6c
SELECT a.film_id, a.title, COUNT(b.actor_ID) AS Number_of_Actor
FROM film a
INNER JOIN film_actor b ON a.film_id = b.film_id GROUP BY film_id;

#6d
SELECT a.film_id, a.title, COUNT(b.inventory_id) AS Inventory
FROM film a
INNER JOIN inventory b ON a.film_id = b.film_id GROUP BY film_id HAVING a.title = 'Hunchback Impossible';

#6e
SELECT b.customer_id, b.first_name, b.last_name, SUM(a.amount) AS total_paid
FROM payment a
INNER JOIN customer b ON a.customer_id = b.customer_id GROUP BY a.customer_id ORDER BY b.last_name ASC;

#7a
SELECT a.film_id, a.title, b.name
FROM film a
INNER JOIN language b ON a.language_id = b.language_id WHERE a.title LIKE "K%" OR a.title LIKE "Q%";

#7b
SELECT first_name, last_name
FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film WHERE title = 'Alone Trip'));

#7c
SELECT a.customer_id, b.name, a.email, b.country
FROM customer a 
INNER JOIN customer_list b ON concat(a.first_name, ' ', a.last_name) = b.name WHERE b.country = 'Canada';

#7d
SELECT a.film_id, a.title
FROM film a
INNER JOIN film_category b ON a.film_id = b.film_id
WHERE b.category_id IN (SELECT c.category_id FROM category c WHERE c.name = 'Family');

#7e
SELECT film_id, title, rental_duration
FROM film ORDER BY rental_duration DESC;

#7f
SELECT store, total_sales
FROM sales_by_store;

#7g
SELECT a.store, b.ID, b.city, b.country
FROM sales_by_store a
INNER JOIN staff_list b ON a.manager = b.name;

#7h
SELECT e.name, sum(a.amount) AS gross_revenue
FROM payment a
INNER JOIN rental b ON a.customer_id = b.customer_id
INNER JOIN inventory c ON b.inventory_id = c.inventory_id
INNER JOIN film_category d ON c.film_id = d.film_id
INNER JOIN category e ON d.category_id = e.category_id GROUP BY d.category_id ORDER BY gross_revenue DESC LIMIT 5;

#8a
CREATE VIEW top_5_grossing_film_category AS
SELECT e.name, sum(a.amount) AS gross_revenue
FROM payment a
INNER JOIN rental b ON a.customer_id = b.customer_id
INNER JOIN inventory c ON b.inventory_id = c.inventory_id
INNER JOIN film_category d ON c.film_id = d.film_id
INNER JOIN category e ON d.category_id = e.category_id GROUP BY d.category_id ORDER BY gross_revenue DESC LIMIT 5;

#8b
SELECT * FROM top_5_grossing_film_category;

#8c
DROP VIEW top_5_grossing_film_category;