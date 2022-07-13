/*Recupere de la base de datos un listado de todos las películas que tienen mas copias en el inventario que el promedio de las películas.
De cada película en el listado deberá indicar: 
- NOMBRE DE LA PELÍCULA
- CANTIDAD DE ACTORES QUE ACTÚAN
- CANTIDAD TOTAL DE ALQUILERES QUE SE REALIZARON DE ESA PELÍCULA
- CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESA pelicula */
select b.title,cantactor,alq,alqnodev from
      (select a.film_id,title from
            (select film_id from inventory
				group by film_id
				having
				count(*) > (select avg(cantcopias) from
				(select count(*) cantcopias,film_id from inventory
				group by film_id) d)) a 
				join film fi
				on fi.film_id = a.film_id) b
left join 
(select count(*) cantactor,film_id from film_actor
group by film_id) c
on b.film_id = c.film_id
left join 
(select count(*) alq,film_id from rental ren join inventory inv
on ren.inventory_id = inv.inventory_id
group by film_id) d
on b.film_id = d.film_id
left join
(select count(*) alqnodev,film_id from rental ren join inventory inv
on ren.inventory_id = inv.inventory_id
where isnull(return_date)
group by film_id) e
on b.film_id = e.film_id
