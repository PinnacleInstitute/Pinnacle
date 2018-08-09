EXEC [dbo].pts_CheckProc 'pts_Appt_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Appt_Delete ( 
   @ApptID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE app
FROM Appt AS app
WHERE app.ApptID = @ApptID

GO