#actores que sus peliculas fueron alquiladas mas de 500 veces o que actuaron en films de animacion
select fa.actor_id,count(*) from rental re join inventory inv on 
inv.inventory_id = re.inventory_id
join film_actor fa on fa.film_id = inv.film_id
where exists (select actor_id from film_actor fa1 join film_category fc1
on fa1.film_id = fc1.film_id
join category ca1 on ca1.category_id = fc1.category_id
where ca1.name = 'Animation' and fa1.actor_id = fa.actor_id
group by actor_id) 
or exists (select actor_id from film_actor fa1 join film_category fc1
on fa1.film_id = fc1.film_id
join category ca1 on ca1.category_id = fc1.category_id
where fa1.actor_id = fa.actor_id
group by actor_id having count(*)>500) group by fa.actor_id


#con union
(select fa.actor_id from rental re join inventory inv on 
inv.inventory_id = re.inventory_id
join film_actor fa on fa.film_id = inv.film_id
group by fa.actor_id 
HAVING COUNT(*) > 500) 
union
(select fa1.actor_id  from film_actor fa1 join film_category fc1
on fa1.film_id = fc1.film_id
join category ca1 on ca1.category_id = fc1.category_id
where ca1.name = 'Animation'
group by fa1.actor_id )


# FORMA 1, SE AGREGA LA SUBCONSULTA AL HAVING QUE QUEDO DE ANTES CON UN OR

SELECT ac.actor_id, fcat.category_id, c.name AS category, count(*) AS cantidad_alq

FROM actor ac

JOIN film_actor fa ON fa.actor_id = ac.actor_id
JOIN inventory inv ON inv.film_id = fa.film_id
JOIN rental re ON re.inventory_id = inv.inventory_id
JOIN film_category fcat on fcat.film_id=ac.actor_id
JOIN category c ON c.category_id=fcat.category_id

GROUP BY ac.actor_id
HAVING count(*) > 500
	OR ac.actor_id IN (
		SELECT actor_id
		FROM film_actor fa1
		JOIN film_category fc ON fa1.film_id = fc.film_id
		JOIN category ca ON ca.category_id = fc.category_id
		WHERE ca.name = 'Animation'
		)



# FORMA 2, UNA CONSULTA CON UN WHERE CON 2 SUBCONSULTAS UNIDAS CON UN OR

SELECT * FROM actor

WHERE 
actor_id IN 
(SELECT fa.actor_id FROM rental re 
JOIN inventory inv ON inv.inventory_id=re.inventory_id
JOIN film_actor fa ON fa.film_id=inv.film_id
GROUP BY fa.actor_id
HAVING count(*) > 500)
OR 
actor_id IN 
(SELECT actor_id FROM film_actor fa1 
JOIN film_category fc1 ON fc1.film_id=fa1.film_id
JOIN category ca1 ON ca1.category_id=fc1.category_id
WHERE ca1.name= 'Animation'
GROUP BY actor_id)