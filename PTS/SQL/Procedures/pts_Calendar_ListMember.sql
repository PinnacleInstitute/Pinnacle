EXEC [dbo].pts_CheckProc 'pts_Calendar_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Calendar_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      cal.CalendarID, 
         cal.CalendarName
FROM Calendar AS cal (NOLOCK)
WHERE (cal.MemberID = @MemberID)

ORDER BY   cal.Seq , cal.CalendarName

GO