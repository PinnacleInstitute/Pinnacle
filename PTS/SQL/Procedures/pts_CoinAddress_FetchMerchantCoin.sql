EXEC [dbo].pts_CheckProc 'pts_CoinAddress_FetchMerchantCoin'
GO

CREATE PROCEDURE [dbo].pts_CoinAddress_FetchMerchantCoin
   @MerchantID int ,
   @Coin int ,
   @CoinAddressID int OUTPUT ,
   @Address nvarchar (60) OUTPUT
AS

DECLARE @mCoinAddressID int, 
         @mAddress nvarchar (60)

SET NOCOUNT ON

SELECT      @mCoinAddressID = ca.CoinAddressID, 
         @mAddress = ca.Address
FROM CoinAddress AS ca (NOLOCK)
WHERE (ca.MerchantID = @MerchantID)
 AND (ca.Coin = @Coin)
 AND (ca.Status = 1)


SET @CoinAddressID = ISNULL(@mCoinAddressID, 0)
SET @Address = ISNULL(@mAddress, 0)
GO