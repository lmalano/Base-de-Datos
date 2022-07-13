#actualizar apellido_actor

use sakila;

delimiter ! 

create procedure 3apellido(in id smallint(5), apellido varchar(45))

begin

update actor set last_name = apellido
where actor.actor_id=id;
#----------------------------------

end; !