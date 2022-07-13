#Realizar una consulta que genere un reporte de la perfomance de cada tienda (store), empleado y film por cada combinación válida de estos tres 
#(tener en cuenta que un empleado sólo trabaja en una tienda). indicar cuanto se recaudó y cuantos alquileres se realizaron. 
#si para una combinación válida de tienda, empleado y film no se registran alquileres y/o recaudación se deberá poner 0, no se admitirá null.
select fistosta.film_id, fistosta.store_id, fistosta.staff_id, 
count(distinct re.rental_id),ifnull(sum(amount),0 )recaudacion from 
(
  select fi.film_id, stosta.store_id, stosta.staff_id
   from film fi,
    (
    select sto.store_id,sta.staff_id 
      from store sto join staff sta on 
      sto.store_id = sta.store_id
) stosta ) 
fistosta
left join inventory inv on inv.film_id = fistosta.film_id and inv.store_id = fistosta.store_id
left join rental re on re.inventory_id = inv.inventory_id and fistosta.staff_id = re.staff_id
left join payment pay on pay.rental_id = re.rental_id
group by fistosta.film_id, fistosta.store_id, fistosta.staff_id;
