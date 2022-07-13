/*Sobre la base de datos SAKILA, escriba una consulta una consulta que identifique el actor mas taquillero en cuanto a pagos de alquileres 
de peliculas en las que actuó y devuelva para ese actor el monto que recaudó, la cantidad de peliculas en las que actuó y 
la cantidad de generos (categorías). Los datos actuales son solo una muestra de un estado posible, 
la consulta deberá funcionar para cualquier estado posible de los datos.*/


select C.first_name, C.last_name, C.monto_recaudado, A.cant_films, B.cant_categ from

(select ac.actor_id, ac.first_name, ac.last_name, count(fi.film_id) as cant_films, fi.title 
	from actor ac, film_actor fia, film fi
    where ac.actor_id = fia.actor_id
    and fi.film_id = fia.film_id
    group by actor_id) as A, -- CANTIDAD DE PELICULAS
    
(select ac.actor_id, ac.first_name, ac.last_name, fi.film_id, fi.title, count(distinct fic.category_id) as cant_categ
	from actor ac, film_actor fia, film fi, film_category fic
    where ac.actor_id = fia.actor_id
    and fi.film_id = fia.film_id
    and fic.film_id = fi.film_id
    group by ac.actor_id) as B, -- CANTIDAD DE CATEGORIAS

(select A.actor_id, A.first_name, A.last_name, sum(A.amount) as monto_recaudado from( 
select ac.actor_id, ac.first_name, ac.last_name, fi.film_id, fi.title, inv.inventory_id, re.rental_id, pa.payment_id, pa.amount
	from actor ac, film_actor fia, film fi, inventory inv, rental re, payment pa
    where ac.actor_id = fia.actor_id
    and fi.film_id = fia.film_id
    and inv.film_id = fi.film_id
    and re.inventory_id = inv.inventory_id
    and pa.rental_id = re.rental_id
    group by payment_id) as A
    group by A.actor_id
    order by monto_recaudado desc) as C -- MONTO RECAUDADO
    
    where A.actor_id = B.actor_id
    and B.actor_id = C.actor_id
    order by C.monto_recaudado desc;