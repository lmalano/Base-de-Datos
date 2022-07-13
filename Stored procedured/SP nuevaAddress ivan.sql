CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevaAddress`(in clienteId int, in direccion varchar(50), in direccion2 varchar(50), in distrito varchar(20), in ciudadId smallint(5), in codigoPostal varchar(10), in telefono varchar(20))
BEGIN
		declare idNueva int;
        declare idVieja int;
        declare idEnUso int default 0;
        declare clienteExiste int default 0;
        
        
		insert into address (address, address2, district, city_id, postal_code, phone, location)
				values(direccion, direccion2, distrito, ciudadId, codigoPostal, telefono, ST_GeomFromText('POINT(129.72278510000001 33.1591726)'));
                
		select count(*) into clienteExiste from customer where customer_id = clienteId;
        
        if clienteExiste then
				select max(address_id) into idNueva from address;
				select address_id into idVieja from customer where customer_id = clienteId;
				update customer set address_id = idNueva where customer_id = clienteId;
				select count(*) into idEnUso from customer where address_id = idVieja ;
				
				if not idEnUso then
					select 'Eliminar registro en address' Mensaje;
                    delete from address where address_id = idVieja;
				else
					select 'No se puede eliminar registro en address' Mensaje;
				end if;
        else
				select 'ERR-1' Mensaje;
		end if;
END