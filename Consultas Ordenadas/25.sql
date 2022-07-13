/*Sobre la base de datos SAKILA, realice una consulta que dé como resultado un listado donde para cada actor se muestre: 
id del actor, apellido del actor, nombre del actor, clasificación (categoría), cantidad de films de ese actor en esa clasificación.
Devolverá un registro por cada combinación actor / categoría que encuentre en la BD. 
Se aplicará un filtro para que muestre SOLO los actores que han actuado en films de TODAS las categorías.
Tener en cuenta que se pueden agregar o eliminar categorías y la consulta debe seguir funcionando respetando la consigna. 
Los datos actuales son un ejemplo de un estado posible de la información, la consulta debe funcionar correctamente en cualquier estado de datos.*/    

select B.actor_id, B.last_name, B.first_name, B.cant_category from
(select A.*, count(distinct A.name) as cant_category from
(select ac.actor_id, ac.last_name, ac.first_name, ca.name, count(fi.film_id) as cant_films
	from actor ac, film_actor fia, film fi, film_category fic, category ca
	where fia.actor_id = ac.actor_id
    and fi.film_id = fia.film_id
    and fi.film_id = fic.film_id
    and fic.category_id = ca.category_id
    group by ac.actor_id, ca.category_id) as A
    group by A.actor_id) as B
    where B.cant_category in (select count(category_id) from category);

