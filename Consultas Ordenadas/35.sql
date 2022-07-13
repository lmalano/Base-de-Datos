#Mostar los alquileres que se entregaron fuera de termino, mostrando nombre y apellido del cliente, nombre de la pelicula, y dias de demora

select cu.first_name nombre, cu.last_name apellido, f.title titulo,
#hago la resta entre el tiempo de devolucion
#y la suma entre la fecha enla que se alquilo, y lo que daba el intervalo de duracion
#si la devolucion es mayor que esa fecha, es fuera de termino y me dice la cantidad de dias
datediff(re.return_date, date_add(re.rental_date, interval f.rental_duration day)) dias_demora

from customer cu
join rental re on cu.customer_id = re.customer_id
join inventory i on re.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id

where date(re.return_date) > date(date_add(re.rental_date, interval f.rental_duration day))

order by nombre, apellido, titulo;
