#Cant de Alquileres y pagado por cliente, con su nombre, apellido, direccion ciudad y pais
    SELECT first_name Nombre , last_name Apellido , count(ALQUILERES.rental_id) Alquileres , sum(amount) Pagado , address Direccion , city Ciudad , country Pais
	FROM customer CLIENTE LEFT JOIN address DIRECCION
    ON CLIENTE.address_id = DIRECCION.address_id
    JOIN city CIUDAD
    ON DIRECCION.city_id = CIUDAD.city_id
    JOIN country PAIS
    ON CIUDAD.country_id = PAIS.country_id
    JOIN rental ALQUILERES
    ON CLIENTE.customer_id = ALQUILERES.customer_id
    JOIN payment PAGOS
    ON ALQUILERES.rental_id = PAGOS.rental_id
    GROUP BY CLIENTE.customer_id
    ORDER BY Ciudad , Pais
 
 #Cant de Alquileres y pagado por cliente, con su nombre, apellido, direccion ciudad y pais. Los que no son de Mayo va con 0 alquileres y 0 pagos
SELECT
NoMayo.Nombre , 
NoMayo.Apellido , 
if( isnull(Mayo.Alquileres) , 0 , Mayo.Alquileres ) Alquileres,
if( isnull(Mayo.Pagado) , 0 , Mayo.Pagado ) Pagado,
NoMayo.Direccion , 
NoMayo.Ciudad , 
NoMayo.Pais
	FROM
	( SELECT CLIENTE.customer_id id , first_name Nombre , last_name Apellido , count(PAGOS.payment_id) Alquileres , sum(amount) Pagado , address Direccion , city Ciudad , country Pais
		FROM customer CLIENTE LEFT JOIN address DIRECCION
		ON CLIENTE.address_id = DIRECCION.address_id
		JOIN city CIUDAD
		ON DIRECCION.city_id = CIUDAD.city_id
		JOIN country PAIS
		ON CIUDAD.country_id = PAIS.country_id
		JOIN rental ALQUILERES
		ON CLIENTE.customer_id = ALQUILERES.customer_id
		JOIN payment PAGOS
		ON ALQUILERES.rental_id = PAGOS.rental_id
		GROUP BY CLIENTE.customer_id
	  ORDER BY Ciudad , Pais ) NoMayo
    LEFT JOIN
	( SELECT CLIENTE.customer_id id , first_name Nombre , last_name Apellido , count(PAGOS.payment_id) Alquileres , sum(amount) Pagado , address Direccion , city Ciudad , country Pais
		FROM customer CLIENTE LEFT JOIN address DIRECCION
		ON CLIENTE.address_id = DIRECCION.address_id
		JOIN city CIUDAD
		ON DIRECCION.city_id = CIUDAD.city_id
		JOIN country PAIS
		ON CIUDAD.country_id = PAIS.country_id
		JOIN rental ALQUILERES
		ON CLIENTE.customer_id = ALQUILERES.customer_id
		AND month(ALQUILERES.rental_date) = 5 -- AGREGADA
		JOIN payment PAGOS
		ON ALQUILERES.rental_id = PAGOS.rental_id
		GROUP BY CLIENTE.customer_id
	  ORDER BY Ciudad , Pais ) Mayo
	ON NoMayo.id = Mayo.id
-- Para chequear sólo los que agregué: HAVING Alquileres = 0
