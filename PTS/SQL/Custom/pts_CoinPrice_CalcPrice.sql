EXEC [dbo].pts_CheckProc 'pts_CoinPrice_CalcPrice'
GO
--select * from coinprice
--DECLARE @Status int EXEC pts_CoinPrice_CalcPrice 1, @Status OUTPUT

CREATE PROCEDURE [dbo].pts_CoinPrice_CalcPrice
   @Coin int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON
SET @Status = 1

DECLARE @Now datetime, @Price money, @avgPrice money, @LowPrice money, @HighPrice money
SET @Now = GETDATE()

--**********************
-- Coin 1 = BTC
-- Coin 2 = NXC
-- Coin 3 = ETH
-- Coin 6 = BCH
-- Source 1 = Nexxus
-- Source 2 = Coindesk
-- Source 3 = CryptoCompare
-- Source 4 = Blockchain
-- Source 5 = WinkDex
-- Source 6 = OKCoin
--**********************

--**********************
-- BTC Price
--**********************
SET @Coin = 1
-- Get Current Price
SELECT @Price = Price FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

-- Set a range of acceptable price deviations (10%)
SET @LowPrice = @Price * .90
SET @HighPrice = @Price * 1.10

-- Set Average Nexxus Coin Price
SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice 
WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1 AND Price >= @LowPrice AND Price <= @HighPrice

IF @Price = 0 SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1

-- Update Nexxus default price
IF @Price > 0 UPDATE CoinPrice SET Price = @Price, PriceDate = @Now WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

--**********************
-- NXX Price
--**********************
SET @Coin = 2
-- Get Current Price
SELECT @Price = Price FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

-- Set a range of acceptable price deviations (10%)
SET @LowPrice = @Price * .90
SET @HighPrice = @Price * 1.10

-- Set Average Nexxus Price for this coin
SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice 
WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1 AND Price >= @LowPrice AND Price <= @HighPrice

IF @Price = 0 SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1

-- Update Nexxus default price
IF @Price > 0 UPDATE CoinPrice SET Price = @Price, PriceDate = @Now WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

--**********************
-- ETH Price
--**********************
SET @Coin = 3
-- Get Current Price
SELECT @Price = Price FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

-- Set a range of acceptable price deviations (10%)
SET @LowPrice = @Price * .90
SET @HighPrice = @Price * 1.10

-- Set Average Nexxus Coin Price
SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice 
WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1 AND Price >= @LowPrice AND Price <= @HighPrice

IF @Price = 0 SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1

-- Update Nexxus default price
IF @Price > 0 UPDATE CoinPrice SET Price = @Price, PriceDate = @Now WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

--**********************
-- BCH Price
--**********************
SET @Coin = 6
-- Get Current Price
SELECT @Price = Price FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

-- Set a range of acceptable price deviations (10%)
SET @LowPrice = @Price * .90
SET @HighPrice = @Price * 1.10

-- Set Average Nexxus Coin Price
SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice 
WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1 AND Price >= @LowPrice AND Price <= @HighPrice

IF @Price = 0 SELECT @Price = ISNULL(AVG(Price),0) FROM CoinPrice WHERE Coin = @Coin AND CurrencyCode = 'USD' AND Status = 2 AND [Source] != 1

-- Update Nexxus default price
IF @Price > 0 UPDATE CoinPrice SET Price = @Price, PriceDate = @Now WHERE Coin = @Coin AND CurrencyCode = 'USD' AND [Source] = 1

GO
