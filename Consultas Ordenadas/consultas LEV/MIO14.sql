#todos los films con cant copias, monto recaudado total y staf que mas alquileres realizo por film
select title, count(inv.inventory_id) copias, ifnull(recaudacion, 0) recaudacion, MAX(staf) staff_mas_alquilo from film f
left join inventory inv
on inv.film_id = f.film_id
left join (select inv.film_id, sum(amount) recaudacion from inventory inv
			left join rental r
			on r.inventory_id = inv.inventory_id
			left join payment p
			on p.rental_id = r.rental_id
			group by inv.film_id) t
on t.film_id = f.film_id
left join (select film_staff_cant.film_id, film_staff_cant.staff_id staf from 
			(select i.film_id, staff_id, count(*) cant from inventory i
				join rental r
				on r.inventory_id = i.inventory_id
				group by i.film_id, staff_id) film_staff_cant
			join (select film_id, max(cant) c from (select film_id, staff_id, count(*) cant from inventory i
													join rental r
													on r.inventory_id = i.inventory_id
													group by film_id, staff_id) t
				group by film_id) film_max
			on film_max.film_id = film_staff_cant.film_id and film_staff_cant.cant = film_max.c) t2
on t2.film_id = f.film_id
group by f.film_id;
