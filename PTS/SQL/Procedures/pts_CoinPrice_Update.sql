EXEC [dbo].pts_CheckProc 'pts_CoinPrice_Update'
 GO

CREATE PROCEDURE [dbo].pts_CoinPrice_Update ( 
   @CoinPriceID int,
   @Coin int,
   @Source int,
   @Price money,
   @PriceDate datetime,
   @CurrencyCode varchar (3),
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cpr
SET cpr.Coin = @Coin ,
   cpr.Source = @Source ,
   cpr.Price = @Price ,
   cpr.PriceDate = @PriceDate ,
   cpr.CurrencyCode = @CurrencyCode ,
   cpr.Status = @Status
FROM CoinPrice AS cpr
WHERE cpr.CoinPriceID = @CoinPriceID

GO