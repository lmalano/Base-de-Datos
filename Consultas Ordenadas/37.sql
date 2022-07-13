/* PARCIAL 25-6-19
) Escriba una consulta a la base de datos Sakila que devuelva para cada para cada film :
a)	Título del film
b)	Nombre del distrito donde viven la mayor cantidad de clientes que rentaron esa película, si hay empate poner tantos registros como distritos empaten repitiendo los valores de las  columnas a y d.
c)	Cantidad de clientes totales que viven en ese distrito.
d)	Cantidad total de copias  de ese film
Si un film no tiene alquileres no debe aparecer. Ordenar por columna b descendente y por a ascendente
*/
select film.title Titulo, sub8.district Distrito, sub8.Habitantes CantClientes, sub8.CantCopias from
(select sub6.*, sub7.CantCopias from
(select sub4.*, sub5.Habitantes from (select distinct sub2.district, sub2.film_id from
(select count(*) CantidadAlquileres, sub1.film_id, sub1.district from
(select rental.rental_id, rental.customer_id, inventory.film_id, address.address_id, address.district from rental
join inventory on inventory.inventory_id = rental.inventory_id
join customer on rental.customer_id = customer.customer_id
join address on address.address_id = customer.address_id) sub1
group by sub1.film_id, sub1.district) sub2
where sub2.CantidadAlquileres = (select max(sub3.CantidadAlquileres) from (select count(*) CantidadAlquileres, sub1.film_id, sub1.district from
(select rental.rental_id, rental.customer_id, inventory.film_id, address.address_id, address.district from rental
join inventory on inventory.inventory_id = rental.inventory_id
join customer on rental.customer_id = customer.customer_id
join address on address.address_id = customer.address_id) sub1
group by sub1.film_id, sub1.district) sub3
where sub3.film_id = sub2.film_id)) sub4
join (select count(*) Habitantes, sub5.district from
(select customer.customer_id, address.district from customer
join address on customer.address_id = address.address_id) sub5
group by sub5.district) sub5 on sub4.district = sub5.district) sub6
join (select count(*) CantCopias, inventory.film_id from inventory
group by inventory.film_id) sub7 on sub6.film_id = sub7.film_id) sub8
join film on sub8.film_id = film.film_id
order by film.title asc, sub8.district desc