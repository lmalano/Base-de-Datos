#Listado de actores que con las ganancias
select film_actor.actor_id, sum(t2.total) as total, actor.first_name, actor.last_name
from film_actor, actor,
    (select film_id, sum(total) as total
    from inventory,
        (select rental.inventory_id, sum(payment.amount) as total from rental, payment
        where payment.rental_id = rental.rental_id
        group by rental.inventory_id) as t1
    where inventory.inventory_id = t1.inventory_id
    group by film_id) as t2
where film_actor.film_id = t2.film_id
    and film_actor.actor_id = actor.actor_id
group by film_actor.actor_id