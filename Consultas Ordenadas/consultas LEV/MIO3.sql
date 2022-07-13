select a.actor_id, a.first_name, a.last_name from actor a
join film_actor fa on fa.actor_id=a.actor_id
join inventory inv on inv.film_id= fa.film_id
join rental re on re.inventory_id=inv.inventory_id
where month(re.rental_date)=5
group by a.actor_id
