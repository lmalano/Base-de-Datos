
#Recupere de la base de datos un listado de todos los actores que han recaudado por sus películas mas que el promedio de los actores.
#Para el coiculo del promedio tener en cuenta los actores
#que no tienen recaudación.
#Descada sotor en el istado deberá indicar
#- NOMBRE y APELLIDO:
#- CANTIDAD DE PELÍCULAS QUE ACTUÓ.
#- CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESE ACTOR
#- PROMEDIO DE RECUDACION DE TODOS LOS ACTORES (esta columos tendrá st mismo valor en todas las filas)

#El estado de los datos de eyemplo es uno de los posibles estados, la consulta debe funcionar correctamente cualquiera sean loz datos.


select Nombre, Apellido, Cantidad_pelis, sin_devolver,
 (select avg(t11.suma_pelis) from(
  SELECT fa.actor_id, SUM(pa.amount) suma_pelis  FROM inventory inv
	JOIN rental re on re.inventory_id=inv.inventory_id
	join payment pa on pa.rental_id=re.rental_id
    join film_actor fa on fa.film_id=inv.film_id
	GROUP BY fa.actor_id) t11 ) as promedio_por_actor
    from
(SELECT ac.actor_id, ac.first_name Nombre, ac.last_name Apellido, count(*) Cantidad_Pelis ,fa.film_id FROM actor ac
left join film_actor fa on fa.actor_id=ac.actor_id
group by fa.actor_id) t1
join(
SELECT fa.actor_id, fa.film_id, ifnull(SUM(pelis),0) sin_devolver  FROM  film_actor fa
    LEFT JOIN (SELECT  inv.film_id, COUNT(*) pelis  FROM  inventory inv
    JOIN rental re on re.inventory_id=inv.inventory_id
    WHERE  (ISNULL(return_date)) GROUP BY inv.film_id) sin_devolver on sin_devolver.film_id=fa.film_id
    GROUP BY fa.actor_id) t2 on t2.film_id=t1.film_id
    group by t1.actor_id

  
  
  
  