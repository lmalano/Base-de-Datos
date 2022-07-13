/*Sobre la base de datos SAKILA, realice una consulta que liste por cada categoría de film, 
la cantidad total de alquileres, el monto recaudado, cantidad de peliculas vencidas y no devueltas, 
el actor que mas peliculas protagonizó de esa categoría, si hay dos o mas con la misma cantidad tomar uno. 
Los datos actuales son solo una muestra de un estado posible, la consulta deberá funcionar para cualquier estado posible de los datos.*/
select A.name as categoria, A.cant_alquileres, B.monto_total, C.cant_vencidas from

(select ca.category_id, ca.name, fi.film_id, fi.title, inv.inventory_id, count(re.rental_id) as cant_alquileres
	from category ca, film_category fic, film fi, inventory inv, rental re
    where ca.category_id = fic.category_id
    and fic.film_id = fi.film_id
    and fi.film_id = inv.film_id
    and inv.inventory_id = re.inventory_id
    group by ca.category_id) as A, -- CANTIDAD DE ALQUILERES
    
(select ca.category_id, ca.name, fi.film_id, fi.title, inv.inventory_id, re.rental_id, pa.payment_id, sum(pa.amount) as monto_total
	from category ca, film_category fic, film fi, inventory inv, rental re, payment pa
    where ca.category_id = fic.category_id
    and fic.film_id = fi.film_id
    and fi.film_id = inv.film_id
    and inv.inventory_id = re.inventory_id
    and pa.rental_id = re.rental_id
    group by category_id) as B, -- MONTO TOTAL 
    

(select A.*, count(demorado) as cant_vencidas from    
(select ca.category_id, ca.name, fi.film_id, fi.title, inv.inventory_id, re.rental_id, fi.rental_duration, datediff(re.return_date,re.rental_date) as dias_alq, 
case 
	when(datediff(re.return_date,re.rental_date)>fi.rental_duration)
		then 1
        else 0
	end as demorado
    from category ca, film_category fic, film fi, inventory inv, rental re
    where ca.category_id = fic.category_id
    and fic.film_id = fi.film_id
    and fi.film_id = inv.film_id
    and inv.inventory_id = re.inventory_id) as A
    where A.demorado=1
    group by category_id) as C -- CANTIDAD DEVUELTAS TARDE
    
    where A.category_id = B.category_id
    and A.category_id = C.category_id;
    
select ca.category_id, ca.name, fi.film_id, fi.title, ac.actor_id, ac.first_name, ac.last_name, count(ca.category_id) as cantidad
	from category ca, film_category fic, film fi, film_actor fia, actor ac
    where ca.category_id = fic.category_id
    and fic.film_id = fi.film_id
    and fi.film_id = fia.film_id
    and fia.actor_id = ac.actor_id
    group by ca.category_id, ac.actor_id
    ;
      
select A.*, max(A.cantidad) from
(select ca.category_id, ca.name, fi.film_id, fi.title, ac.actor_id, ac.first_name, ac.last_name, count(ca.category_id) as cantidad
	from category ca, film_category fic, film fi, film_actor fia, actor ac
    where ca.category_id = fic.category_id
    and fic.film_id = fi.film_id
    and fi.film_id = fia.film_id
    and fia.actor_id = ac.actor_id
    group by ca.category_id, ac.actor_id) as A
    group by A.category_id
    ;

