#Recupere de la base de datos un listado de todas las películas que tienen mas copias en el inventario que el promedio de las
#películas. Para el calculo del promedio tener en cuenta las películas que no tienen copias.

#De cada película en el listado deberá indicar:

#- NOMBRE DE LA PELÍCULA
#- CANTIDAD DE ACTORES QUE ACTÚAN
#- CANTIDAD TOTAL DE ALQUILERES QUE SE REALIZARON DE ESA PELÍCULA
#- PROMEDIO DE COPIAS DE TODAS LAS PELICULAS (esta columna tendrá el mismo valor en todas las filas)
#El estado de los datos de ejemplo es uno de los posibles estados, la consulta debe funcionar correctamente cualquiera sean los datos.

SELECT 
    nombre Nombre,
    IFNULL(cant_actores, 0) 'Cantidad Actores',
    IFNULL(numero_de_alquileres, 0) 'Numero Alquileres',
    prom 'Promedio'
FROM
    (SELECT 
        film_id, title nombre
    FROM
        film_text) Nombre_Peli
        LEFT JOIN
    (SELECT 
        film_id, COUNT(*) cant_actores
    FROM
        film_actor
    GROUP BY film_id) Actores USING (film_id)
        LEFT JOIN
    (SELECT 
        film_id, COUNT(rental_id) numero_de_alquileres
    FROM
        inventory
    JOIN rental USING (inventory_id)
    GROUP BY film_id) Alquileres USING (film_id)
        CROSS JOIN
    (SELECT 
        AVG(cantidad_copias) prom
    FROM
        (SELECT 
        film_id, COUNT(*) cantidad_copias
    FROM
        film_category
    LEFT JOIN inventory USING (film_id)
    GROUP BY film_id) copias) promedio_copias
WHERE
    film_id IN (SELECT 
            film_id
        FROM
            inventory
        GROUP BY film_id
        HAVING (COUNT(*) > prom))
