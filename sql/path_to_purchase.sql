select 
  p.category
from
  purchased_sessions s
  left outer join products p on s.url = p.url
where
  s.url not like '%/product/%' and s.url != '/';
