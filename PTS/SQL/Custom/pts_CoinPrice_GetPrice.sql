EXEC [dbo].pts_CheckProc 'pts_CoinPrice_GetPrice'
GO

--DECLARE @Price money EXEC  pts_CoinPrice_GetPrice 2, 'USD', @Price OUTPUT PRINT @Price

CREATE PROCEDURE [dbo].pts_CoinPrice_GetPrice
   @Coin int ,
   @CurrencyCode nvarchar (3) ,
   @Price money OUTPUT
AS

SET NOCOUNT ON
SET @Price = 0

SELECT TOP 1 @Price = Price FROM CoinPrice  WHERE Coin = @Coin AND CurrencyCode = @CurrencyCode AND Status = 1

GO
