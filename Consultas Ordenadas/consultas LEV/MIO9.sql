select a.actor_id, count(distinct fc.category_id ) from actor a 
join film_actor fa on fa.actor_id=a.actor_id
join film f on f.film_id=fa.film_id
join film_category fc on fc.film_id=f.film_id
group by a.actor_id
having count(distinct fc.category_id)>3