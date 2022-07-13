# Actor mas visto en Argentina
use sakila;
select act.first_name, act.last_name from 
(select max(lala), tabla1.acid aaa from 
(select ac.actor_id acid,count(ac.actor_id)lala from actor ac
join film_actor fa on ac.actor_id=fa.actor_id
join film f on f.film_id=fa.film_id
join inventory i on i.film_id=f.film_id
join rental r on r.inventory_id=i.inventory_id
join customer c on c.customer_id=r.customer_id
join address a on a.address_id=c.address_id
join city cy on cy.city_id=a.city_id
join country coun on coun.country_id=cy.country_id
where coun.country="Argentina"
group by ac.actor_id
order by lala desc
)tabla1
)tabla2, actor act
where act.actor_id=tabla2.aaa



