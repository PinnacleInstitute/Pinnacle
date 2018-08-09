EXEC [dbo].pts_CheckProc 'pts_Credit_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Credit_Delete ( 
   @CreditID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cr
FROM Credit AS cr
WHERE cr.CreditID = @CreditID

GO