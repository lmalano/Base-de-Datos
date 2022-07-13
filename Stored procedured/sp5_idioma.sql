#Desarrollar un store procedure que reciba como parámetro el nombre de un idioma y lo incerte como 
#original_language en todas las tuplas de la tabla film. Si no existe el idioma que lo cree.

#----->como todos los idiomas originales estaban en null, le cargue el id 7!!

use sakila;

delimiter ! 

create procedure 2idioma(in idioma char(20))

begin

declare id_idioma tinyint default null;

#controlo que el idioma no exista
select language_id into id_idioma
from language l
where l.name= idioma;

#si no existe esa ciudad, realizo la insercion en la tabla city
if id_idioma is null then
    insert into language (name) values (idioma);
end if;


#actualizo tabla:film
#valor: original_language_id tinyint

#cargo el idioma en id_idioma
select language_id into id_idioma
from language l
where l.name= idioma;

update film set original_language_id = id_idioma;
#----------------------------------

end; !