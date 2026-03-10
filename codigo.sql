USE Sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT(title) AS lista_películas 
	FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT title
	FROM film
    WHERE rating = "PG-13";

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción -- MIRAR PORQUE NO VA BIEN 
SELECT title, description
	FROM film
    WHERE title LIKE "%amazing%";

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT title
	FROM film
    WHERE length > 120;
    
-- 5. Recupera los nombres de todos los actores.
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo_actores
	FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo_actores
	FROM actor
    WHERE last_name = "Gibson";

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT first_name, actor_id -- consulta de comprobación
	FROM actor 
    WHERE actor_id BETWEEN 10 AND 20;
    
SELECT first_name
	FROM actor 
    WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT title, rating -- consulta de comprobación
	FROM film 
    WHERE rating NOT IN ("R", "PG-13");
    
SELECT title
	FROM film 
    WHERE rating NOT IN ("R", "PG-13");
    
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT COUNT(film_id) AS cantidad_peliculas, rating AS clasificación
	FROM film
    GROUP BY rating;

-- 10.  Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT COUNT(r.rental_id) AS películas_alquiladas, c.customer_id AS número_cliente, c.first_name AS nombre, c.last_name AS apellido
	FROM customer AS c
    INNER JOIN rental AS r
		ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
-- 11.  Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name AS categoría_pelicula, COUNT(r.rental_id) AS recuento_peliculas_alquiladas
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
    INNER JOIN film AS f
		ON fc.film_id = f.film_id
    INNER JOIN inventory AS i
		ON f.film_id = i.film_id
    INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	GROUP BY c.name;
    
-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT AVG(length) AS promedio_duración, rating AS clasificación
	FROM film
    GROUP BY rating;
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT a.first_name, a.last_name, f.title -- prueba left join 
	FROM actor AS a 
    LEFT JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    LEFT JOIN film AS f
		ON fa.film_id = f.film_id;

SELECT a.first_name, a.last_name, f.title -- prueba inner join = resultado 
	FROM actor AS a 
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id;

SELECT a.first_name, a.last_name, f.title -- query de comprobación 
	FROM actor AS a 
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id 
	WHERE title = 'Indian Love';

SELECT a.first_name, a.last_name
	FROM actor AS a 
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id 
	WHERE title = 'Indian Love';

-- 14.  Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT title, description -- query de comprobación 
	FROM film
	WHERE description LIKE '%dog%' 
	   OR description LIKE '%cat%';

SELECT title 
	FROM film
	WHERE description LIKE '%dog%' 
	   OR description LIKE '%cat%';
       
-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor. -- REPASAR 
SELECT a.actor_id
	FROM actor AS a
    LEFT JOIN film_actor AS fa -- uso left join porque necesito que una todos los datos de las tablas 
		ON a.actor_id = fa.actor_id
	WHERE fa.film_id IS NULL; -- la query no da resultados por lo que no hay ningún actor o actriz que no aparezca en ninguna película en film_actor 

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. -- REPASAR AÑOS 
SELECT title, release_year -- query de comprobación 
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;

SELECT title AS título_película
	FROM film 
    WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT f.title, c.name -- query de comprobación 
	FROM film AS f
    LEFT JOIN film_category AS fa 
		ON f.film_id = fa.film_id
	LEFT JOIN category AS c
		ON fa.category_id = c.category_id
	WHERE c.name = "Family";
    
SELECT f.title -- query final 
	FROM film AS f
    LEFT JOIN film_category AS fa 
		ON f.film_id = fa.film_id
	LEFT JOIN category AS c
		ON fa.category_id = c.category_id
	WHERE c.name = "Family";

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT a.first_name, a.last_name, COUNT(f.film_id) -- query de comprobación 
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
    GROUP BY a.first_name, a.last_name 
    HAVING COUNT(f.film_id) > 10;

SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo_actores -- query final 
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
    GROUP BY a.first_name, a.last_name 
    HAVING COUNT(f.film_id) > 10;

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
SELECT title, rating, length -- query comprobación 
	FROM film 
    WHERE rating = 'R' AND length > 120;

SELECT title -- query final 
	FROM film 
    WHERE rating = 'R' AND length > 120;

-- 20.  Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT c.name, AVG(f.length)
	FROM category AS c
    LEFT JOIN film_category AS fa
		ON c.category_id = fa.category_id
	LEFT JOIN film AS f
		ON fa.film_id = f.film_id
	GROUP BY c.name
    HAVING AVG(f.length) > 120;

-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre_completo_actores, COUNT(f.film_id)
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id 
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	GROUP BY a.first_name, a.last_name
    HAVING COUNT(f.film_id) > 5;


/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. */
SELECT i.film_id -- SUBCONSULTA 
    FROM rental AS r
    INNER JOIN inventory AS i 
		ON r.inventory_id = i.inventory_id
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5;

SELECT i.film_id, r.return_date, r.rental_date, DATEDIFF(r.return_date, r.rental_date)  -- consulta comprobación
    FROM rental AS r
    INNER JOIN inventory AS i 
		ON r.inventory_id = i.inventory_id;
        
SELECT title -- query final 
	FROM film 
    WHERE film_id IN (
		SELECT i.film_id 
			FROM rental AS r
			INNER JOIN inventory AS i 
				ON r.inventory_id = i.inventory_id
			WHERE DATEDIFF(r.return_date, r.rental_date) > 5);
            
/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
		"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
		categoría "Horror" y luego exclúyelos de la lista de actores */
SELECT DISTINCT(a.actor_id), c.name -- query de comprobación, subconsulta 
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id 
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = 'Horror';
    
SELECT DISTINCT(a.actor_id) -- subconsulta 
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id 
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = 'Horror';

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actores_no_pelis_horror -- query final 
	FROM actor AS a
	WHERE actor_id NOT IN ( 
		SELECT DISTINCT(a.actor_id) -- subconsulta 
			FROM actor AS a
			INNER JOIN film_actor AS fa
				ON a.actor_id = fa.actor_id
			INNER JOIN film AS f
				ON fa.film_id = f.film_id
			INNER JOIN film_category AS fc
				ON f.film_id = fc.film_id 
			INNER JOIN category AS c
				ON fc.category_id = c.category_id
			WHERE c.name = 'Horror');

-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
SELECT f.title, f.length, c.name -- query comprobación I
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id 
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = 'Comedy';

SELECT f.title, f.length, c.name -- query comprobación II
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id 
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE f.length > 180 AND c.name = 'Comedy';
    
SELECT f.title -- query final 
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id 
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE f.length > 180 AND c.name = 'Comedy';
    











