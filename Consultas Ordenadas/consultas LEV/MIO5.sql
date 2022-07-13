select fa.actor_id, f.film_id f_id, sum(pa.amount) suma from film f 
join film_actor fa on fa.film_id=f.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id
join inventory inv on inv.film_id=fa.film_id
join rental re on re.inventory_id=inv.inventory_id 
join payment pa on pa.rental_id= re.rental_id
group by fa.actor_id
having sum(pa.amount) >  (
select avg(t1.suma1) from(
select  sum(pa.amount) suma1 from film f 
join film_actor fa on fa.film_id=f.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id
join inventory inv on inv.film_id=fa.film_id
join rental re on re.inventory_id=inv.inventory_id 
join payment pa on pa.rental_id= re.rental_id
group by fa.actor_id
) t1
)
