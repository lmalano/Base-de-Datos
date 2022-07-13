select cu.customer_id, cu.first_name,cu.last_name, datediff(now(),date(re.rental_date)) from customer cu
join rental re on re.customer_id=cu.customer_id
join inventory inv on inv.inventory_id=re.inventory_id
where ISNULL(return_date)
