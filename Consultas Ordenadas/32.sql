#Nombre Pelicula,	Monto recaudado,	Cantidad de Alquileres Totales,	Cantidad de Actores,	Sucursal donde mas recaudo
#Tener en cuenta que deben figurar todas las películas en existencia aún aquellas que no tuvieran alquileres ni pagos, 
#pero NO deben figurar aquellas que no tengan copias en ninguna sucursal.
#Los datos actuales son un ejemplo de un estado posible de la información, 
#la consulta debe funcionar correctamente para cualquier consulta.
use sakila;

select title nombre_pelicula, sum(amount) monto_recaudado, count(r.rental_id) cantidad_alquileres, 
count(distinct actor_id) cantidad_actores, s.store_id tienda

#saco las peliculas que estan en inventorio
from film f
join inventory i on f.film_id = i.film_id

#busco aquellas peliculas rentadas, con loj, ya que puede haber no rentadas
left outer join rental r
on i.inventory_id = r.inventory_id

#busco los pagos, puede haber rentas que no tengan pagos
left outer join payment p
on r.rental_id = p.rental_id

#busco los actores, puede haber peliculas sin actores, y actores que no esten en peliculas, por ello hago foj
join film_actor fa
on f.film_id = fa.film_id

join store s
on i.store_id=s.store_id

group by f.film_id;


