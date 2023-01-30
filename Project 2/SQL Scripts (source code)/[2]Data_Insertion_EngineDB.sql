USE [EngineDB]



--Started Filling Data



--Filling Engines
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (1, 'A', 600.000, 'ACTIVE', 1999)
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (2, 'A', 550.670, 'ACTIVE', 1999 )
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (3, 'B', 700.000, 'ACTIVE', 2009 )
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (4, 'B', 3000.000, 'ACTIVE',2019)
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (5, 'C', 10000.000, 'ACTIVE', 2019)
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (6, 'A', 600.000, 'ACTIVE', 2019)
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (7, 'A', 550.670, 'ACTIVE', 2019)
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (8, 'B', 700.000, 'ACTIVE', 2009 )
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (9, 'B', 3000.000, 'ACTIVE',2019)
INSERT [dbo].[Engines] ([Engine_Serial], [Type], [Power], [Operating_Mode], [Production_Year]) VALUES (10, 'C', 10000.000, 'ACTIVE', 2019)


--Filling Sensor_Categories
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('altd', 'Altitude', 'Metres', 'med')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('crnt', 'Current', 'Amperes', 'med')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('erpm', 'Engine RPM', 'RPM', 'high')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('humd', 'Humidity', '%', 'low')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('intk', 'Air Intake', 'm^3', 'low')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('prsr', 'Pressure', 'psi', 'high')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('sped', 'Velocity', 'Knots/Hour', 'low')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('tmpr', 'Temperature', 'Celsius', 'high')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('vibr', 'Vibration Frequency', 'Hz', 'med')
INSERT [dbo].[Sensor_Catgories] ([Category_ID], [Category_Name], [Units], [Precision_Class]) VALUES ('volt', 'Voltage', 'Volts', 'high')

--Filling Engine_Health_Metrics
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (1, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (2, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (3, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (4, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (5, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (6, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (7, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (8, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (9, 0, 0, 0,  'GREEN')
INSERT [dbo].[Engine_Health_Metrics] ([Engine_Serial], [num_overheat_warn], [num_vibration_warn], [num_highpressure_warn], [Engine_Status]) VALUES (10, 0, 0, 0, 'GREEN')

--Filling Sensors

INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (1, CAST('2020-01-12T00:00:00.000' AS DateTime), NULL, 0, 'test', NULL, 'ok', 1, 'altd')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (2, CAST('2020-01-12T00:00:00.000' AS DateTime), NULL, 0, 'offline', NULL, 'failure', 2, 'volt')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (3, CAST('2020-01-12T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 3, 'humd')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (4, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 4, 'crnt')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (5, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 5, 'erpm')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (6, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 6, 'intk')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (7, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 7, 'intk')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (8, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 8, 'sped')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (9, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 9, 'sped')
INSERT [dbo].[Sensors] ([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) VALUES (10, CAST('2020-01-01T00:00:00.000' AS DateTime), NULL, 0, 'online', NULL, 'ok', 10, 'sped')

INSERT [dbo].[Sensors] 
([Sensor_Serial], [Installation_DateAndTime], [Measurement_DateAndTime], [Total_Registered_Failures], [Operating_Status], [Measurement_Value], [Sensor_Health_Status], [Engine_Serial], [Category_ID]) 
VALUES 
(11, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 100, 'online', 120, 'ok', 1, 'tmpr'),
(12, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 50, 'online', 60, 'ok', 1, 'vibr'),
(13, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 25, 'online', 30, 'ok', 1, 'prsr'),

(14, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 101, 'online', 121, 'ok', 2, 'tmpr'),
(15, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 51, 'online', 61, 'ok', 2, 'vibr'),
(16, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 26, 'online', 31, 'ok', 2, 'prsr'),

(17, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 103, 'online', 123, 'ok', 3, 'tmpr'),
(18, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 53, 'online', 63, 'ok', 3, 'vibr'),
(19, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 28, 'online', 33, 'ok', 3, 'prsr'),

(20, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 104, 'online', 124, 'ok', 4, 'tmpr'),
(21, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 54, 'online', 64, 'ok', 4, 'vibr'),
(22, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 29, 'online', 34, 'ok', 4, 'prsr'),

(23, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 105, 'online', 125, 'ok', 5, 'tmpr'),
(24, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 55, 'online', 65, 'ok', 5, 'vibr'),
(25, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 30, 'online', 35, 'ok', 5, 'prsr'),

(26, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 106, 'online', 126, 'ok', 6, 'tmpr'),
(27, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 56, 'online', 66, 'ok', 6, 'vibr'),
(28, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 31, 'online', 36, 'ok', 6, 'prsr'),

(29, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 107, 'online', 127, 'ok', 7, 'tmpr'),
(30, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 57, 'online', 67, 'ok', 7, 'vibr'),
(31, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 32, 'online', 37, 'ok', 7, 'prsr'),

(32, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 2108, 'online', 2120, 'ok', 8, 'tmpr'),
(33, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 258, 'online', 260, 'ok', 8, 'vibr'),
(34, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 233, 'online', 230, 'ok', 8, 'prsr'),

(35, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 10, 'online', 20, 'ok', 9, 'tmpr'),
(36, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 5, 'online', 6, 'ok', 9, 'vibr'),
(37, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 2, 'online', 3, 'ok', 9, 'prsr'),

(38, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-02-01T00:00:00.0000000' AS DateTime2), 10, 'online', 10, 'ok', 10, 'tmpr'),
(39, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-01-01T00:00:00.0000000' AS DateTime2), 10, 'online', 10, 'ok', 10, 'vibr'),
(40, CAST('2020-01-01T00:00:00.000' AS DateTime), CAST('2020-03-01T00:00:00.0000000' AS DateTime2), 10, 'online', 10, 'ok', 10, 'prsr');



--Finished Filling Data




GO
