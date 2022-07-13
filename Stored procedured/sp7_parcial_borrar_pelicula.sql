#NO CORRERRRRRRRRRRRRRRRRRRRRRRRRRRRR O VOY A BORRAR TODO!

#Sobre la base de datos SAKILA programe un store procedure que elimine una película, 
#el parámetro que recibe es el nombre de la película y debe eliminar todos los registros asociados de las tablas correspondientes,
#solo NO deberá realizar la tarea si la película tiene algún PAGO asociado, si solo tiene alquileres no pago debe eliminarla. 
#Los datos actuales son un ejemplo de un estado posible de la información,
#el procedimiento debe funcionar correctamente en cualquier situación. 

use sakila;

delimiter ! 

create procedure 4deletepelicula(in nombrepelicula varchar(255))

begin

declare idfilm smallint default null;

#controlo que el pago de esa pelicula (con su nombre lo saco) no exista
select film_id  into idfilm
from payment p
join rental r on p.rental_id=r.rental_id
join inventory i on r.inventory_id= i.inventory_id
join film j on j.film_id = i.film_id
where j.name= nombrepelicula;



#si no existe el pago de ese film, elimino la pelicula
if idfilm is null then
   delete film_id from film, inventory
   where film.name=nombrepelicula;
   
end if;

#
#delete film_id, title, description, release year,languague_id.... from film
#delete film_id from inventory ... y ver que sea esa la peli que borro(con el nombre)
#

end; !
