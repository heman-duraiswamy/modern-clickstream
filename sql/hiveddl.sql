set hive.cli.errors.ignore=true;

CREATE DATABASE IF NOT EXISTS clickstream;
USE clickstream;

DROP TABLE users;
CREATE EXTERNAL TABLE users 
(swid string, birth_dt string, gender_cd string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE 
LOCATION "/hdfs/location/to/users";

DROP TABLE products;
CREATE EXTERNAL TABLE products
(url string, category string) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE 
LOCATION "/hdfs/location/to/products";

DROP TABLE weblogs;
CREATE EXTERNAL TABLE 
  weblogs (
	id double, 
	ts string, 
	ip string, 
	url string, 
	purchase_flag int, 
	error_flag int, 
	swid string, 
	city string, 
	state string, 
	country string
  ) 
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS TEXTFILE
LOCATION "/hdfs/location/to/cleansed-click-data/";

drop view purchased_sessions;
create view purchased_sessions as
  select 
    id, ts, ip, url, swid, city, state, country
  from
    weblogs w
  where
    swid in (select distinct(swid) from weblogs l where l.purchase_flag=1);
