# Clientes del pais 44 que gastaron mas que todos del 23
 SELECT 
    cu.customer_id, SUM(pa.amount) AS gasto
FROM
    payment AS pa
        JOIN
    customer AS cu ON pa.customer_id = cu.customer_id
        JOIN
    address AS ad ON cu.address_id = ad.address_id
        JOIN
    city AS ci ON ad.city_id = ci.city_id
WHERE
    ci.country_id = 44
GROUP BY cu.customer_id
HAVING gasto > ALL (SELECT 
        SUM(pa.amount) AS gasto2
    FROM
        payment AS pa
            JOIN
        customer AS cu ON pa.customer_id = cu.customer_id
            JOIN
        address AS ad ON cu.address_id = ad.address_id
            JOIN
        city AS ci ON ad.city_id = ci.city_id
    WHERE
        ci.country_id = 23
    GROUP BY cu.customer_id)
ORDER BY gasto DESC