#Realizar un store procedure para insertar un nuevo cliente, donde se reciban los siguientes parámetros:

#· Apellido
#· Nombre
#· Id del Store (debe existir)
#· Email

#· Dirección SACAR
#· Distrito
#· Nombre de la ciudad
#· Nombre del país
#· Código postal
#· Teléfono

#Actualizar las tablas que correspondan.
#El SP deberá verificar que la ciudad exista (controlar por nombre y país, asuma que el país existe) 
#en caso de no existir la ciudad deberá crearla.

use sakila;

delimiter ! 

create procedure 1seg_cliente(in apellido varchar(45), in nombre varchar(45), in id_store tinyint,
in mail varchar(50), in direccion varchar(50), in districto varchar(20) , in ciudad varchar(50), in pais varchar(50),
in cp varchar(19), in telefono varchar(20))

begin

declare ciudad_aux int default null;
declare pais_aux smallint default null;
declare address_aux smallint  default null;


#controlo que la ciudad no exista
select city_id into ciudad_aux
from city c
where c.city= ciudad and c.country_id= pais_aux;

#si no existe esa ciudad, realizo la insercion en la tabla city
if ciudad_aux is null then
    begin
        select country_id into pais_aux 
        from country co
        where co.country =pais;
        
        insert into city (city, country_id) values (ciudad, paix_aux);
    end;
end if;


#actualizo tablas: address--------

#controlo que la ciudad no exista
select city_id into ciudad_aux
from city c
where c.city= ciudad and c.country_id= pais_aux;

insert into address(address,district , city_id, postal_code, phone)
values(direccion, districto, ciudad_aux, cp, telefono);

#----------------------------------

#actualizo tablas: customer-------

#debo obtener address_id
select address_id into address_aux
from address ad
where ad.address= direccion and ad.disctric= districto;

insert into customer (store_id,first_name,last_name, email, address_id, create_date)
values (id_store, nombre, apellido, mail, address_aux, now());
#----------------------------------


end; !