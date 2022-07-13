#Recupere de la base de datos un listado de todos las películas que han
#recaudado por sus alquileres mas que el promedio de las películas. 
#Para el calculo del promedio tener en cuenta las
#películas que no tienen recaudacion.

#De cada película en el listado deberá indicar:

#- NOMBRE DE LA PELÍCULA
#- CANTIDAD DE ACTORES QUE ACTÚAN
#- CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESA PELÍCULA
#- PROMEDIO DE RECUDACION DE TODAS LAS PELICULAS (esta columna tendrá el mismo valor en todas las filas)

SELECT 
    t1.title Titulo,
    ifnull(actores,0) 'Cantidad de Actores',
    ifnull(cant_sin_dev,0) 'Cantidad sin devolver',
  (select  AVG(t2.recaudacion) reca FROM film f join
    (SELECT  f.film_id fid, IFNULL(SUM(lala.am), 0) recaudacion FROM film f
	LEFT JOIN
		(select inv.film_id fid, pa.amount am from inventory inv
		JOIN rental re on re.inventory_id=inv.inventory_id
		JOIN payment pa on pa.rental_id=re.rental_id
        ) lala on lala.fid=f.film_id
		 GROUP BY f.film_id) t2 on t2.fid=f.film_id) as promedio
         
FROM (SELECT ft.film_id fid, ft.title, actores, cant_sin_dev FROM  film_text ft
    left JOIN (SELECT fa.film_id, COUNT(*) actores FROM  film_actor fa
    GROUP BY fa.film_id) cant_act on cant_act.film_id=ft.film_id
    left JOIN(SELECT inv.film_id, COUNT(ISNULL(re.return_date)) cant_sin_dev FROM inventory inv
    RIGHT JOIN rental re on re.inventory_id=inv.inventory_id
    GROUP BY inv.film_id) sin_devolver on sin_devolver.film_id=ft.film_id) t1
 
        
