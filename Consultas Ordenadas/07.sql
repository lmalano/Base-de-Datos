# Comparacion de join con where en matcheo de tablas

select * from country,city #seleccionamos dos tablas
where city.country_id= country.country_id


select * from country co join city ci
on ci.country_id=co.country_id group by co.country_id