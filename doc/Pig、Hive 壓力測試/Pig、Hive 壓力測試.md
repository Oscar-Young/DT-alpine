# 計算六都兒童口罩各數
=======================================

Pig
-----------------------------------

data = load '/user/user01/01-04-2020-18-14.csv' using PigStorage(',')as(code:chararray,name:chararray,address:chararray,phone:chararray,adult:int,kid:int,time:chararray);

f = filter data by $2 MATCHES '(臺北市|新北市|桃園市|臺中市|臺南市|高雄市).*';

g = foreach f generate SUBSTRING($2,0,3),$5;

h = group g by $0;

i = foreach h generate $0,SUM(g.kid);

dump i;

-------------------------------------

一人連線

| 六都兒童口罩各數 | 1 | 2 | 3 | 4 | 5 | 平均 |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| Tez | 55.389s | 55.272s | 57.463s | 56.322s | 55.189s | 55.927s |



----十人連線----
150.674
156.319
157.022
160.242
202.726
206.308
206.311
207.956
251.695
251.519
----------------
平均:195.0772
----------------

Hive

SELECT col1,col2 FROM 
(SELECT SUBSTR(address,1,3) AS col1 ,SUM(kid) AS col2 FROM mask01 GROUP BY SUBSTR(address,1,3))
 AS step1 WHERE col1 LIKE '臺北市%' or col1 like'新北市%' or col1 like'桃園市%' or col1 like'臺中市%' or col1 like'臺南市%' or col1 like'高雄市%';

----一人連線----
86.958
88.561
87.563
86.988
87.114
----------------
平均:87.4368
----------------

----十人連線----
336.376
338.423
340.071
341.314
341.660
341.900
342.602
341.744
363.369
365.823
----------------
平均:345.3282
----------------


