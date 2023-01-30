----Note that after making columns 1 2 and 3 we can use primary key(1,2,3); for composite primary keys
CREATE DATABASE EngineDB;
GO
USE EngineDB;
CREATE TABLE Engines(
	Engine_Serial int NOT NULL PRIMARY KEY,
	Type varchar(30) NOT NULL,
    Power decimal(8,3) NOT NULL,
    Operating_Mode varchar(15),
    Production_Year decimal(4,0)
);
----DROP TABLE Engines;
ALTER TABLE [Engines] ALTER COLUMN [Operating_Mode] varchar(15) NOT NULL;
ALTER TABLE [Engines] ALTER COLUMN [Production_Year] decimal(4,0) NOT NULL;

CREATE TABLE Engine_Health_Metrics
(
--The following line is a plausible replacement for the next two lines (after it): --Engine_Serial int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Engines(Engine_Serial),
Engine_Serial int NOT NULL PRIMARY KEY,
CONSTRAINT FK3 FOREIGN KEY (Engine_Serial) REFERENCES Engines(Engine_Serial),
num_overheat_warn bigint NOT NULL,
num_vibration_warn bigint NOT NULL,
num_highpressure_warn bigint NOT NULL,
Engine_Status varchar(15)
);


CREATE TABLE Sensors_Categories
(
Category_ID char(4) NOT NULL PRIMARY KEY,	--was int
Category_Name varchar(20) NOT NULL,
Units varchar(15) NOT NULL,
Precision_Class varchar(15) NOT NULL,
);

EXEC SP_RENAME 'dbo.Sensors_Categories', 'Sensor_Catgories';
CREATE TABLE Sensors
(
Sensor_Serial int NOT NULL PRIMARY KEY,
Installation_DateAndTime datetime,
Measurement_DateAndTime datetime2,
Total_Registered_Failures bigint NOT NULL,
Operating_Status varchar(10) NOT NULL,
Measurement_Value bigint,
Sensor_Health_Status varchar(10) NOT NULL,
Engine_Serial int,--nullable
CONSTRAINT FK1 FOREIGN KEY (Engine_Serial) REFERENCES Engines(Engine_Serial),
Category_ID char(4) NOT NULL,		--was int
CONSTRAINT FK2 FOREIGN KEY (Category_ID) REFERENCES Sensor_Catgories(Category_ID)
);
GO