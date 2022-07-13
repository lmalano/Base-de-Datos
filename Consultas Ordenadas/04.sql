# Actores y sus peliculas en donde actuaron, con su recaudacion e indicar en cual es la que mayor recaudo
select a.actor_id, f.film_id,f.title,sum(p.amount) as total ,a.last_name,if( sum(p.amount) != total.total,'NO','SI') from (rental as r left join inventory as i on r.inventory_id=i.inventory_id
left join film as f on i.film_id=f.film_id
left join film_actor as fa on fa.film_id=f.film_id
left join actor as a on fa.actor_id=a.actor_id
left join payment as p on p.rental_id=r.rental_id

)
inner join (

select actor_id, max(total) as total  from (
select a.actor_id, f.film_id,f.title,sum(p.amount)as total ,a.last_name from rental as r left join inventory as i on 
r.inventory_id=i.inventory_id
left join film as f on i.film_id=f.film_id
left join film_actor as fa on fa.film_id=f.film_id
left join actor as a on fa.actor_id=a.actor_id
left join payment as p on p.rental_id=r.rental_id
#where a.actor_id is not null

group by f.film_id, a.actor_id
) xx group by actor_id 

order by actor_id) total on total.actor_id=a.actor_id

group by f.film_id, a.actor_id
