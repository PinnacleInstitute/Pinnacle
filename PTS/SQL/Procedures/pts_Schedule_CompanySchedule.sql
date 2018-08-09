EXEC [dbo].pts_CheckProc 'pts_Schedule_CompanySchedule'
GO

CREATE PROCEDURE [dbo].pts_Schedule_CompanySchedule
   @CompanyID int ,
   @UserID int ,
   @ScheduleID int OUTPUT
AS

DECLARE @mScheduleID int

SET NOCOUNT ON

SELECT TOP 1      @mScheduleID = sch.ScheduleID
FROM Schedule AS sch (NOLOCK)
WHERE (sch.CompanyID = @CompanyID)

ORDER BY   sch.ScheduleName

SET @ScheduleID = ISNULL(@mScheduleID, 0)
GO