#ganancia por mes y año de cada store
select store.store_id, sum(amount), month(rental_date) as mes, year(rental_date) as year
from staff, store, payment, rental
where payment.staff_id = staff.staff_id
    and staff.store_id = store.store_id
    and payment.rental_id = rental.rental_id
group by mes, year, store.store_id