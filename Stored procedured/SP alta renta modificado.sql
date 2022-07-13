PROCEDURE `altarenta`(invid int,cliid int,staffid int)
BEGIN

declare cant int;
select count(*) into cant from rental 
where inventory_id = invid and is null(return_date); # cuanto cantidad de copias no devueltas

select count(*) into cant1 from rental 
where inventory_id = invid and is not null(return_date); #cuento cant de copias devuentas y en stock actualmente

 #si hago cant > 0 hay copias no devueltas, pero tmp me dice si hay copias disponibles, x eso prefiero saber si esa cant de copias dispon es 0
 
if cant1==0  then
select "ERROR, figura alquilada";
else
insert into rental (rental_date,inventory_id,customer_id,staff_id) values (now(),invid,cliid,staffid);
select last_insert_id();
end if;

END