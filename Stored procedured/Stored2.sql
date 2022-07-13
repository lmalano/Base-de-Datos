CREATE DEFINER=`root`@`localhost` PROCEDURE `Store2`(in sourceStaff_id tinyint(3), in targetStaff_id tinyint(3), in mes int, in año int)
BEGIN
/*Sobre la base de datos SAKILA programe un store procedure que asigne las rentas registradas y los pagos recibidos por un staff 
a otro staff en un determinado mes y año. El SP se llamará ChangeStaffActions. El SP recibirá los parámetros: 
sourceStaff_id, targetStaff_id, month y year. Controlar que sourceStaff_id y targetStaff_id no sean iguales y que 
AMBOS existan en la tabla staff, en alguno de esos casos el SP devolvera una sola tabla con una columna "ERR" y un registro con el valor -1 en ese campo.
Los datos actuales son un ejemplo de un estado posible de la información, el SP debe funcionar correctamente en cualquier estado de datos.*/
	declare cant_sourc tinyint(3);
    declare cant_target tinyint(3);
    
    select count(staff_id) into cant_sourc
		from staff
        where staff_id = sourceStaff_id;
	
    select count(staff_id) into cant_target
		from staff
        where staff_id = targetStaff_id;
    
    if sourceStaff_id = targetStaff_id then
		select -1 as err;
	elseif cant_sourc = 0 then
		select -1 as err;
	elseif cant_target = 0 then
		select -1 as err;
	else
		UPDATE `sakila`.`rental`
		SET
		`staff_id` = sourceStaff_id
		WHERE month(rental_date) = mes
        AND year(rental_date) = año
        AND staff_id = targetStaff_id;
	end if;
END