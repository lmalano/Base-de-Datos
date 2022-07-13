# Por cada combinación categoría - actor indicar nombre de la categoría, 
# nombre y apellido del actor y cuantos alquileres se realizaron de cada categoría por peliculas de cada actor, 
# Se debe producir un registro para cada una de las combinaciones actor categoría (producto cartesiano),
# indicando 0 (cero) en los casos que corresponda OK
select first_name,last_name,name,ifnull(cantalq,0) from
(Select actor.actor_id,category.category_id,actor.first_name,actor.last_name,category.name from actor,category
/*
select ac.actor_id,ca.category_id, ac.first_name,ac.last_name,ca.name from actor ac 
join film_actor fa on fa.actor_id=ac.actor_id
join film_category fc on fc.film_id =fa.film_id
join category ca on ca.category_id=fc.category_id
*/
) ac
left join
(select actor_id,category_id,count(*) cantalq from rental ren 
join inventory inv on inv.inventory_id=ren.inventory_id
join film_actor fa on fa.film_id = inv.film_id
join film_category fc on fc.film_id=fa.film_id
group by actor_id,category_id) vg
on ac.actor_id = vg.actor_id and ac.category_id = vg.category_id
