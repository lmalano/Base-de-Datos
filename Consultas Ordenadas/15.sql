# Actores con la pelicula que mas recaudo (titulo y film_id), recaudacion por actor y actores que ganaron mas que el
select sub5.*, (select count(*) from
		(select sub4.actor_id, sub4.film_id, sub4.title, sub4.totalGananciaFilm Recaudacion from (
							select * from( #sub2
											select film_actor.actor_id, film.film_id, film.title, sub1.GananciaFilm from film_actor
													join film on film_actor.film_id = film.film_id
													join (select sum(payment.amount) GananciaFilm, rental.inventory_id, inventory.film_id from payment #sub1
															join rental on payment.rental_id = rental.rental_id
															join inventory on rental.inventory_id = inventory.inventory_id
															group by inventory.film_id) sub1 on film.film_id = sub1.film_id
															order by film_actor.actor_id asc, sub1.GananciaFilm desc) sub2
								join (select sub2.actor_id ActorId, max(sub2.GananciaFilm) maxGananciaFilm, sum(sub2.GananciaFilm) totalGananciaFilm from #sub3
										(select film_actor.actor_id, film.film_id, film.title, sub1.GananciaFilm from film_actor
											join film on film_actor.film_id = film.film_id
											join (select sum(payment.amount) GananciaFilm, rental.inventory_id, inventory.film_id from payment #sub1
													join rental on payment.rental_id = rental.rental_id
													join inventory on rental.inventory_id = inventory.inventory_id
													group by inventory.film_id) sub1
													on film.film_id = sub1.film_id
													/*order by film_actor.actor_id asc, sub1.GananciaFilm desc*/) sub2
										group by sub2.actor_id) sub3
										on sub2.actor_id = sub3.ActorId
										order by sub2.actor_id asc, sub2.gananciaFilm desc) sub4
					where sub4.GananciaFilm = sub4.maxGananciaFilm) sub6
                    where sub6.Recaudacion > sub5.Recaudacion) cantidadActMasGanadores from
			(select sub4.actor_id, sub4.film_id, sub4.title, sub4.totalGananciaFilm Recaudacion from (
							select * from( #sub2
											select film_actor.actor_id, film.film_id, film.title, sub1.GananciaFilm from film_actor
													join film on film_actor.film_id = film.film_id
													join (select sum(payment.amount) GananciaFilm, rental.inventory_id, inventory.film_id from payment #sub1
															join rental on payment.rental_id = rental.rental_id
															join inventory on rental.inventory_id = inventory.inventory_id
															group by inventory.film_id) sub1
															on film.film_id = sub1.film_id
															order by film_actor.actor_id asc, sub1.GananciaFilm desc) sub2
								join (select sub2.actor_id ActorId, max(sub2.GananciaFilm) maxGananciaFilm, sum(sub2.GananciaFilm) totalGananciaFilm from #sub3
										(select film_actor.actor_id, film.film_id, film.title, sub1.GananciaFilm from film_actor
											join film on film_actor.film_id = film.film_id
											join (select sum(payment.amount) GananciaFilm, rental.inventory_id, inventory.film_id from payment #sub1
													join rental on payment.rental_id = rental.rental_id
													join inventory on rental.inventory_id = inventory.inventory_id
													group by inventory.film_id) sub1
													on film.film_id = sub1.film_id
													/*order by film_actor.actor_id asc, sub1.GananciaFilm desc*/) sub2
										group by sub2.actor_id) sub3
										on sub2.actor_id = sub3.ActorId
										order by sub2.actor_id asc, sub2.gananciaFilm desc) sub4
					where sub4.GananciaFilm = sub4.maxGananciaFilm) sub5
