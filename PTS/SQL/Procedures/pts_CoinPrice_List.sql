EXEC [dbo].pts_CheckProc 'pts_CoinPrice_List'
GO

CREATE PROCEDURE [dbo].pts_CoinPrice_List
   @Coin int
AS

SET NOCOUNT ON

SELECT      cpr.CoinPriceID, 
         cpr.Coin, 
         cpr.Source, 
         cpr.Price, 
         cpr.PriceDate, 
         cpr.CurrencyCode, 
         cpr.Status
FROM CoinPrice AS cpr (NOLOCK)
WHERE (@Coin = 0)
 OR (cpr.Coin = @Coin)

ORDER BY   cpr.Coin , cpr.CurrencyCode , cpr.Status

GO