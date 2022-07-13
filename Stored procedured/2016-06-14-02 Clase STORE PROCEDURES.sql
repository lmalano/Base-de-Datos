-- # STORE PROCEDURES
-- Sólo se puede guardar tablas de UNA columna en una variable

-- Ejemplo en JAVA: "SELECT * FROM ACTOR WHERE LAST_NAME="+formulario.apend.toString()
-- permitir esto implica un riesgo de seguridad grave, se implementa mejor:
-- "CALL LISTAACTOR("+formulario.apend.toString()")"
-- Esta función entonces se encargará de la seguridad, además de que no permitimos cualquier código
-- sino solo los que están precreados en algún Store Procedure (CALL)
-- Además los STORE PROCEDURE están precompilados, y por tanto optimizados, por lo que son más rápidos

-- Todos los Store Procedures dependen de la base de datos para los que fueron creados y por tanto
-- su código no puede ser directamente reutilizado en otras base de datosfilm_in_stockfilm_in_stock

-- Ejemplo que trae SAKILA:
CALL film_in_stock( 1 , 1 , @stock); -- @: variable local
SELECT @stock;
-- Un film puede tener varias copias, y esas copias pueden estar en diferentes
-- stroe (almacenes), con este código veo cuántas copias de un determinado
-- film hay en uno de los almacenes
SELECT * from inventory;

-- # FUNCIONES
-- Ejempld de FUNCION en SAKILA: (inventory_in_stock)
-- Como es una función nos permite hacer preguntas, ciclos, returns, etc
-- además se pueden hacer INSERT, UPDATES, etc

-- # TRIGGERS: Son como Store Procedures pero a nivel de tablas (se crea en la tabla)
-- En customer (pestaña TRIGGERS) se puede ver uno en BEFORE INSERT, el cual
-- se dispara siempre antes de hacer un insert a esa tabla

-- # Vistas: Views
-- Son SELECTs precompilados
-- Ejemplo de SAKILA actor_info
-- Son SELECT pre echos que se pueden usar como tablas
-- Como los Store Procedures al ser precompilados son más rápidos
-- Evita repetir SELECTs

-- # STORE PROCEDURE (MySQL 5.7 Reference Manual)
-- 	· REPEAT
-- 	· ITERATE
-- 	· LOOP
-- 	· LEAVE (como GOTO a una etiqueta)
-- 	· WHILE
-- 	· CASE
-- 	· IF - ELSEIF - THEN - END IF
-- 	· DELIMITER

-- Ejemplo:
-- Doy de alta una copia
DELIMITER $$
CREATE PROCEDURE ALTACOPIA(IN vidfilm int, in idstore int)
begin
	declare filmc int;
    select count(*) into filmc from film 
		where film_id = vidfilm;
	if filmc = 0 then
		select 'ERROR';
	else
		insert into inventory
			(film_id,store_id) values
            (vidfilm,idstore);
	end if;
end;
-- Esto crea ALTACOPIA en Store procedures (actualizar panel izq)

CALL ALTACOPIA( 1 , 1);
SELECT * from inventory

-- Se modifica el ALTACOPIA (ahora devuelve dos respuestas)