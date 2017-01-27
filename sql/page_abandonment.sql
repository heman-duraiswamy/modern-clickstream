SELECT url FROM
   (SELECT *, RANK() over (partition by swid order by id desc) as rank      
FROM weblogs) weblogs
where swid not in (select distinct swid from purchased_sessions) and rank=1 and purchase_flag!=1;
