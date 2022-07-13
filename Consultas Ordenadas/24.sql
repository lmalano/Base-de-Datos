# Staff, monto cobrado y el cliente que mas pago con su monto
/*Genere una consulta SQL sobre la base Sakila que retorne una tabla de 4 columnas que tenga 1 registro por cada "staff" con los campos:
. Apellido del Staff
. Monto total cobrado por el staff (campo amount de la tabla payment).
. Apellido del cliente que mas pagó a ese staff.
. Monto total que ese cliente pagó a ese staff.
El estado de los datos es uno de los posibles de la Base de Datos, la consulta debe funcionar cuelquiera sea el estado.*/
 
 select A.last_name as apellido_staff, A.monto_total, B.customer as cliente_pago_mas, B.monto_por_cliente as monto_pagado from
 (select st.staff_id, st.last_name, sum(pa.amount) as monto_total
	from staff st, payment pa
		where st.staff_id = pa.staff_id
        group by st.staff_id) as A,
 
(select * from       
(select st.staff_id, st.last_name, pa.payment_id, sum(pa.amount) as monto_por_cliente, cu.customer_id, cu.last_name as customer
	from staff st, payment pa, customer cu
		where st.staff_id = pa.staff_id
		and pa.customer_id = cu.customer_id
		group by cu.customer_id, st.staff_id
        order by monto_por_cliente desc) as A
        group by A.staff_id) as B
        
        where A.staff_id = B.staff_id;