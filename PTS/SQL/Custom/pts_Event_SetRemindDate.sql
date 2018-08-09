EXEC [dbo].pts_CheckProc 'pts_Event_SetRemindDate'
GO

CREATE PROCEDURE [dbo].pts_Event_SetRemindDate
   @EventID int
AS

SET NOCOUNT ON

DECLARE @RemindDays int, @EventDate datetime, @RemindDate datetime, @Recur int, @Today datetime
SELECT @EventDate = EventDate, @RemindDays = RemindDays, @Recur = Recur FROM Event WHERE EventID = @EventID

IF @RemindDays < 0
	SET @RemindDate = 0
ELSE
BEGIN
--	Adjust todays date for the number of reminder days
	SET @Today = DATEADD(day, @RemindDays, GETDATE())
--	Calculate recurring Annually
	IF @Recur = 1
	BEGIN
		WHILE @EventDate < @Today 
			SET @EventDate = DATEADD(year, 1, @EventDate)
	END
--	Calculate recurring Monthly
	IF @Recur = 2
	BEGIN
		WHILE @EventDate < @Today
			SET @EventDate = DATEADD(month, 1, @EventDate)
	END
--	Calculate recurring Quarterly
	IF @Recur = 3
	BEGIN
		WHILE @EventDate < @Today
			SET @EventDate = DATEADD(month, 3, @EventDate)
	END
--	Calculate recurring SemiAnnually
	IF @Recur = 4
	BEGIN
		WHILE @EventDate < @Today
			SET @EventDate = DATEADD(month, 6, @EventDate)
	END
--	Calculate reminder Date
	IF @EventDate >= @Today
        	SET @RemindDate = DATEADD(day, @RemindDays*-1, @EventDate)
	ELSE
		SET @RemindDate = 0
END

UPDATE Event SET RemindDate = @RemindDate WHERE EventID = @EventID

GO