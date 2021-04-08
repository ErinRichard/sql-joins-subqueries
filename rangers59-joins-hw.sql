-- ANSWER TO QUESTION 1 (List all customers who live in Texas using JOINs)
-- Returns 5 customers:  last_names: Davis, Cruz, Mccrary, Hardison, Still
SELECT customer.address_id, first_name, last_name, email, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';



-- ANSWER TO QUESTION 2 (Get all payments above $6.99 with Customer's Full Name)
-- Returns 1406 rows/results
SELECT customer.customer_id, first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > '6.99'
ORDER BY amount ASC;



-- ANSWER TO QUESTION 3 (Show all customer names who have made payments over $175 using subqueries)
-- Returns 6 customer names (last_names: Kennedy, Shaw, Hunt, Snyder, Collazo, Seal)
SELECT *
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);



-- ANSWER TO QUESTION 4 (List all customers who live in Nepal using the City table)
-- Returns 1 customer name (Kevin Schuler)
SELECT customer.first_name, customer.last_name, customer.email, city.city_id, country.country_id
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
FULL JOIN city
ON address.city_id = city.city_id
FULL JOIN country
ON city.country_id = country.country_id
WHERE city.city_id = '81';



-- ANSWER TO QUESTION 5 (Which staff member had the most transactions?)
-- Mike Hillyer had more transactions (8040) than Jon Stephen (8004)
SELECT staff.staff_id, first_name, last_name, email, COUNT(rental.staff_id) AS NUM_TRANSACTIONS
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id;



-- ANSWER TO QUESTION 6 (How many movies of each rating are there?)
-- Results:  G: 791, PG: 924, PG-13: 1018, R: 904, NC-17: 944
WITH base AS (
SELECT inventory_id, inventory.film_id, rating
FROM inventory
LEFT JOIN film
ON inventory.film_id = film.film_id)

SELECT COUNT(rating), rating
FROM base
GROUP BY rating
ORDER BY rating ASC



-- ANSWERT TO QUESTION 7 (Show all customers who have made a single payment above $6.99 using subqueries)
-- Returns 539 results/rows
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id, amount
	HAVING amount > 6.99
);



-- ANSWER TO QUESTION 8 (How many free rentals did our stores give away?)
-- Results in 24 rows (24 free rentals)
SELECT *
FROM payment
WHERE rental_id IN (
	SELECT rental_id
	FROM rental
	WHERE amount = 0.00
);




-------ER NOTES BELOW-------


-- ER note for Q1: use INNER JOIN to select records that have matching values in both the customer table and address table
-- ER note for Q2: use INNER JOIN to select records that have matching values in both the customer table and payment table
-- ER Note for Qr: need full join because if using LEFT/RIGHT/INNER, could exclude someone who is missing an identifying piece of data.

-- Additional Q4 Notes
-- Nepal country_id = 66
-- Nepal city_id = 81
-- SELECT *
-- FROM city
-- WHERE country_id = '66';

-- SELECT *
-- FROM customer;

-- ER NOTES for Q6
-- SELECT COUNT(inventory.film_id) AS film_id_count, inventory.film_id, COUNT(rating) AS rating_count, rating
-- FROM inventory
-- LEFT JOIN film
-- ON inventory.film_id = film.film_id
-- GROUP BY rating, inventory.film_id, inventory_id;

-- SELECT *
-- FROM film
-- ORDER BY film_id ASC;

-- Works but deduped and no JOIN or Subquery yet
-- SELECT rating, COUNT(rating) AS rating_count
-- FROM film
-- GROUP BY rating
-- ORDER BY rating_count DESC;





-- Checking work - result is 24 for Q8
-- SELECT *
-- FROM payment
-- WHERE amount = 0.00;

-- SELECT *
-- FROM customer;

-- SELECT *
-- FROM address;

-- SELECT*
-- FROM city;
