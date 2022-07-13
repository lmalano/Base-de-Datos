#Sobre la base de datos SAKILA programe un store procedure
#que reciba como parámetros los datos del pago junto a la devolución de un alquiler
#y que lo registre en las tablas correspondientes, 
#controlando que ni el pago ni la devolución hayan sido previamente registradas
#en cuyo caso no registrará nada. 

#tengo que registrar un pago, recibo la fecha del mismo, el pago y el id de rental
use sakila;

delimiter ! 

create procedure 2doparcial(in rental int, in amt int, in day date)

begin

declare renta int default null;
declare fecha date default null;
declare customer int;
declare staff int;
#debo usar rental, para chekear si existe una devolucion y una renta en pago. eso se usa en el if

#controlamos la devolucion
select return_date into fecha
from rental
where rental.rental_id= rental
limit 1;

#controlamos el pago, que se haya realizado
select rental_id into renta
from payment
where payment.rental_id=rental;

#si no se ha registrado un pago o devolucion de esa renta, debo obtener los valores para actualizar payment
#customer
#staff
#amount y day ya los tengo
if(fecha is null) and (renta is null) then

select customer_id into customer
from rental
where rental.rental_id=rental;


select staff_id into staff
from rental
where rental.rental_id=rental;

#actualizo que se hizo una devolucion en renta
update rental
set rental.return_date=day
where rental.rental_id=rental;

insert into payment(customer_id, staff_id, rental_id, amount, payment_date) 
values (customer, staff, rental, amt, day);
end if;

end; !



