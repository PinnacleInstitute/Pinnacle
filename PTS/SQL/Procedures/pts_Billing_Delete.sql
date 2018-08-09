EXEC [dbo].pts_CheckProc 'pts_Billing_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Billing_Delete ( 
   @BillingID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bil
FROM Billing AS bil
WHERE bil.BillingID = @BillingID

GO