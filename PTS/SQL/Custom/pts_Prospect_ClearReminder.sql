EXEC [dbo].pts_CheckProc 'pts_Prospect_ClearReminder'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ClearReminder
   @ProspectID int
AS

SET NOCOUNT ON
UPDATE Prospect SET RemindDate = 0, Reminder = 0 WHERE ProspectID = @ProspectID

GO
