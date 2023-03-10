
CREATE procedure [dbo].[spEnginesHealthMetrics_UpdateAllEngines]
as
begin
	set nocount on


	DECLARE @Engine_Serial int
	DECLARE Engine CURSOR LOCAL FOR SELECT Engine_Serial FROM dbo.Engines
	OPEN Engine
	FETCH NEXT FROM Engine INTO @Engine_Serial
	WHILE @@FETCH_STATUS=0
	BEGIN
		exec dbo.spEnginesHealthMetrics_Update @Engine_Serial
		FETCH NEXT FROM Engine INTO @Engine_Serial
	END
	CLOSE Engine
	DEALLOCATE Engine
end