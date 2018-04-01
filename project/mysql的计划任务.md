## Mysql  事件计划
### 查看是否开启事件 (如已开启事件 跳过配置项)
```
show variables like 'event%';
```
### 开启事件(测试用 重启失效 如部署使用->改配置)
```
SET GLOBAL event_scheduler = 1;
or
SET GLOBAL event_scheduler = ON;
```
### 开启事件(改配置)
```
更改my.ini下的[mysqld] 添加
event_scheduler = 1
```

### MySQL定时任务 (其他部署请注意sql语句)

```
创建一个测试表 (先自己玩玩,不要急 如果你可以 就直接创建事件)
DROP table IF EXISTS demo; 
CREATE TABLE demo (timeline TIMESTAMP );

//为测试表，创建定时任务（每天凌晨3点钟，插入数据） 
//测试就先删除一下事件 
DROP EVENT IF EXISTS event_update_reay; 

创建事件 每天0点执行事件

CREATE EVENT event_update_reay 
on schedule EVERY 1 DAY STARTS  '2018-04-01 00:00:00' 
do  UPDATE pub_devices_statu set ReDay=ReDay -1 ,SumDay=SumDay+1 ,data_statu=1 where ReDay>0;

CREATE EVENT event_update_filterday
on schedule EVERY 1 DAY STARTS  '2018-04-01 00:00:00' 
do  UPDATE pub_devices_statu set ReDayFilter1 = ReDayFilter1 - 1 ,ReDayFilter2 = ReDayFilter2 - 1 ,ReDayFilter3 = ReDayFilter3 - 1 ,ReDayFilter4 = ReDayFilter4 - 1 ,ReDayFilter5 = ReDayFilter5 - 1 ,data_statu=1;

CREATE EVENT event_update_tds
on schedule EVERY 1 DAY STARTS  '2018-04-01 12:00:00' 
do  INSERT INTO pub_tds (dcode, raw, pure,day,date) SELECT DeviceID,RawTDS,PureTDS,DATE_FORMAT(NOW(),'%d'),DATE_FORMAT(NOW(),'%Y%m') FROM pub_devices_statu where AliveStause = 1 and (RawTDS!=0 or PureTDS!=0) ;
```

