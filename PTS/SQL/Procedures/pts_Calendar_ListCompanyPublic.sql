EXEC [dbo].pts_CheckProc 'pts_Calendar_ListCompanyPublic'
GO

CREATE PROCEDURE [dbo].pts_Calendar_ListCompanyPublic
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      cal.CalendarID, 
         cal.CalendarName
FROM Calendar AS cal (NOLOCK)
WHERE (cal.CompanyID = @CompanyID)
 AND (cal.MemberID = 0)
 AND (cal.IsPrivate = 0)

ORDER BY   cal.Seq , cal.CalendarName

GO