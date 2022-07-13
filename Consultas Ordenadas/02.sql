# actores a los q sus peliculas las alquilaron mas de 500 veces y actuan en films de animación
select a.actor_id, count(*) from actor a

join film_actor fa on fa.actor_id=a.actor_id
join inventory inv on inv.film_id=fa.film_id
join rental re on re.inventory_id=inv.inventory_id

where a.actor_id in (select fa1.actor_id from film_actor fa1
					join film_category fc on fc.film_id=fa1.film_id
					join category c on c.category_id=fc.category_id
					where c.name='Animation'
					group by fa1.actor_id)
group by a.actor_id
having count(*) > 500


# otra opcion para el where:
# es mas eficiente usar el in porq el exists tiene q procesar toda la outer tabla 
where exists (select fa1.actor_id from film_actor fa1
					join film_category fc on fc.film_id=fa1.film_id
					join category c on c.category_id=fc.category_id
					where c.name='Animation'
					group by fa1.actor_id and fa1.actor_id=a.actor_id)

