#Seleccionar todos los clientes (apellido y nombre) cuyo pagos promedios historicos sean mayores que los pagos promedios de todos los clientes
select customer.first_name, customer.last_name, promedio from customer
	join (select avg(amount) promedio, payment.customer_id from payment
	group by customer_id having promedio > (select avg(amount) from payment))     
	promedios on customer.customer_id = promedios.customer_id
  
#otra forma
  select * from (
  select avg(amount) prom, first_name fn, last_name ln from customer cu
  join payment pa on pa.customer_id = cu.customer_id
  group by last_name
    ) a where a.prom >(select avg(amount) from payment)
