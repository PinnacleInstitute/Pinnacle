EXEC [dbo].pts_CheckProc 'pts_CoinPrice_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_CoinPrice_Fetch ( 
   @CoinPriceID int,
   @Coin int OUTPUT,
   @Source int OUTPUT,
   @Price money OUTPUT,
   @PriceDate datetime OUTPUT,
   @CurrencyCode varchar (3) OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @Coin = cpr.Coin ,
   @Source = cpr.Source ,
   @Price = cpr.Price ,
   @PriceDate = cpr.PriceDate ,
   @CurrencyCode = cpr.CurrencyCode ,
   @Status = cpr.Status
FROM CoinPrice AS cpr (NOLOCK)
WHERE cpr.CoinPriceID = @CoinPriceID

GO