EXEC [dbo].pts_CheckProc 'pts_Appt_ListReminder'
GO

--EXEC pts_Appt_ListReminder 1

CREATE PROCEDURE [dbo].pts_Appt_ListReminder
   @UserID int
AS

SET NOCOUNT ON

DECLARE @Timezone int

SELECT @Timezone = Timezone FROM Business WHERE BusinessID = 1

SELECT   app.ApptID, 
         app.ApptName, 
         app.Location, 
         app.Note, 
         app.StartDate, 
         app.StartTime, 
         app.EndDate, 
         app.EndTime, 
         app.IsAllDay, 
         app.ApptType, 
         me.Email AS 'Email', 
         me.MemberID AS 'MemberID', 
         me.IsMsg AS 'IsMsg'
FROM Appt AS app (NOLOCK)
LEFT OUTER JOIN Calendar AS cal (NOLOCK) ON (app.CalendarID = cal.CalendarID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (cal.MemberID = me.MemberID)
WHERE app.RemindDate <> 0
AND   DATEADD(hour, @Timezone - cal.Timezone, app.RemindDate) < GETDATE()

GO
