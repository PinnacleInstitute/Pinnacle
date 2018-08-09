EXEC [dbo].pts_CheckProc 'pts_Merchant_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Merchant_Delete ( 
   @MerchantID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mer
FROM Merchant AS mer
WHERE mer.MerchantID = @MerchantID

GO