/*Listar todos los actores con su nombre y apellido y la cantidad de peliculas que actuaron del tipo "Animation",
si no actuó en ninguna poner 0
*/
select ac.actor_id, ac.first_name, ac.last_name , ifnull(cant,0) cantanimacion from actor ac
left join (  #va el left xq lo q no machea de la derecha, nos da null, q serian los actores sin peliculas de animacion (como el 3r0)
select a.actor_id, count(*) cant from actor a join film_actor fa on fa.actor_id= a.actor_id
join film f on f.film_id=fa.film_id
join film_category fc on fc.film_id=f.film_id
join category c on c.category_id= fc.category_id
where c.name="animation"
group by a.actor_id) aa
on ac.actor_id=aa.actor_id
order by ac.actor_id

/* #peliculas con mayor duracion y precio de alquiler
select * from film where rental_duration = (select max(rental_duration) from film ) 
and length= (select max(length) from film)

# rental_rate = (select max(rental_rate) from film) 

*/
