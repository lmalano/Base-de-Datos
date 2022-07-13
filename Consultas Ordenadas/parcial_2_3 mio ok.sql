#Recupere de la base de datos un listado de todas las categorías que tienen mas copias en el inventario que el promedio de las categorías.
#Para el calculo del promedio tener en cuenta las.
#categorias que no tienen copias.

#De cada categoría en el listado deberá indicar:

#- NOMBRE DE LA CATEGORÍA
#- CANTIDAD DE PELÍCULAS EN ESA CATEGORÍA.
#- CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESA CATEGORÍA
#- PROMEDIO DECOPIAS DE TODAS LAS CATEGORÍAS (esta columna tendrá el mismo valor en todas las llas)

#El estado de los datos de ejemplo es uno de los posibles estados, la consulta debe funcionar correctamente cualquiera sean los datos.


select t1.name, cantpeli CantPeliTotal,pelis_sin_devolver,
(SELECT AVG(cant_copias_cat) prom FROM (SELECT 
        category_id, SUM(cant_copias_pelis) cant_copias_cat FROM film_category
    JOIN (SELECT  film_id, COUNT(film_id) cant_copias_pelis
    FROM  inventory
    GROUP BY film_id) pelis_sin_devol USING (film_id)
    GROUP BY category_id) cat_sin_devol) as promedio_copia_todas_categoria

  from(
select ca.name , count(*) cantpeli,fc.category_id from category ca
left join film_category fc on fc.category_id=ca.category_id
group by ca.name) t1
join(

SELECT  fc.category_id, COUNT(*) pelis_sin_devolver  FROM  inventory inv
    JOIN rental re on re.inventory_id=inv.inventory_id
    join film_category fc on fc.film_id=inv.film_id
    WHERE  (ISNULL(return_date)) GROUP BY fc.category_id) t2 on t2.category_id=t1.category_id




