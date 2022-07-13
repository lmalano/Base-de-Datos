# Clientes con cant de alquileres del mes 5 y monto alquilado>10
select customer.customer_id ,  first_name nombre, last_name  apellido, address, city ciudad, country pais, count(rental.rental_id) alquileres, sum(amount) monto, rental_date, month(rental_date) from customer 
join address on address.address_id = customer.address_id
join city on city.city_id = address.city_id
join country on country.country_id = city.country_id
join rental on  rental.customer_id = customer.customer_id
join payment on  payment.rental_id =rental.rental_id
group by customer.customer_id  having ((month (rental_date) = 5) & (monto>10) )
order by country.country asc, city.city asc #esta linea es el ejericio 2

