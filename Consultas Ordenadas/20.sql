#consultar las ciudades que alquilaron peliculas en mas que el promedio de todas

select ci.city_id, ci.city, cant_ciudad
from city ci join
(
select city_id, count(*) cant_ciudad
from address ad 
    join (
    select c.customer_id, c.address_id
    from rental r join customer c
    on r.customer_id = c.customer_id
         ) tabla1
on ad.address_id = tabla1.address_id
group by ad.city_id
) tabla2
on ci.city_id = tabla2.city_id

having (
select avg(cantidad) promedio
from city join
(
select city_id, count(*) cantidad
from address ad 
    join (
    select c.customer_id, c.address_id
    from rental r join customer c
    on r.customer_id = c.customer_id
         ) tabla1
on ad.address_id = tabla1.address_id
group by ad.city_id
) tabla2
on city.city_id = tabla2.city_id
) <= cant_ciudad


#1- buscar todos los alquileres que hicieron los clientes y sus direcciones con la union
# de la tabla customer con rental, eso se llama tabla 1
#2- una vez que tengo las direcciones, uno esa tabla con address, que contiene las ciudades
# entonces ahi tengo las ciudades que alquilaron
# 3- si agrupo por ciudad, y hago la cuenta, obtengo la cantidad de alquileres por ciudad

#4- para sacar el promedio, hago la union de tabla 2 con city.
# tabla2 contiene el id de ciudad y que cantidad se alquilo en cada una
#5- entonces haciendo esa consulta anidada puedo sacar el promedio total de las cantidades de peliculas
# alquiladas por ciudad, y de paso hago el join.

#-6 una vez que tengo el promedio, puedo hacer la comparacion en un having
# que se hace con el promedio obtenido y comparando ciudad a ciudad la cantidad
# que es todo el chorizo de arriba antes del having( eso da la cantidad  que se llama cant_ciudad)
# entonces en el habing comparo aquellas cantidades que sean mayores que el super promedio que 
# se saca dentro del having



#consulta clase:
#consultar las ciudades que alquilaron peliculas en mas que el promedio de todas
