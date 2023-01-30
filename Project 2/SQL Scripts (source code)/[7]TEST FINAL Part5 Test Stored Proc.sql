USE EngineDB
--helper queries to be able to test the stored proc:
update Sensors set Sensor_Health_Status='FAILURE' where Engine_Serial=8 and not Category_ID='tmpr'
update Sensors set Measurement_Value= 120000000 where Engine_Serial=8
update Sensors set Measurement_DateAndTime=GETUTCDATE() where Engine_Serial=8
update Sensors set Sensor_Health_Status='FAILURE' where Engine_Serial=10 --and not Category_ID='tmpr'
update Sensors set Measurement_Value= 120000000 where Engine_Serial=10
update Sensors set Measurement_DateAndTime=GETUTCDATE() where Engine_Serial=10
update Sensors set Total_Registered_Failures=0 where Engine_Serial=10
--executing stored proc:
exec dbo.spEnginesHealthMetrics_UpdateAllEngines


--SELECT Sensor_Serial FROM SENSORS WHERE ((Category_ID IN (SELECT Category_ID FROM Sensors WHERE Sensor_Serial=10) AND (Sensor_Serial!=10) AND (Measurement_Value IS NOT NULL)) and Engine_Serial=(SELECT Engine_Serial FROM Sensors WHERE Sensor_Serial=10))


--SELECT Sensor_Serial FROM SENSORS WHERE ((Category_ID IN (SELECT Category_ID FROM Sensors WHERE Sensor_Serial=@Sensor_Serial) AND (Sensor_Serial!=10) AND (Measurement_Value IS NOT NULL)) and Engine_Serial=(SELECT Engine_Serial FROM Sensors WHERE Sensor_Serial=@Sensor_Serial))		--THIS CHECKS IF THE SNESOR IS THE ONLY ONE OF IT'S KIND AND IF ANY OF THOSE DON'T HAVE NULL VALUES (Because otherewise the compared averages would always be equal. We could also fix it by letting all sensors have Measurment_Value=0 and the column not null constrained in the beginning. This way, it's almost as if the average is  because the average check will be skipped

--select DATEDIFF(SECOND,(SELECT Measurement_DateAndTime FROM Sensors WHERE Sensors.Sensor_Serial=10),GETUTCDATE())

--=====TEST FUNCTIONS=====--
--SELECT num_overheat_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=10
--SELECT num_highpressure_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=10
--SELECT num_vibration_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=10

--SELECT * FROM SENSORS WHERE (Category_ID IN (SELECT Category_ID FROM Sensors WHERE (Sensor_Serial=39)) AND (Sensor_Serial!=39) AND (Measurement_Value IS NOT NULL))		--THIS CHECKS IF THE SNESOR IS THE ONLY ONE OF IT'S KIND AND IF ANY OF THOSE DON'T HAVE NULL VALUES (Because otherewise the compared averages would always be equal. We could also fix it by letting all sensors have Measurment_Value=0 and the column not null constrained in the beginning. This way, it's almost as if the average is  because the average check will be skipped


--SELECT * FROM Sensors where exists(SELECT Sensor_Serial FROM SENSORS WHERE (Category_ID IN (SELECT Category_ID FROM Sensors WHERE (Sensor_Serial=39)) AND (Sensor_Serial!=39) AND (Measurement_Value IS NOT NULL)))		--THIS CHECKS IF THE SNESOR IS THE ONLY ONE OF IT'S KIND AND IF ANY OF THOSE DON'T HAVE NULL VALUES (Because otherewise the compared averages would always be equal. We could also fix it by letting all sensors have Measurment_Value=0 and the column not null constrained in the beginning. This way, it's almost as if the average is  because the average check will be skipped


--SELECT * FROM Sensors where exists(SELECT Sensor_Serial FROM SENSORS WHERE (Category_ID IN (SELECT Category_ID FROM Sensors WHERE (Sensor_Serial=11)) AND (Sensor_Serial!=11) AND (Measurement_Value IS NOT NULL)))	

--select DATEDIFF(SECOND,(SELECT Measurement_DateAndTime FROM Sensors WHERE Sensors.Sensor_Serial=40),GETUTCDATE())
--select (DATEDIFF(HOUR,GETUTCDATE(),(SELECT Measurement_DateAndTime FROM Sensors WHERE Sensors.Sensor_Serial=30)))
--SELECT Category_ID FROM Sensors WHERE Category_ID NOT IN ('tmpr','prsr','vibr') and Engine_Serial=10
