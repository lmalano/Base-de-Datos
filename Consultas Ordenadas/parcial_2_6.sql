#Implemente una consulta sobre la base de datos “Sakila” que liste  los actores, 
#el monto de alquileres cobrados de sus films y el nombre de la pelicula que 
#mas recaudó dentro de las que trabajó ese actor , muéstrelos ordenados por monto de alquileres de mayor a menor.
#El listado tendrá las siguientes columnas:
#1- Nombre del actor
#2- Apellido del actor
#3- Monto cobrado por alquileres de sus films
#4- Nombre de la película mas taquillera entre las que actúa


SELECT 
    CONCAT(Nombre, ' ', Apellido) Nombre,
    recaudado 'Recudacion',
    peli_max 'Pelicula Mas Taquillera',
    actor_id
FROM
    (SELECT 
        actor_id, first_name Nombre, last_name Apellido
    FROM
        actor) Nombre
        LEFT JOIN
    (SELECT 
        actor_id, SUM(monto) recaudado
    FROM
        film_actor
    LEFT JOIN (SELECT 
        film_id, SUM(amount) monto
    FROM
        film
    RIGHT JOIN inventory USING (film_id)
    RIGHT JOIN rental USING (inventory_id)
    RIGHT JOIN payment USING (rental_id)
    GROUP BY film_id) recaudado_peli USING (film_id)
    GROUP BY actor_id) recaudado_actor USING (actor_id)
        LEFT JOIN
    (SELECT 
        actor_id, title peli_max
    FROM
        (SELECT 
        actor_id, film_id, SUM(max_rec)
    FROM
        film_actor
    LEFT JOIN (SELECT 
        film_id, SUM(amount) max_rec
    FROM
        film
    RIGHT JOIN inventory USING (film_id)
    RIGHT JOIN rental USING (inventory_id)
    RIGHT JOIN payment USING (rental_id)
    GROUP BY film_id) recaudado_peli USING (film_id)
    JOIN (SELECT 
        actor_id, MAX(monto_act) max_rec
    FROM
        (SELECT 
        actor_id, film_id, monto monto_act
    FROM
        film_actor
    LEFT JOIN (SELECT 
        film_id, SUM(amount) monto
    FROM
        film
    RIGHT JOIN inventory USING (film_id)
    RIGHT JOIN rental USING (inventory_id)
    RIGHT JOIN payment USING (rental_id)
    GROUP BY film_id) recaudado_peli USING (film_id)
    GROUP BY actor_id , film_id , monto) lala
    GROUP BY actor_id) max_rec USING (actor_id , max_rec)
    GROUP BY actor_id , film_id) quer
    JOIN film_text USING (film_id)) max_recaudado USING (actor_id)