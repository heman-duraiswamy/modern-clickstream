select gender,age from 
  (select distinct(swid) from weblogs) a 
join 
  (select swid, gender_cd gender, CAST(datediff(from_unixtime(unix_timestamp()), from_unixtime(unix_timestamp(birth_dt,'dd-MMM-yy'))) / 365  AS INT) age from users where gender_cd!='U') b
on 
  a.swid = b.swid;
