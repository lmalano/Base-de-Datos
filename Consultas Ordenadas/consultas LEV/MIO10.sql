SELECT cu.customer_id, cu.first_name, cu.last_name FROM customer cu
JOIN rental re on re.customer_id=cu.customer_id 
WHERE (ISNULL(return_date));
