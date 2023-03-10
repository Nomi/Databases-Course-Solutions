

CREATE PROCEDURE [dbo].[spEnginesHealthMetrics_Update]
		@Engine_Serial INT
AS
BEGIN
	SET NOCOUNT ON
	IF	((SELECT Operating_Mode FROM dbo.Engines WHERE Engines.Engine_Serial=@Engine_Serial)='STOP' or (SELECT Operating_Mode FROM dbo.Engines WHERE Engines.Engine_Serial=@Engine_Serial)='SERVICE')
	BEGIN
		RETURN
	END
	--RESET PHASE BEGINS		(UPDATE/EDIT BELOW)--We have to reset because otherwise, the procedure which runs every 30 seconds will have duplicate number of warnings
								-- due to the warnings being issued as long as error was 60 seconds ago. [as required by the task] ( and I made a different DB than required as we discussed)
	----UPDATE dbo.Engine_Health_Metrics SET num_overheat_warn = 0
	----UPDATE dbo.Engine_Health_Metrics SET num_highpressure_warn = 0
	----UPDATE dbo.Engine_Health_Metrics SET num_vibration_warn = 0
	--RESET PHASE OVER			UPDATE:--Actually the above is not neccessary anymore. Because the condition for increasing the warning only triggers when there have been no failures in the past
									--but considering how my db turned out different that what was expected, RESET still makes sense.
	DECLARE @Sensor_Serial INT
	DECLARE @Recent_Failure_Count INT
	SET @Recent_Failure_Count = 0
	DECLARE @MiscSensor_New_Warning_Count INT
	SET @MiscSensor_New_Warning_Count = 0
	DECLARE @HasWarningTempr INT --A flag to see if Temprature had any new errors -- I could have just used the conditions already used elsewhere to see if there was a failure in sensor corresponding to temperature but I this should be cleaner
	SET @HasWarningTempr =0
	DECLARE @HasWarningPrsr INT SET @HasWarningPrsr	=0
	DECLARE @HasWarningVibr INT SET @HasWarningVibr	=0
	DECLARE @HasWarningMisc INT SET  @HasWarningMisc =0
	--DECLARE @NewWarningsTmpr INT SET @NewWarningsTmpr =0
	--DECLARE @NewWarningsPrsr INT SET @NewWarningsPrsr	=0
	--DECLARE @NewWarningsVibr INT SET @NewWarningsVibr	=0
	--DECLARE @NewWarningsMisc INT SET  @NewWarningsMisc =0
	DECLARE SensorList CURSOR LOCAL FOR (SELECT Sensor_Serial FROM dbo.Sensors WHERE Sensors.Engine_Serial=@Engine_Serial)
	OPEN SensorList
	FETCH NEXT FROM SensorList INTO @Sensor_Serial
	WHILE @@FETCH_STATUS=0
	BEGIN
		IF((SELECT Sensor_Health_Status FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial)='FAILURE')
		BEGIN
			UPDATE dbo.Sensors SET Total_Registered_Failures = Total_Registered_Failures+1 WHERE dbo.Sensors.Sensor_Serial=@Sensor_Serial
			IF((DATEDIFF(HOUR,(SELECT Measurement_DateAndTime FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial),GETUTCDATE()))<=2)		--Nevermind, switched. --Should have used getutcdate instead! Normall the best option/only recommended option.
				BEGIN SET @Recent_Failure_Count = @Recent_Failure_Count+1 END
			IF(0=((select Sensors.Total_Registered_Failures from Sensors where Sensors.Sensor_Serial=@Sensor_Serial)-1)) --IF no failures were detected in the past
			BEGIN
				IF((DATEDIFF(SECOND,(SELECT Measurement_DateAndTime FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial),GETUTCDATE()))<=60 and (((SELECT Measurement_Value FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial)>2.2*(SELECT AVG(Measurement_Value) FROM Sensors GROUP BY Sensors.Category_ID having Sensors.Category_ID=(SELECT Category_ID FROM Sensors WHERE Sensor_Serial=@Sensor_Serial))) OR (NOT EXISTS (SELECT Sensor_Serial FROM SENSORS WHERE ((Category_ID IN (SELECT Category_ID FROM Sensors WHERE Sensor_Serial=@Sensor_Serial) AND (Sensor_Serial!=10) AND (Measurement_Value IS NOT NULL)) and Engine_Serial=(SELECT Engine_Serial FROM Sensors WHERE Sensor_Serial=@Sensor_Serial))))))
			--THIS CHECKS IF THE SNESOR IS THE ONLY ONE OF IT'S KIND AND IF ANY OF THOSE DON'T HAVE NULL VALUES (Because otherewise the compared averages would always be equal. We could also fix it by letting all sensors have Measurment_Value=0 and the column 'not null' constrained in the beginning. This way, it's almost as if the average is  because the average check will be skipped
				BEGIN 
					IF((SELECT Sensors.Category_ID FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial)='tmpr')			--Put tmpr first because I'm assuming overheating would be a more common problem therfore resources saved when the first condition checks out instead of going through the rest
					BEGIN 
						IF(@HasWarningTempr =0) BEGIN SET  @HasWarningTempr=1 END
						UPDATE dbo.Engine_Health_Metrics SET num_overheat_warn = num_overheat_warn+1 WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial
					END
					ELSE IF((SELECT Sensors.Category_ID FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial)='prsr')
					BEGIN 
						IF(@HasWarningPrsr =0) BEGIN SET  @HasWarningPrsr=1 END
						UPDATE dbo.Engine_Health_Metrics SET num_highpressure_warn = num_highpressure_warn+1 WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial
					END
					ELSE IF((SELECT Sensors.Category_ID FROM Sensors WHERE Sensors.Sensor_Serial=@Sensor_Serial)='vibr')
						BEGIN 
						IF(@HasWarningVibr=0) BEGIN SET  @HasWarningVibr=1 END
						UPDATE dbo.Engine_Health_Metrics SET num_vibration_warn = num_vibration_warn+1 WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial 
						END
					Else
						BEGIN SET @MiscSensor_New_Warning_Count = @MiscSensor_New_Warning_Count +1 SET @HasWarningMisc=1 END	--The reason I use IFs above is because there will be lots of times when the above categories will be updated as these sensors are everywhere, so keeping on setting a value would be more storage intensive and generally same computationally intensive as having an if before that as only once it will go past that if, but here it doesn't matter if just set it everytime as it is not installed everywhere or even in a lot of places
				END
			END
		END
		FETCH NEXT FROM SensorList INTO @Sensor_Serial
	END
	IF(@Recent_Failure_Count>=2)	--note that recent failure count is equal to the number of sensors failed due to my db desgin diverging from task
	BEGIN 
		UPDATE dbo.Engine_Health_Metrics SET Engine_Status = N'AMBER' WHERE dbo.Engine_Health_Metrics.Engine_Serial=@Engine_Serial
	END
	CLOSE SensorList
	DEALLOCATE SensorList

	
	
	--EDIT: HAD TO CHANGE/DIVERT FROM THE DOCX HOW I DID THE FOLLOWING PART BECAUSE PROVIDED DATABASE STRUCTURE ONLY ASKED FOR COLUMNS for overheat,vibration,highpressure warnings.
		--The next two lines make sure that emergency/warning parts can be reached even if the engine doesn't have any specific sensors. Though this will sacrifice the AMBER mode for those engines
		--This is by design as it is better to have just a red satus than just an amber in such mission critical-components
		--This should also serve as a reminder to install misc sensors as required, unlesss they don't need it. In such a case, a dummy sensor should be created and set to bypass this issue. This actually makes it a little safer.
	IF(not exists(SELECT Category_ID FROM Sensors WHERE Category_ID NOT IN ('tmpr','prsr','vibr') and Engine_Serial=@Engine_Serial)) --Turns out you cant have the NOT IN part in brackets like I have the rest of conditions everywhere else in this program
		BEGIN SET @HasWarningMisc=1 SET @MiscSensor_New_Warning_Count=3 END
	IF(3>=((SELECT num_overheat_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)+(SELECT num_highpressure_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)+(SELECT num_vibration_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)+@MiscSensor_New_Warning_Count))
		BEGIN UPDATE dbo.Engine_Health_Metrics SET Engine_Status = N'GREEN' WHERE dbo.Engine_Health_Metrics.Engine_Serial=@Engine_Serial END
-- ->========== my own addition (if status was amber earlier, sets it back to amber) because the requested features were otherwise messing this feature up when combined with my DB divergence from assignment============
	IF(@Recent_Failure_Count>=2) --note that recent failure count is equal to the number of sensors failed due to my db desgin diverging from task
	BEGIN 
		UPDATE dbo.Engine_Health_Metrics SET Engine_Status = N'AMBER' WHERE dbo.Engine_Health_Metrics.Engine_Serial=@Engine_Serial
	END
-- -:============END OF MY OWN ADDITION====================================
	IF((((SELECT num_overheat_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)+(SELECT num_highpressure_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)+(SELECT num_vibration_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)+@MiscSensor_New_Warning_Count) in (3,5)) and 3>=(@HasWarningTempr+@HasWarningPrsr+@HasWarningVibr+@HasWarningMisc))
		BEGIN UPDATE dbo.Engine_Health_Metrics SET Engine_Status = N'AMBER' WHERE dbo.Engine_Health_Metrics.Engine_Serial=@Engine_Serial END
	IF((4=(@HasWarningTempr+@HasWarningPrsr+@HasWarningVibr+@HasWarningMisc) and ((3>(SELECT num_overheat_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)) or (3>(SELECT num_highpressure_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)) or (3>(SELECT num_vibration_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)) or (3>(@MiscSensor_New_Warning_Count)))))
	BEGIN 
		UPDATE dbo.Engine_Health_Metrics SET Engine_Status = N'RED' WHERE dbo.Engine_Health_Metrics.Engine_Serial=@Engine_Serial 
		UPDATE dbo.Engines SET Operating_Mode = N'WARNING' WHERE dbo.Engines.Engine_Serial=@Engine_Serial 
	END
	IF((4=(@HasWarningTempr+@HasWarningPrsr+@HasWarningVibr+@HasWarningMisc) and (not ((3>(SELECT num_overheat_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)) or (3>(SELECT num_highpressure_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)) or (3>(SELECT num_vibration_warn FROM dbo.Engine_Health_Metrics WHERE Engine_Health_Metrics.Engine_Serial=@Engine_Serial)) or (3>(@MiscSensor_New_Warning_Count))))))		--Could've rewritten using De Morgan's Laws (for logic, set theory,etc) instead of just adding a not, but not makes it convenient to find and replace the condition in case it needs to be changed everywhere
	BEGIN 
		UPDATE dbo.Engine_Health_Metrics SET Engine_Status = N'RED' WHERE dbo.Engine_Health_Metrics.Engine_Serial=@Engine_Serial 
		UPDATE dbo.Engines SET Operating_Mode = N'EMEREGENCY' WHERE dbo.Engines.Engine_Serial=@Engine_Serial 
	END
END