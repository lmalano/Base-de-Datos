#Practico clase consulta:
# Por cada combinación categoría - actor indicar nombre de la categoría, 
# nombre y apellido del actor y cuantos alquileres se realizaron de cada categoría por películas de cada actor, 
# Se debe producir un registro para cada una de las combinaciones actor categoría (producto cartesiano),
# indicando 0 (cero) en los casos que corresponda

select Nombre,Apellido,Categoria,ifnull(cuenta,0) Cuenta from 
(select actor_id,category_id,first_name Nombre,last_name Apellido,name Categoria from actor,category) lala
left join
(
 select actor_id,category_id , ifnull(count(rental_id),0) cuenta from film_actor
 left join 
 (select film_id,category_id,rental_id from film_category 
 join inventory using(film_id)
 join rental using (inventory_id)
 )lala using (film_id)
 group by actor_id,category_id
 ) 
peli_por_actor using(actor_id,category_id);

 