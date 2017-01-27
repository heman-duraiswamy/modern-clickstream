select 
  l.ip, p.category, l.url, u.gender_cd gender, 
  CAST(datediff(from_unixtime(unix_timestamp()), from_unixtime(unix_timestamp(u.birth_dt,'dd-MMM-yy'))) / 365  AS INT) age, 
  l.city, l.state, l.country
from 
  weblogs l
  left outer join products p on l.url = p.url
  left outer join users u on l.swid = u.swid;
