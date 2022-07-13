# Actores que actuaron en peliculas de mas de 70 min
select ac.first_name,ac.last_name from actor ac
join film_actor fa on fa.actor_id=ac.actor_id
join film f on f.film_id=fa.film_id
where f.length>70

# Los 5 actores que mas tiempo actuaron, sumando la duracion de todas sus peliculas
select actor.first_name,actor.last_name, duracion_total from actor, 
  (select sum(length) duracion_total,actor_id from film join film_actor 
	on film.film_id = film_actor.film_id
group by actor_id) len
where actor.actor_id =  len.actor_id
order by duracion_total desc limit 5