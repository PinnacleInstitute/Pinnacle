EXEC [dbo].pts_CheckProc 'pts_Prepaid_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Prepaid_Delete ( 
   @PrepaidID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pre
FROM Prepaid AS pre
WHERE pre.PrepaidID = @PrepaidID

GO