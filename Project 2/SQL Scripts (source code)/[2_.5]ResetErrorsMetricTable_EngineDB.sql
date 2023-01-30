--Reset Warnings
USE EngineDB
UPDATE Engine_Health_Metrics SET    num_overheat_warn=2 WHERE  Engine_Serial = 4;--Just a way to test if the below works because all my intial values were 0 anyway (I though that's how it should have been)
UPDATE Engine_Health_Metrics 
SET num_highpressure_warn=0, num_overheat_warn=0, num_vibration_warn=0 
WHERE num_highpressure_warn!=0 or num_overheat_warn!=0 or num_vibration_warn!=0;
GO