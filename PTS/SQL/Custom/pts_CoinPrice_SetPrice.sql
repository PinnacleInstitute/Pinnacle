EXEC [dbo].pts_CheckProc 'pts_CoinPrice_SetPrice'
GO

--select * from coinprice
--DECLARE @Status int EXEC pts_CoinPrice_SetPrice 6, 3, "USD", 800.88, @Status OUTPUT PRINT @Status

CREATE PROCEDURE [dbo].pts_CoinPrice_SetPrice
   @Source int ,
   @Coin int ,
   @CurrencyCode nvarchar (3) ,
   @Price money ,
   @Status int OUTPUT
AS

SET NOCOUNT ON
SET @Status = 0

DECLARE @CoinPriceID int, @Now datetime
SET @CoinPriceID = 0
SET @Now = GETDATE()

SELECT @CoinPriceID = CoinPriceID FROM CoinPrice WHERE [Source] = @Source AND Coin = @Coin AND CurrencyCode = @CurrencyCode

IF @CoinPriceID > 0
BEGIN
	UPDATE CoinPrice SET Price = @Price, PriceDate = @Now WHERE CoinPriceID = @CoinPriceID
END
ELSE
BEGIN
	-- CoinPriceID, Coin, Source, Price, PriceDate, CurrencyCode, Status, UserID
	EXEC pts_CoinPrice_Add @CoinPriceID OUTPUT, @Coin, @Source, @Price, @Now, @CurrencyCode, 2, 1
END

SET @Status = @CoinPriceID

GO