#Usando la BD Sakila: Realice un Stored Procedure que inserte un nuevo alquiler 
#de un film (UNA NUEVA RENTA), recibe los siguientes datos:

#Título del film (se asume que no se repite) DEBO CONVINAR CON FILM
#Teléfono de la tienda donde se alquiló
#Apellido del empleado que lo alquiló 
#Nombre del empleado que lo alquiló
#Teléfono del Cliente que lo alquiló

#La fecha y hora del alquiler se toma como la de la inserción en la tabla. (NOW())
#La copia que se renta se debe tomar como alguna de ese film que esté disponible.
#La fecha de devolución se calcula en función del film que se trate.

use sakila;

delimiter ! 

create procedure 5alquiler(in titulo varchar(255), in telefono varchar(20), in apellido varchar(45),  in nombre varchar(45),
in telefonocustomer varchar(20))

begin

declare id_film smallint default null;
declare inventorio mediumint default null;
declare cliente smallint default null;
declare devolucion date default null;
declare id_staff tinyint default null;

#controlo que haya copias
select film_id into id_film
from inventory i join film f
on i.film_id=f.film_id
where f.title= titulo;

#si no existe esa ciudad, realizo la insercion en la tabla city
if id_film is not null then
    
    #obtengo el inventory
    select inventory_id into inventorio
    from inventory i join film f
    on i.film_id= f.film_id
    where f.title=titulo;
    
    #obtengo el customer con el telefono del cliente
    select customer_id into cliente
    from customer c join address a
    on c.address_id= a.address_id
    where a.phone=telefono;
    
    select adddate (now(), 3) into devolucion;
    
    select staff_id into id_staff
    from staff s join address ad
    on s.address_id= ad.address_id
    where s.first_name= nombre and s.last_name= apellido;
    
    insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id) 
                values (now(), inventorio, cliente, devolucion, id_staff);
end if;


end; !