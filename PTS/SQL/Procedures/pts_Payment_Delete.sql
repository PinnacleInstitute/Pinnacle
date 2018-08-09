EXEC [dbo].pts_CheckProc 'pts_Payment_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Payment_Delete ( 
   @PaymentID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pa
FROM Payment AS pa
WHERE pa.PaymentID = @PaymentID

GO