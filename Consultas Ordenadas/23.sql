# Listado de actores que mas ganaron por mes y año
select t1.*, actor.first_name, actor.last_name
from
    (
        select  t1.y, t1.m, max(ganancias) as ganancias
        from 
            (
                select actor_id, sum(ganancias) as ganancias, t2.y, t2.m
                from 
                    (
                        select film.film_id, actor.actor_id
                        from film, film_actor, actor
                        where film_actor.film_id = film.film_id
                            and film_actor.actor_id = actor.actor_id
                    ) as t1,
                    (
                        select sum(payment.amount) as ganancias, inventory.film_id, year(payment.payment_date) as y, month(payment.payment_date) as m
                        from payment, rental, inventory
                        where payment.rental_id = rental.rental_id
                            and rental.inventory_id = inventory.inventory_id
                        group by year(payment.payment_date), month(payment.payment_date), inventory.film_id
                    ) as t2
                where t1.film_id = t2.film_id
                group by actor_id, t2.y, t2.m
            ) as t1
        group by t1.y, t1.m
    ) as t1,
    (
        select actor_id, sum(ganancias) as ganancias, t2.y, t2.m
        from 
            (
                select film.film_id, actor.actor_id
                from film, film_actor, actor
                where film_actor.film_id = film.film_id
                    and film_actor.actor_id = actor.actor_id
            ) as t1,
            (
                select sum(payment.amount) as ganancias, inventory.film_id, year(payment.payment_date) as y, month(payment.payment_date) as m
                from payment, rental, inventory
                where payment.rental_id = rental.rental_id
                    and rental.inventory_id = inventory.inventory_id
                group by year(payment.payment_date), month(payment.payment_date), inventory.film_id
            ) as t2
        where t1.film_id = t2.film_id
        group by actor_id, t2.y, t2.m
    ) as t2, actor
where t1.ganancias = t2.ganancias
    and actor.actor_id = t2.actor_id