#Recupere de la base de datos un listado de todas las categorías que han recaudado por los alquileres de las películas calificadas en esa
#las categorías. Para el calculo del promedio tener en cuenta las categorí
#De cada categoría en el listado deberá indicar
#- NOMBRE DE LA CATEGORÍA.
#- CANTIDAD DE PELÍCULAS EN ESA CATEGORÍA.
#- CANTIDAD DE ALQUILERES DE PELÍCULAS DE ESA CATEGORÍA.
#- PROMEDIO DE RECUDACION DE TODAS LAS CATEGORÍAS (esta columnatendrá el mismo valor en todas las filas)
#El estado de los datos de ejemplo es uno de los posibles estados, la consulta debe funcionar correctamente cualquiera sean los datos.

select Nombre,pelis_por_cat "Cantidad de Peliculas",alquileres_cat "Alquileres por Cat", prom Promedio from
( 
select category_id,name Nombre from category
) Nombre
left join 
(
	select category_id, count(*) pelis_por_cat from film_category
    group by category_id
)Pelis_por_cat using(category_id)
left join
(
	select category_id, sum(alquileres_peli) alquileres_cat from film_category
    left join 
    (
		select film_id, count(rental_id) alquileres_peli from inventory
		join rental using(inventory_id) 
		group by film_id
    ) alqu_pelis using(film_id)
    group by category_id
) Alquileres using(category_id)
cross join
(
	select avg(recaudado_cat) prom from
	(
		select category_id, sum(recaudado_peli) recaudado_cat from film_category
		left join 
		(
			select film_id, sum(amount) recaudado_peli from inventory
			join rental using(inventory_id)
            join payment using(rental_id)
			group by film_id
		) recau_pelis using(film_id)
		group by category_id
	) recau_cat
) Promedio
where category_id in
(
	select category_id from film_category
		left join 
		(
			select film_id, sum(amount) recaudado_peli from inventory
			join rental using(inventory_id)
            join payment using(rental_id)
			group by film_id
		) recau_pelis using(film_id)
		group by category_id
        having(sum(recaudado_peli)>prom )
)