EXEC [dbo].pts_CheckProc 'pts_Merchant_FetchEmail'
GO

CREATE PROCEDURE [dbo].pts_Merchant_FetchEmail
   @Email nvarchar (80) ,
   @MerchantID int OUTPUT
AS

DECLARE @mMerchantID int

SET NOCOUNT ON

SELECT      @mMerchantID = mer.MerchantID
FROM Merchant AS mer (NOLOCK)
WHERE (mer.Email = @Email)


SET @MerchantID = ISNULL(@mMerchantID, 0)
GO