/*Implemente una consulta que retorne un listado referido al stock de copias de los films en las tiendas (store) al momento de la emisión del listado.
 El listado tendrá 4 columnas: “TÍTULO_FILM”, “NRO_STORE”, “DISPONIBLE”, “PRESTADO”. 
 Un registro por cada combinación film y store siempre y cuando existan copias registradas de ese film en ese store (prestadas o no). No deberá haber registros con DISPONIBLE y PRESTADO ambos en cero.
La columnas tendran la siguiente información:
TÍTULO_FILM: Nombre del titulo del film.
NRO_STORE: Número identificatorio del store.
DISPONIBLE: Cantidad de copias de ese film disponibles (no prestados) en ese store.
PRESTADO: Cantidad de copias de ese film prestadas en ese store.*/

select A.film_id, A.title, A.store_id, A.disponibles, B.prestados from
(select A.film_id, A.title, A.store_id, count(A.disponibilidad) as disponibles from
(select fi.film_id, fi.title, st.store_id, re.rental_id, inv.inventory_id,
	case
		when(re.return_date is NULL)
			then "prestado"
            else "disponible"
		end as disponibilidad
	from film fi, inventory inv, rental re, store st
    where fi.film_id = inv.film_id
    and inv.store_id = st.store_id
    and inv.inventory_id = re.inventory_id) as A
    where A.disponibilidad = "disponible"
    group by A.film_id, A.store_id) as A left join #si sacamos el join, no se muestran las pelis no alquiladas

(select A.film_id, A.title, A.store_id, count(A.disponibilidad) as prestados from
(select fi.film_id, fi.title, st.store_id, re.rental_id, inv.inventory_id,
	case
		when(re.return_date is NULL)
			then "prestado"
            else "disponible"
		end as disponibilidad
	from film fi, inventory inv, rental re, store st
    where fi.film_id = inv.film_id
    and inv.store_id = st.store_id
    and inv.inventory_id = re.inventory_id) as A
    where A.disponibilidad = "prestado"
    group by A.film_id, A.store_id) as B
    on A.film_id = B.film_id;
    