--INDEXING BEGINS
USE EngineDB




CREATE INDEX iEnginesInstallDateAndTime
ON Sensors (Installation_DateAndTime);

CREATE INDEX iSensorsEngineSerial
ON Sensors (Engine_Serial);

CREATE INDEX iSensorsCategoryID
ON Sensors (Category_ID);

CREATE INDEX iOpStatus_ID
ON Engines (Operating_Mode);

--CREATE UNIQUE INDEX iEHMEngineSerial
--ON Engine_Health_Metrics (Engine_Serial);			--Realized it is already primary key so don't need to index this.




GO
--INDEXING ENDS






--Note to self:
--For otherwise unique columns with only NULL repeating we can create the index with the filter "where Engine_ID is not null" but
-- that could create a problem as the performance in finding NULL values won't be enhanced so I'd rather just set it as non-unique index.
-- We could just add a specific constraint to apply a special form of uniqueness (allows multiple nulls) I guess?






