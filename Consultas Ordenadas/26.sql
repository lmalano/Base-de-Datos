/*Sobre la base de datos Sakila realice una consulta que emita un ranking de ciudades morosas, 
el listado deberá indicar el nombre de la ciudad, la cantidad de clientes registrados en esa ciudad, 
el promedio de alquileres realizados por cliente y el promedio de alquileres devueltos fuera de fecha por cliente. 
El listado deberá incluir todas las ciudades, en los casos que no haya clientes registrados en una ciudad no deberá mostrar nada en las columnas de promedio. 
Ordenar por la última columna de mayor a menor. El vacío se considera menor que todos.*/

select A.city_id, A.city, A.cant_clientes, sum(B.cant_alquileres) as cant_alquileres, (sum(B.cant_alquileres)/A.cant_clientes) as promedio, C.fuera_termino from
( select ci.city_id, ci.city, ad.address_id, count(cu.customer_id) as cant_clientes
	from city ci
		left join address ad
        on ci.city_id = ad.city_id
        left join customer cu
        on ad.address_id = cu.address_id
	group by city_id) as A -- CANTIDAD DE CLIENTES
    left join
(select ci.city_id, ci.city, ad.address_id, cu.customer_id, count(re.rental_id) as cant_alquileres
	from city ci, address ad, customer cu, rental re
    where ci.city_id = ad.city_id
    and ad.address_id = cu.address_id
    and re.customer_id = cu.customer_id
    group by cu.customer_id) as B -- CANTIDAD DE ALQUILERES
    on A.city_id = B.city_id
    left join
(select A.*, count(demorado) as fuera_termino from
    (select ci.city_id, ci.city, ad.address_id, cu.customer_id, re.rental_id, datediff(return_date, re.rental_date) as tiempo_peli, inv.inventory_id, fi.film_id, fi.rental_duration, 
    case
		when(datediff(return_date, re.rental_date)>fi.rental_duration)
			then 1
            else 0
	end as demorado
	from city ci, address ad, customer cu, rental re, inventory inv, film fi
    where ci.city_id = ad.city_id
    and ad.address_id = cu.address_id
    and re.customer_id = cu.customer_id
    and inv.inventory_id = re.inventory_id
    and fi.film_id = inv.film_id) as A
    where A.demorado = 1
    group by city_id) as C -- CANTIDAD DEVUELTOS FUERA DE TERMINO
    
    on B.city_id = C.city_id
    group by A.city_id;
    
