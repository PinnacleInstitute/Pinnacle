EXEC [dbo].pts_CheckProc 'pts_Coption_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Coption_Delete ( 
   @CoptionID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cop
FROM Coption AS cop
WHERE cop.CoptionID = @CoptionID

GO