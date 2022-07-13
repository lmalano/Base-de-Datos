# DDL create table etc
# DML INSERT UPDATE etc
# 	  SELECT: La más importante (engloba)
#			  Tiene una inspiración en lo que es el álgebra relacional
#			  Es un lenguaje no procedural, es más de especificación, osea no digo como quiero las cosas
#				sino lo que quiero. Describo los datos que quiero. Defino los conjuntos que quiero tener: hay
#			  	mucha lógica de conjuntos y hay mucha lógica de predicados, unir todas estas lógicas es la
#				idea del SELECT
#				La lógica final es pedir un conjunto sin pensar en el procedimiento de obtención
#
# Se puede rendir con el manual de funciones de MySQL
#
# EJEMPLOS DE SELECT: (Para ejecutar sólo uno seleccionar el código a ejecutar)
#
# Más sencillo:

SELECT 'HOLA MUNDO' # Selecciono una constante (como es constante no depende de la BD)

# Los SELECT retornan tablas, sólo tablas

# Constante en una columna:

SELECT 'HOLA MUNDO' PEPE

SELECT 'HOLA MUNDO' AS PEPE

# Dos constantes en dos columnas:

SELECT 'HOLA MUNDO' AS PEPE, 'QUE TAL' PIPO

# Seleccionar de una tabla (mal):

SELECT city # Arroja error porque no dice de que tabla

# Seleccionar de una tabla:

SELECT city FROM city # SELECT (columna) FROM (tabla)

# Lo anterior funciona porque tengo sakila como defecto, sino puedo especificar más:

SELECT sakila.city.city FROM sakila.city

# Alias para una tabla:

SELECT sakila.ciudad.city FROM city ciudad # SELECT (BD).(AliasTabla).(Columna) FROM (Columna) (AliasQueLeDoy)

### Los ENTER, ESPACIOS, etc no me influyen en el código (puedo dar el formato que se me cante)

# Elegir más de un campo:

SELECT city,country_id FROM city

# Elegir todos:

SELECT * FROM city

# Funciones de agregación:
# count:

SELECT count(*) FROM city # Cuenta la cantidad de filas (que hubiese devuelto dicho SELECT)
SELECT count(*) FROM country # Cuenta la cantidad de filas (que hubiese devuelto dicho SELECT)

	# count con alias:
    SELECT count(*) contador FROM city

# SELECT de dos tablas:

SELECT * FROM country,city # Tabla con todas las combinaciones posibles de las tuplas de country con las de city

# Eso no sirve, pero si filtramos los country_id que combinan obtenemos dónde se matchean los ID:

# Condición WHERE:

SELECT * # Todos los datos de:
	FROM country co , city ci # Las tablas esas combinadas (toda combinación posible)
		WHERE co.country_id = ci.country_id # Sólo las que coincidan los country_id

# Lo mismo sólo con dos datos:

SELECT city,country # Todos los datos de:
	FROM country co , city ci # Las tablas esas combinadas (toda combinación posible)
		WHERE co.country_id = ci.country_id # Sólo las que coincidan los country_id	

# Cláusula JOIN-ON:

SELECT city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id	
# Mismo resultado que el WHERE (JOIN tiene mayor aplicación)

### MUYSUCULAS O MINUSCULAS DAN IGUAL

# JOIN anidados:

SELECT city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
#Lo anterior devuelve las ciudades y países de todas las addres existentes

SELECT count(*) cuenta FROM address

# Agregando address:
SELECT address,city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id

# Lo mismo pero con WHERE:
SELECT address,city,country # Todos los datos de:
	FROM country co , city ci , address ad # Las tablas esas combinadas (toda combinación posible)
		WHERE co.country_id = ci.country_id # Sólo las que coincidan los country_id
        AND ad.city_id = ci.city_id

# like:
SELECT address,city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE city like '%a' # Todas las ciudades que terminen con a

# like:
SELECT address,city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE city like 'a%' # Todas las ciudades que empiezan con a
# % -> ningún o cualquier cadena de caracteres

# not:
SELECT address,city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE not city like 'a%' # Todas las ciudades que NO empiezan con a
    
# Puedo usar columnas que NO están en el SELECT:
SELECT address,city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE co.country_id = 34
    
# Puedo hacer operaciones, llamar funciones, etc:
SELECT address,city,country # Todos los datos de:
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE co.country_id = 34+23

### Tener cuidado con las juntas, puedo eliminar datos que supongo que están.
### Por ejemplo hay ciudades que no son apuntadas por nunguna address, lo que no aparrecerán si las listo

# Función de agregación:
# distinct:

SELECT distinct(country) # Elimina los repetidos
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE co.country_id = 34
    
# Una forma mala de usarlo:

SELECT distinct(country) , city # Elimina los repetidos
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE co.country_id = 34
    
# Forma correcta de usarlo:

SELECT distinct country , city # Como predicado para más de uno
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	WHERE co.country_id = 34

# Otro ejemplo:
SELECT Distinct city # Como predicado para más de uno
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
# Baja de 600 a 599, por lo que hay una ciudad no apuntada por nadie

# Address me mata una ciudad:
SELECT country , city
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id

# Para que address no me mate una ciudad:
SELECT country , city
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        LEFT JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id

# Para encontrar el de la discordia:
SELECT *
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        LEFT JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
        WHERE ISNULL(ad.city_id)

# Entonces en el siguiente (repetido) tienen que estar todas las ciudades:
SELECT *
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        LEFT JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id

# Order by:
SELECT country , city
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        LEFT JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	ORDER BY city # Se aplica después del where y ordena de acuerdo al campo que le pido (o una explesión)

# Es por defecto ascendente puedo ponerlo descendente:
SELECT country , city
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        LEFT JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	ORDER BY city DESC

# Puedo combinar:
SELECT country , city
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
        LEFT JOIN address ad # Se une con city
        ON ad.city_id = ci.city_id
	ORDER BY city DESC ,  country ASC # Primero ordena city (descendente) y si un city se repite ordena los
										# country de ese city (en forma ascendente)

# Cláusula de agrupamiento GROUP BY (complicada):
# Nos permite agrupar por valores comunes:

SELECT country , city
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
	group by
		co.country_id # Muestra sólo un registro por cada co.country_id
# En este caso no sirve

# Sirve para funciones de agregación:
SELECT country País , count(city) Cantidad_de_ciudades
	FROM country co JOIN city ci # Las tablas esas combinadas (toda combinación posible)
		ON co.country_id = ci.country_id # Sólo las que coincidan los country_id
	group by
		co.country_id # Muestra sólo un registro por cada co.country_id

# Otro ejemplo (Total vendido por cada staff):

SELECT staff_id , sum(amount) Total_cobrado FROM payment
GROUP BY staff_id
ORDER BY Total_cobrado DESC

# Lo mismo que antes pero sólo en Mayo:

SELECT staff_id , sum(amount) Total_cobrado FROM payment
WHERE month(payment_date) = 5
GROUP BY staff_id
ORDER BY Total_cobrado DESC

# Filtro sobre filtro:
# HAVING:

SELECT staff_id , sum(amount) Total_cobrado FROM payment
WHERE month(payment_date) = 5
GROUP BY staff_id
HAVING sum(amount) > 2500  # Es un post procesamiento, cuando ya obtuve la tabla
ORDER BY Total_cobrado DESC # El ORDER BY va siempre al último (no puede ir antes del HAVING)
# No se podía con el WHERE porque este actúa con el JOIN y no después del GOUP BY como el HAVING
# Por tanto no puedo usar el HAVING para columnas que no están en la tabla resultante (parcialmente)
# SOLO SE PUEDE USAR UN HAVING (por su naturaleza)
# Posee algunas restricciones en las subconsultas (depende de cada motor)

