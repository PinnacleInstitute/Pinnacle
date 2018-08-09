EXEC [dbo].pts_CheckProc 'pts_Calendar_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_Calendar_ListCompany
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      cal.CalendarID, 
         cal.CalendarName
FROM Calendar AS cal (NOLOCK)
WHERE (cal.CompanyID = @CompanyID)
 AND (cal.MemberID = 0)

ORDER BY   cal.Seq , cal.CalendarName

GO