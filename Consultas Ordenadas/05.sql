#Recaudacion o pago total de cada staff
select  st.staff_id,sum(amount) from payment pa join staff st
on pa.staff_id=st.staff_id
group by st.staff_id 
