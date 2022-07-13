CREATE DEFINER=`root`@`localhost` PROCEDURE `Store5`(in s_film_id int, in s_customer_id int)
BEGIN
/*Construya un Store Procedure (SP) para dar de alta un nuevo alquiler, el SP recibirá el ID del film (no del inventario) 
y el ID del usuario. Controlará que el usuario no tenga un alquiler vencido no devuelto (1). 
Controlará que existan copias disponibles para ser alquiladas de ese film (2). 
Grabará automáticamente la fecha del momento de la transacción como fecha de alquiler. 
En caso de ser exitosa la operación deberá devolver una tabla de un registro y dos campos 
(“cod_res” y “mensaje”) que contendrá 0 para el primero y “Operación exitosa”. Si se produce el error (1) no grabara 
y devolverá 1 para el primero y “Usuario no habilitado” para el segundo. Si se produce el (2) no grabará y 
devolverá 2 para el primer campo y “Film no disponible” para el segundo. (nota: los datos representan un estado 
posible de los mismos, el SP deberá funcionar para cualquier estado de los datos. 
Si necesitara Ud. podrá modificarlos para probar distintas posibilidades).*/

declare cant_no_devueltas int;
declare s_inventory_id int default 0;

select count(cu.customer_id) into cant_no_devueltas
	from customer cu, rental re
    where cu.customer_id = re.customer_id
    and re.return_date is null
    and cu.customer_id = s_customer_id;
    
select A.inventory_id into s_inventory_id from        
(select fi.film_id, inv.inventory_id, re.rental_id, re.return_date
	from film fi, inventory inv, rental re
    where fi.film_id = inv.film_id
    and inv.inventory_id = re.inventory_id
    and fi.film_id = 4
    and inv.inventory_id not in
    (select inv.inventory_id
		from inventory inv, rental re
		where inv.inventory_id = re.inventory_id
        and re.return_date is null
        group by inv.inventory_id)
	group by inv.inventory_id) as A
    limit 1;
    
if cant_no_devueltas > 0 then
	select 1 as cod_res, "Usuario no habilitado" as mensaje;
elseif s_inventory_id = 0 then
	select 2 as cod_res, "Film no disponible" as mensaje;
else
	INSERT INTO `sakila`.`rental`
	(/*`rental_id`,*/
	`rental_date`,
	`inventory_id`,
	`customer_id`-- ,
	/*`return_date`,*/
	/*`staff_id`,*/
	/*`last_update`*/)
	VALUES
	(/*<{rental_id: }>,*/
	current_date,
	s_inventory_id,
	s_customer_id -- ,
	/*<{return_date: }>,*/
	/*<{staff_id: }>,*/
	/*<{last_update: CURRENT_TIMESTAMP}>*/);
end if;
END