#Obtener por tienda, mes y año, un listado de la cantidad de clientes distintos que pagaron alquileres

select  count(distinct cu.customer_id) cuenta, cu.first_name nombre, cu.last_name apellido, month(p.payment_date) mes,
year(p.payment_date) año, s.store_id tienda
from payment p
join customer cu
on p.customer_id =  cu.customer_id
join store s
on s.store_id= cu.store_id
group by tienda, mes, año
order by cuenta asc;