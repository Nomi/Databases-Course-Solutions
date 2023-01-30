USE EngineDB
--My code is very clumsy because I realized after doing all of this that I had  an error when I was writing this that said something about external references 
--and realized just now, after finsihing this since my mind is clear, that I could've used that in a lot of places to make it more efficient/pretty
--Note to self: LEARN GROUP BY, EXTERNAL REFERENCES, AND JOIN PROPERLY.
--Note to self: Also, using Group by [all the columns] without aggregates can fix issues where there are multiple records (but you didn't intend it to be)

--1.	Prepare a report which will show all engines for which there was no failures ever reported by any of the sensors		--My earlier answer was wrong.
update Sensors set Total_Registered_Failures=0 where Engine_Serial=8; --To help test if this works as my values were already 0 (I assumed this)
select * from Engines 
where NOT EXISTS
(select Engine_Serial from Sensors where Sensors.Engine_Serial=Engines.Engine_Serial
and Sensors.Total_Registered_Failures>0)
--The number of errors are not nullable (0 by default) that's why we don't need to consider that. Otherwise we could have to use IS NULL also.


--2.	Prepare a report where for each of the sensors category there will be shown average number of failures reported by sensors belonging to this category 
--remember the AVG function will ignore nulls automatically
select Sensor_Catgories.Category_Name ,
AVG(CAST(Sensors.Total_Registered_Failures AS DECIMAL(10,2))) AS 'Average Failures' 
from Sensor_Catgories join Sensors 
ON Sensor_Catgories.Category_ID=Sensors.Category_ID group by Category_Name
--the cast ensures that e.g.) instead of getting only 44.0 we get the accurate/real value 44.6


--3.	Prepare a report which will identify an engine which sensor reported maximal total number of failures compared with total number of failures reported by individual sensors
--first part only answered half of the question
--select TOP(1) AVG(Engines.Engine_Serial) as EngSer,
--sum(Sensors.Total_Registered_Failures) AS sumofFailures 
--from Sensors,Engines where Sensors.Engine_Serial=Engines.Engine_Serial group by Engines.Engine_Serial order by sumofFailures desc
select Engines.*,Sensors.Sensor_Serial,Sensors.Category_ID,Sensors.Measurement_Value --Earlier answer was wrong
from Engines right join Sensors on Engines.Engine_Serial IN 
(select TOP(1) Engines.Engine_Serial as EngSer from Engines,Sensors
where Sensors.Engine_Serial=Engines.Engine_Serial 
group by Engines.Engine_Serial 
order by sum(Sensors.Total_Registered_Failures) desc)
where Engines.Engine_Serial=Sensors.Engine_Serial

--4.	Prepare a report showing engines with average vibration readings significantly above (50% greater) compared to the average vibration readings
select * from Engines RIGHT JOIN
(select Sensors.Engine_Serial,AVG(Sensors.Measurement_Value) as avgmv 
from Sensors GROUP BY Sensors.Engine_Serial,Category_ID HAVING 
(avg(Sensors.Measurement_Value)>(select 1.5*AVG(Sensors.Measurement_Value) from Sensors where Sensors.Category_ID='vibr')) --the first Sensors.Measurement value
and																			-- is an external reference the second one is not due to the from in the subquery
Sensors.Category_ID='vibr') AS Sens  --Also, Alias was neccessary (AS Sens, it wouldn't work until then) maybe because of ambiguity with the external reference
ON Engines.Engine_Serial=Sens.Engine_Serial;


















--5.	Identify an engine for which maximum readings  of any sensor has never exceeded average reading for this sensor category (i.e. max temp for an engine has never exceeded average readings from all sensors in temp. category and similar condition for vibration, and others depending on how many sensors an engine may have)

--the following value is inserted to help test the function
insert Sensors values 
(100, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 100000000000, 'online', 12000000, 'ok', 1, 'tmpr')
--actual solution begins
Select Engines.* 
from Engines,
(Select  tab1.Engine_Serial, count(tab1.Category_ID) as countcid from
Engines INNER JOIN
(select tb1.Engine_Serial,tb1.Category_ID from
(select Sensors.Engine_Serial, Sensors.Category_ID, MAX(Sensors.Measurement_Value) as maxmv from Sensors group by Sensors.Engine_Serial,Sensors.Category_ID) as tb1
INNER JOIN 
(select Sensors.Category_ID, AVG(Sensors.Measurement_Value) as avgmvall from Sensors group by Sensors.Category_ID) as tb2
ON
(tb2.Category_ID=tb1.Category_ID and maxmv<avgmvall)) as tab1
ON(tab1.Engine_Serial=Engines.Engine_Serial)
group by tab1.Engine_Serial
having count(tab1.Category_ID)>=3) AS Table1
where(Engines.Engine_Serial=Table1.Engine_Serial)
--deleting the value previously inserted to test this
delete Sensors where Sensors.Sensor_Serial=100;


GO







--================TRASHBIN:===========================


-- select Sensors.Category_ID, MAX(Sensors.Measurement_Value) as AverageOverall from Sensors group by Sensors.Category_ID --(for part5)

--[PART 5] FULLY WORKING PROGRAM WHICH ALMOST DOES IT BUT THEN I REREAD THE QUESTION AND TURNSOUT I NEED TO DO JUST A LITTLE BIT MORE (WORKS ONLY FOR EACH SENSOR, NOT ALL SENSORS)
--Select Engines.*,tab1.Category_ID as SensorCategory, tab1.maxmv as maxval from 
--Engines INNER JOIN
--(select tb1.Engine_Serial,tb1.Category_ID,tb1.maxmv from
--(select Sensors.Engine_Serial, Sensors.Category_ID, MAX(Sensors.Measurement_Value) as maxmv from Sensors group by Sensors.Engine_Serial,Sensors.Category_ID) as tb1
--INNER JOIN 
--(select Sensors.Category_ID, AVG(Sensors.Measurement_Value) as avgmvall from Sensors group by Sensors.Category_ID) as tb2
--ON
--(tb2.Category_ID=tb1.Category_ID and maxmv<avgmvall)) as tab1
--ON(tab1.Engine_Serial=Engines.Engine_Serial)

--[PART 5] OVERKILL PROGRAM (WORKS!) THIS ONE FINDS ALL THE ENGINES FOR WHICH ALL SENSORS ARE BELOW AVERAGE READINGS
--Select Engines.* 
--from Engines,
--(Select  tab1.Engine_Serial, count(tab1.Category_ID) as countcid from
--Engines INNER JOIN
--(select tb1.Engine_Serial,tb1.Category_ID from
--(select Sensors.Engine_Serial, Sensors.Category_ID, MAX(Sensors.Measurement_Value) as maxmv from Sensors group by Sensors.Engine_Serial,Sensors.Category_ID) as tb1
--INNER JOIN 
--(select Sensors.Category_ID, AVG(Sensors.Measurement_Value) as avgmvall from Sensors group by Sensors.Category_ID) as tb2
--ON
--(tb2.Category_ID=tb1.Category_ID and maxmv<avgmvall)) as tab1
--ON(tab1.Engine_Serial=Engines.Engine_Serial)
--group by tab1.Engine_Serial
--having count(tab1.Category_ID)>=3) AS Table1
--where(Engines.Engine_Serial=Table1.Engine_Serial)













--select *
--from
--(
--Select Engines.*,tab1.Category_ID as SensorCategory, tab1.maxmv as maxval from 
--Engines INNER JOIN
--(select tb1.Engine_Serial,tb1.Category_ID,tb1.maxmv from
--(select Sensors.Engine_Serial, Sensors.Category_ID, MAX(Sensors.Measurement_Value) as maxmv from Sensors group by Sensors.Engine_Serial,Sensors.Category_ID) as tb1
--INNER JOIN 
--(select Sensors.Category_ID, AVG(Sensors.Measurement_Value) as avgmvall from Sensors group by Sensors.Category_ID) as tb2
--ON
--(tb2.Category_ID=tb1.Category_ID and maxmv<avgmvall)) as tab1
--ON(tab1.Engine_Serial=Engines.Engine_Serial)
--) AS Table1
--HAVING (table.Engine_Serial=Engines.Engine_Serial) and exists ((select count(tab1.Engine_Serial) as counteng group by tab1.Engine_Serial having tab1.Engine_Serial=Engines.Engine_Serial and counteng=3))


--select tb1.Engine_Serial from
--(select Sensors.Engine_Serial, Sensors.Category_ID, MAX(Sensors.Measurement_Value) as maxmv from Sensors group by Sensors.Engine_Serial,Sensors.Category_ID) as tb1
--INNER JOIN 
--(select Sensors.Category_ID, AVG(Sensors.Measurement_Value) as avgmvall from Sensors group by Sensors.Category_ID) as tb2
--ON
--(tb2.Category_ID=tb1.Category_ID and maxmv>avgmvall)


--Why does the following not work
--USING(Category_ID)








