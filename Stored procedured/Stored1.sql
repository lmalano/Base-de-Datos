CREATE DEFINER=`root`@`localhost` PROCEDURE `Store1`(in s_last_name varchar(45), in s_first_name varchar(45), in s_email varchar(50), in s_username varchar(16), in s_password varchar(40), in s_address_id smallint(5), in s_store_id tinyint(3))
BEGIN
/*Construya un store procedure que permita el alta de un staff, los parámetros serán:
. Apellido
. Nombre
. Email
. Username
. Password
. Address_id
. Store_id
El SP debe verificar que tanto el "Address" como el "Store" existan. En caso contrario deberan retornar un mensaje 
"ADDNOEXISTE" o "STONOEXISTE" en la forma de una tabla de una fila y una columna. En caso de grabarse todo bien 
devolver el ID del staff generado, de la misma forma que los errores.*/
declare cant_address tinyint(3);
declare cant_store tinyint(3);

select count(address_id) into cant_address
	from address
    where address_id = s_address_id;
    
select count(store_id) into cant_store
	from store
    where store_id = s_store_id;

if cant_address = 0 then
	select "ADDNOEXISTE" as err;
elseif cant_store = 0 then
	select "STONOEXISTE" as err;
else
	INSERT INTO `sakila`.`staff`
	(`first_name`,
	`last_name`,
	`address_id`,
	`email`,
	`store_id`,
	`username`,
	`password`)
	VALUES
	(s_first_name,
	s_last_name,
	s_address_id,
	s_email,
	s_store_id,
	s_username,
	s_password);
    
	select max(staff_id) as op_exitosa
		from staff;
    
END if;
END