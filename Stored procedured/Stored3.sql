CREATE DEFINER=`root`@`localhost` PROCEDURE `Store3`(in s_first_name varchar(45), in s_last_name varchar(45), s_store_id tinyint(3), in s_film_id smallint(5), in s_staff_id tinyint(3))
BEGIN
	declare cant_customer tinyint(3);
    declare s_inventory_id smallint(5) default 0;
    declare s_customer_id smallint(5);
    declare s_amount double default 0;
    declare last_renta int;
    
    select count(cu.customer_id) into cant_customer
		from customer cu
        where cu.first_name = s_first_name
        and cu.last_name = s_last_name;
	
    select cu.customer_id into s_customer_id
		from customer cu
        where cu.first_name = s_first_name
        and cu.last_name = s_last_name
        limit 1; 
        
	select A.inventory_id into s_inventory_id from
    (select fi.film_id, inv.inventory_id, st.store_id, re.rental_id, re.return_date
		from film fi, inventory inv, rental re, store st
        where fi.film_id = inv.film_id
        and st.store_id = inv.store_id
        and inv.inventory_id = re.inventory_id
        and fi.film_id = s_film_id
        and st.store_id = s_store_id
        and inv.inventory_id not in
        (select inv.inventory_id
		from inventory inv, rental re
        where inv.inventory_id = re.inventory_id
        and re.return_date is null)
        group by inventory_id) as A
        limit 1;
	
    select rental_rate*rental_duration into s_amount
        from film
        where film_id = s_film_id;
        

	if cant_customer > 1  then
		select cu.customer_id as CUST_IDS
			from customer cu
            where cu.first_name = s_first_name
			and cu.last_name = s_last_name;
	elseif cant_customer = 0 then
		select "Cliente no registrado" as ERR;
	elseif s_inventory_id = 0 then
		select "NO DISPONIBLE" as ERR;
	else
		INSERT INTO `sakila`.`rental`
		(/*`rental_id`,*/
		`rental_date`,
		`inventory_id`,
		`customer_id`,
		/*`return_date`,*/
		`staff_id`-- ,
		/*`last_update`*/)
		VALUES
		(/*s_rental_id,*/
		current_date,
		s_inventory_id,
		s_customer_id,
		/*<{return_date: }>,*/
		s_staff_id-- ,
		/*<{last_update: CURRENT_TIMESTAMP}>*/);
		
        select rental_id as OK into last_renta
			from rental
            where rental_id = last_insert_id(); 
        
        INSERT INTO `sakila`.`payment`
		(/*`payment_id`,*/
		`customer_id`,
		`staff_id`,
		`rental_id`,
		`amount`,
		`payment_date`-- ,
		/*`last_update`*/)
		VALUES
		(/*<{payment_id: }>,*/
		s_customer_id,
		s_staff_id,
		last_renta,
		s_amount,
		now()-- ,
		/*<{last_update: CURRENT_TIMESTAMP}>*/);

		
    end if;    
-- VER QUE VALORES DEBERIA AGREGAR EN CUSTOMER_ID CUANDO HAY DOS CUSTOMER CON EL MISMO NOMBRE
END