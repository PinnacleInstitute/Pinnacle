EXEC [dbo].pts_CheckProc 'pts_CoinAddress_GetCoinAddress'
GO

--DECLARE @CoinAddressID int EXEC pts_CoinAddress_GetCoinAddress 1, 1, @CoinAddressID OUTPUT PRINT @CoinAddressID

CREATE PROCEDURE [dbo].pts_CoinAddress_GetCoinAddress
   @MerchantID int ,
   @Coin int ,
   @CoinAddressID int OUTPUT
AS

SET NOCOUNT ON

SELECT TOP 1 @CoinAddressID = CoinAddressID FROM CoinAddress 
WHERE MerchantID = @MerchantID AND Coin = @Coin AND Status = 1
ORDER BY CoinAddressID

GO
