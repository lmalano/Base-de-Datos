#Usando la BD Sakila: Realice un Stored Procedure 
#que registre un nueva copia ingresada a una tienda, 
#si se asume que la tienda y el film ya existen en la DB, recibirá los siguientes parámetros:
#Título del film (considerar que no se repiten)
#Teléfono de la tienda

#tengo que registrar una copia en inventory-> FILM_ID Y STORE_ID
delimiter ! 

create procedure nueva_copia(IN titulo varchar(255), IN telefono varchar(20))

begin

declare filmid SMALLINT;
declare storeid TINYINT;

set filmid= (
select film_id from film f where f.title= titulo);

set storeid= 
(select store_id from store s join address a
on s.address_id= a.address_id
where a.phone= telefono
);
             
insert into inventory(film_id, store_id) 
values (filmid, storeid);

end; !
