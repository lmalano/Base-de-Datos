# Peliculas con su numeros de copia, su recaudacion y el staff que mas vendio
select fi.title, count(inv.inventory_id) num_copias, recaudado.recaudado recaudado, st.first_name nombre_staff, st.last_name apellido_staff from film fi
join inventory inv on inv.film_id = fi.film_id

join (select film_id, sum(pay.amount) recaudado from inventory i
		join rental re on re.inventory_id = i.inventory_id
		join payment pay on pay.rental_id = re.rental_id 
        group by film_id) recaudado
on recaudado.film_id = inv.film_id

join (select cantidad.film_id, cantidad.staff_id, cantidad.cant from 
			(select inv.film_id, re.staff_id, count(*) cant from inventory inv
				join rental re on re.inventory_id = inv.inventory_id
				group by re.staff_id, inv.film_id order by film_id, cant desc ) cantidad # al poner cant des, me ordena de mayor a menor y eso hace q agrupe por el primer elemento que es el mas grande
	group by cantidad.film_id
    ) staff_numero
    
on staff_numero.film_id = fi.film_id
join staff st on st.staff_id = staff_numero.staff_id
group by inv.film_id order by fi.film_id;