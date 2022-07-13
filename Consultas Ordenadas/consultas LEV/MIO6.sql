#no existe pelicula con 3 categorias, agrupa x pelicula xq se supone q una pelicula puede tener mas de 1 categoria y eso implicaria mas de 1 registro
SELECT film_id FROM film_category
GROUP BY film_id
HAVING (COUNT(*) > 3)

        
        