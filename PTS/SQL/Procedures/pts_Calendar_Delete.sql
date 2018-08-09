EXEC [dbo].pts_CheckProc 'pts_Calendar_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Calendar_Delete ( 
   @CalendarID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cal
FROM Calendar AS cal
WHERE cal.CalendarID = @CalendarID

GO