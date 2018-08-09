EXEC [dbo].pts_CheckProc 'pts_Appt_CalendarEmail'
GO

CREATE PROCEDURE [dbo].pts_Appt_CalendarEmail
   @CalendarID int,
   @Email varchar(80) OUTPUT
AS

SET NOCOUNT ON

SELECT  @Email = me.Email
FROM Member AS me
JOIN Calendar AS ca ON me.MemberID = ca.MemberID
WHERE ca.CalendarID = @CalendarID

GO