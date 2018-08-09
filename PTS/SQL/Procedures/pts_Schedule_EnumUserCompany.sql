EXEC [dbo].pts_CheckProc 'pts_Schedule_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_Schedule_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sch.ScheduleID AS 'ID', 
         sch.ScheduleName AS 'Name'
FROM Schedule AS sch (NOLOCK)
WHERE (sch.CompanyID = @CompanyID)

ORDER BY   sch.ScheduleName

GO