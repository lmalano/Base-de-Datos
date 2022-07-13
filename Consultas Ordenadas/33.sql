#Apellido y Nombre adel actor,	Cantidad de Alquileres Totales	, Monto Pagado Total,	Cantidad de alquileres no devueltos y Fecha Ultimo Alquiler
select 
last_name Apellido, first_name Nombre,
count(*) as alquileres,count(*)-count(return_date) as NoDevueltos,
max(rental_date) FechaUltimoAlquiler, sum(amount) MontoAbonado

from rental left outer join payment
on rental.rental_id = payment.rental_id
join customer on rental.customer_id=customer.customer_id
group by customer.customer_id
