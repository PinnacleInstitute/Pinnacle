EXEC [dbo].pts_CheckProc 'pts_Appt_ClearReminder'
GO

CREATE PROCEDURE [dbo].pts_Appt_ClearReminder
   @ApptID int
AS

SET NOCOUNT ON
UPDATE Appt SET RemindDate = 0, Reminder = 0 WHERE ApptID = @ApptID

GO
