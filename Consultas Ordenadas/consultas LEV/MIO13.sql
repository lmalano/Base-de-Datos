select ac.actor_id, ifnull(t1.animacion,0) from actor ac
left join (
select ac.actor_id, count(*) animacion from
actor ac
join film_actor fa on fa.actor_id=ac.actor_id
join film_category fc on fc.film_id=fa.film_id
where fc.category_id=2
 GROUP BY (ac.actor_id)) t1 on t1.actor_id=ac.actor_id

