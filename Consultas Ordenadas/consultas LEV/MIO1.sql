select a.actor_id, ifnull(count(t1.f_id),0) cant, ifnull(t1.suma,0) recaudacion 
from actor a join film_actor fa on fa.actor_id= a.actor_id
	join film f on f.film_id=fa.film_id
	join film_category fc on fc.film_id=f.film_id
	join category c on c.category_id= fc.category_id
left join
(
select fa.actor_id, f.film_id f_id, sum(pa.amount) suma from film f 
join film_actor fa on fa.film_id=f.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id
join inventory inv on inv.film_id=fa.film_id
join rental re on re.inventory_id=inv.inventory_id 
join payment pa on pa.rental_id= re.rental_id
where c.name='Animation'
group by fa.actor_id ) t1 on t1.actor_id=a.actor_id
group by a.actor_id
order by 1


   