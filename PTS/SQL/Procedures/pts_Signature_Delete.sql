EXEC [dbo].pts_CheckProc 'pts_Signature_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Signature_Delete ( 
   @SignatureID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sr
FROM Signature AS sr
WHERE sr.SignatureID = @SignatureID

GO