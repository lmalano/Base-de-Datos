# Agrupo suma total recaudada por staff por año
select sum(amount) monto ,staff_id empleado,year(payment_date) año
from payment
group by year(payment_date),staff_id

