#cantidad de actor por peliculas rentadas
select fi.title, count(ac.actor_id) from film as fi 
join inventory as inv on fi.film_id=inv.film_id
join rental as re on re.inventory_id=inv.inventory_id 
join film_actor as fa on fi.film_id=fa.film_id 
join actor as ac on fa.actor_id=ac.actor_id group by fi.title