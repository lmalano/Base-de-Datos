#Desarrollar un store procedure que reciba como parámetros referidos a un nuevo film:

#· Nombre y apellido del actor (asume que se carga uno solo)

#· Nombre del Film
#· Descripción
#· Año de lanzamiento

#· Nombre del lenguaje

#· Duración del alquiler
#· Longitud
#· Rating
#· Costo de reemplazo
#· Características especiales

#· Nombre de la categoría

#El SP realizará las inserciones en las tablas correspondientes,
#controlar si existe un actor con el mismo nombre y apellido
#y en caso necesitarlo que el SP produzca la inserción.

use sakila;

delimiter ! 

create procedure 1primero(in nombre varchar(45), in apellido varchar(45), in nombre_film varchar(255),
in descripcion text, in ano_l year, in nombrelenguaje char(20), in duracion tinyint(3), in longitud smallint(5),
in mrating enum('G','PG','PG-13','R','NC-17'), in costo_reemplazo decimal(5,2), 
in caracteristicas set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),in nombre_categoria varchar(25))

begin

declare id_actor smallint default null;
declare id_film smallint default null;
declare id_lenguaje tinyint default null;
declare id_categoria tinyint default null;

#controlo que el actor no exista
select actor_id into id_actor
from actor a
where a.first_name= nombre 
and a.last_name= apellido;


#si no existe ese actor, realizo la insercion en la tabla actor
if id_actor is null then
insert into actor (first_name, last_name) values (nombre, apellido);
end if;

#actualizo la tabla de film

#debo obtener el language_id
select language_id into id_lenguaje
from language l where l.name= nombrelenguaje; 

insert into film (title, description,release_year, language_id, rental_duration,length, replacement_cost,rating, special_features)
values (nombre_film, descripcion, ano_l, id_lenguaje, duracion, longitud, costo_reemplazo, mrating, caracteristicas);

#saco el id_film para actualizar la tabla de actor, actor_id ya lo tengo
select film_id into id_film
from film f
where f.title=nombre_film and f.release_year= ano_l;

insert into film_actor(actor_id, film_id) values (id_actor,id_film);

#actualizo la categoria
select category_id into id_categoria
from category c where c.name= nombre_categoria;

insert into film_category (film_id, category_id) values (id_film, id_categoria);

###### para mi, tengo que actualizar la tabla inventory, pero no tengo como no tengo los datos de store

end; !


