EXEC [dbo].pts_CheckProc 'pts_Nexxus_Dashboard_Consumer'
GO

--DECLARE @Result varchar(1000) EXEC pts_Nexxus_Dashboard_Consumer 1, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Dashboard_Consumer
   @ConsumerID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Consumer Dashboard
-- ***********************************************************************
DECLARE @CompanyID int, @Today datetime, @7Days datetime, @PastDate datetime, @Test int, @cnt int 
DECLARE @Sales1 money, @Sales2 money, @Sales3 money, @Sales4 money
DECLARE @Reward1 money, @Reward2 money, @Reward3 money, @Reward4 money
DECLARE @Merchant1 varchar(100), @Merchant2 varchar(100), @Merchant3 varchar(100), @Merchant4 varchar(100)
DECLARE @Refer1 int, @Refer2 int, @Refer3 int, @Refer4 int
DECLARE @Barter1 int, @Barter2 int, @Barter3 int, @Barter4 int

DECLARE @MerchantName varchar(80)

SET @CompanyID = 21
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @Test = 0
SET @Result = ''
SET @Sales1 = 0 SET @Sales2 = 0 SET @Sales3 = 0 SET @Sales4 = 0
SET @Reward1 = 0 SET @Reward2 = 0 SET @Reward3 = 0 SET @Reward4 = 0
SET @Merchant1 = '' SET @Merchant2 = '' SET @Merchant3 = '' SET @Merchant4 = '' 
SET @Refer1 = 0 SET @Refer2 = 0 SET @Refer3 = 0 SET @Refer4 = 0
SET @Barter1 = 0 SET @Barter2 = 0 SET @Barter3 = 0 SET @Barter4 = 0

-- Get Purchase Totals and Referred Shopper counts ------------------------------------------------------------
SET @PastDate = @Today
SELECT @Sales1 = ISNULL(SUM(Total),0) FROM Payment2 WHERE ConsumerID = @ConsumerID AND Status > 0 AND PayDate >= @PastDate
SELECT @Refer1 = COUNT(*) FROM Consumer WHERE ReferID = @ConsumerID AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SET @PastDate = DATEADD(day, -7, @Today)
SELECT @Sales2 = ISNULL(SUM(Total),0) FROM Payment2 WHERE ConsumerID = @ConsumerID AND Status > 0 AND PayDate >= @PastDate
SELECT @Refer2 = COUNT(*) FROM Consumer WHERE ReferID = @ConsumerID AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SET @PastDate = DATEADD(day, -30, @Today)
SELECT @Sales3 = ISNULL(SUM(Total),0) FROM Payment2 WHERE ConsumerID = @ConsumerID AND Status > 0 AND PayDate >= @PastDate
SELECT @Refer3 = COUNT(*) FROM Consumer WHERE ReferID = @ConsumerID AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SELECT @Sales4 = ISNULL(SUM(Total),0) FROM Payment2 WHERE ConsumerID = @ConsumerID AND Status > 0
SELECT @Refer4 = COUNT(*) FROM Consumer WHERE ReferID = @ConsumerID

DECLARE Merchant_cursor CURSOR LOCAL STATIC FOR 
SELECT top 4 me.MerchantName FROM Payment2 AS pa
JOIN Merchant AS me ON pa.MerchantID = me.MerchantID
WHERE ConsumerID = @ConsumerID
GROUP BY me.MerchantName ORDER BY MAX([PayDate]) DESC
OPEN Merchant_cursor
FETCH NEXT FROM Merchant_cursor INTO @MerchantName
SET @cnt = 1
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @cnt = 1 SET @Merchant1 = @MerchantName
	IF @cnt = 2 SET @Merchant2 = @MerchantName
	IF @cnt = 3 SET @Merchant3 = @MerchantName
	IF @cnt = 4 SET @Merchant4 = @MerchantName
	FETCH NEXT FROM Merchant_cursor INTO @MerchantName
	SET @cnt = @cnt + 1
END
CLOSE Merchant_cursor
DEALLOCATE Merchant_cursor

SELECT @Reward1 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status <= 2
SELECT @Reward2 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status = 4
SELECT @Reward3 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 1 AND Status = 3
SELECT @Reward4 = ISNULL(SUM(Amount),0) FROM Reward WHERE ConsumerID = @ConsumerID AND RewardType = 2 
SET @Reward1 = @Reward1 / 100000000
SET @Reward2 = @Reward2 / 100000000
SET @Reward3 = @Reward3 / 100000000
SET @Reward4 = @Reward4 / 100000000

-- Get Barter Stats
SELECT @Barter1 = COUNT(*) FROM BarterAd WHERE ConsumerID = @ConsumerID AND Status = 2
SELECT @Barter2 = COUNT(*) FROM BarterAd WHERE ConsumerID = @ConsumerID
SELECT @Barter3 = ISNULL(SUM(Amount),0) FROM BarterCredit WHERE OwnerType = 151 AND OwnerID = @ConsumerID AND Status IN (1,2)
SELECT @Barter4 = ISNULL(SUM(Amount),0) FROM BarterCredit WHERE OwnerType = 151 AND OwnerID = @ConsumerID AND Amount > 0 AND Status != 3


-- 1. Sales ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Sales1 AS VARCHAR(10)) + '^' + CAST(@Sales2 AS VARCHAR(10)) + '^' + CAST(@Sales3 AS VARCHAR(10)) + '^' + CAST(@Sales4 AS VARCHAR(10)) + '|'

-- 2. Rewards / Awards ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Reward1 AS VARCHAR(15)) + '^' + CAST(@Reward2 AS VARCHAR(15)) + '^' + CAST(@Reward3 AS VARCHAR(15)) + '^' + CAST(@Reward4 AS VARCHAR(15)) + '|'

-- 3. Favorites ----------------------------------------------------------------------------------

SET @Result = @Result + @Merchant1 + '^' + @Merchant2 + '^' + @Merchant3 + '^' + @Merchant4 + '|'

-- 4. Referred Shoppers ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Refer1 AS VARCHAR(10)) + '^' + CAST(@Refer2 AS VARCHAR(10)) + '^' + CAST(@Refer3 AS VARCHAR(10)) + '^' + CAST(@Refer4 AS VARCHAR(10)) + '|'

-- 5. Barter ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Barter1 AS VARCHAR(10)) + '^' + CAST(@Barter2 AS VARCHAR(10)) + '^' + CAST(@Barter3 AS VARCHAR(10)) + '^' + CAST(@Barter4 AS VARCHAR(10))


GO
