SELECT count(*), date(re.return_date) FROM  rental re
group by date(re.return_date)



