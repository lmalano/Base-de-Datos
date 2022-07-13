/*Sobre la base de datos Sakila realice una consulta que muestre la evolución de los alquileres de películas, 
por año y por semestre, los semestres se identificaran por un número (1 – primer semestre, 2 – segundo semestre). 
Un registro por cada película, mes (O AÑO?) y semestre, indicando una columna con la cantidad de alquileres en ese periodo para esa película. 
Las películas se ordenaran de mayor a menor por la cantidad total de alquileres que han tenido histórico 
(nota: los datos representan un estado posible de los mismos, la consulta deberá funcionar para cualquier estado de los datos. 
Si necesitara Ud. podrá modificarlos para probar distintas posibilidades).*/

SELECT 
    A.title, COUNT(film_id) AS cantidad, A.semestre, A.año
FROM
    (SELECT 
        re.rental_id,
            YEAR(re.rental_date) AS año,
            inv.inventory_id,
            fi.film_id,
            fi.title,
            CASE
                WHEN MONTH(re.rental_date) > 6 THEN 2
                ELSE 1
            END AS semestre
    FROM
        rental re, inventory inv, film fi
    WHERE
        inv.inventory_id = re.inventory_id
            AND fi.film_id = inv.film_id
    GROUP BY rental_id) AS A
GROUP BY A.film_id , A.semestre
ORDER BY cantidad DESC;