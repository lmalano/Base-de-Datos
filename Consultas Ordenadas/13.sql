#Genere una consulta que tenga 1 registro por cada "actor" con los campos: Apellido del actor,
#Cantidad de films que superaron la recaudacion promedio de todos los films de la base de datos - Usar la tabla payment
#	-Cantidad de categorias distintas de los films en los que participo 
#	-Cantidad total de alquileres de films en los que participó

select actor.last_name Apellido, sub3.FilmsSupAlPromedioGan, sub5.TotalCategorias, sub4.TotalUnAlquiladas from actor
	left join (select sub2.actor_id, count(*) FilmsSupAlPromedioGan
								from(select film_actor.actor_id, sub1.film_id, sub1.GananciaPorPelicula, sub1.UnidadesAlq from film_actor
									join (
											select inventory.film_id, sum(payment.amount) GananciaPorPelicula, count(rental.inventory_id) UnidadesAlq from payment
												join rental on payment.rental_id = rental.rental_id
												join inventory on rental.inventory_id = inventory.inventory_id
												group by inventory.film_id) sub1
												on film_actor.film_id = sub1.film_id) sub2
					where sub2.GananciaPorPelicula > (select avg(sub1.GananciaPorPelicula) PromTotal from(select inventory.film_id, sum(payment.amount) GananciaPorPelicula from payment
													join rental on payment.rental_id = rental.rental_id
													join inventory on rental.inventory_id = inventory.inventory_id
													group by inventory.film_id) sub1)
					group by sub2.actor_id) sub3 on actor.actor_id = sub3.actor_id
	join (select sub2.actor_id, sum(sub2.UnidadesAlq) TotalUnAlquiladas
								from(select film_actor.actor_id, sub1.film_id, sub1.GananciaPorPelicula, sub1.UnidadesAlq from film_actor
									join (
											select inventory.film_id, sum(payment.amount) GananciaPorPelicula, count(rental.inventory_id) UnidadesAlq from payment
												join rental on payment.rental_id = rental.rental_id
												join inventory on rental.inventory_id = inventory.inventory_id
												group by inventory.film_id) sub1
												on film_actor.film_id = sub1.film_id) sub2
					group by sub2.actor_id) sub4 on actor.actor_id = sub4.actor_id
	join (select sub2.actor_id, count(distinct film_category.category_id) TotalCategorias from(
				select film_actor.actor_id, sub1.film_id, sub1.GananciaPorPelicula, sub1.UnidadesAlq from film_actor
					join (
							select inventory.film_id, sum(payment.amount) GananciaPorPelicula, count(rental.inventory_id) UnidadesAlq from payment
								join rental on payment.rental_id = rental.rental_id
								join inventory on rental.inventory_id = inventory.inventory_id
								group by inventory.film_id) sub1
								on film_actor.film_id = sub1.film_id) sub2
				join film_category on sub2.film_id = film_category.film_id
				group by sub2.actor_id) sub5 on actor.actor_id = sub5.actor_id
				order by actor.actor_id asc