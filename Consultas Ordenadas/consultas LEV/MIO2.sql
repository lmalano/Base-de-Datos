
select a.actor_id, a.first_name, a.last_name, ifnull(t1.Animacion,0), ifnull(t2.Accion,0) from actor a left join (
select fa.actor_id, f.film_id f_id, count(c.category_id) Animacion from film f 
join film_actor fa on fa.film_id=f.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id
where c.name='Animation'
group by fa.actor_id) t1 on t1.actor_id=a.actor_id
left join (
select fa.actor_id, f.film_id f_id, count(c.category_id) Accion from film f 
join film_actor fa on fa.film_id=f.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id=fc.category_id
where c.name='Action'
group by fa.actor_id) t2 on t2.actor_id=a.actor_id
