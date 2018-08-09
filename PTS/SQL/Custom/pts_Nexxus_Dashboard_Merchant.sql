EXEC [dbo].pts_CheckProc 'pts_Nexxus_Dashboard_Merchant'
GO

--DECLARE @Result varchar(1000) EXEC pts_Nexxus_Dashboard_Merchant 1, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Dashboard_Merchant
   @MerchantID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Merchant Dashboard
-- ***********************************************************************
DECLARE @CompanyID int, @Today datetime, @7Days datetime, @Test int, @PastDate datetime, @cnt int
DECLARE @Sales1 money, @Sales2 money, @Sales3 money, @Sales4 money
DECLARE @Promo1 varchar(80), @Promo2 varchar(80), @Promo3 varchar(80), @Promo4 varchar(80)
DECLARE @Reward1 varchar(80), @Reward2 varchar(80), @Reward3 varchar(80), @Reward4 varchar(80)
DECLARE @Refer1 int, @Refer2 int, @Refer3 int, @Refer4 int
DECLARE @Bill1 int, @Bill2 money, @Bill3 int, @Bill4 money, @Bill5 int, @Bill6 money, @Bill7 int, @Bill8 money

DECLARE @SendDate datetime, @PromoName varchar(60)
DECLARE @AwardType int, @Amount money, @Description varchar(200)

SET @CompanyID = 21
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @Test = 0
SET @Result = ''
SET @Sales1 = 0 SET @Sales2 = 0 SET @Sales3 = 0 SET @Sales4 = 0
SET @Promo1 = '' SET @Promo2 = '' SET @Promo3 = '' SET @Promo4 = '' 
SET @Reward1 = '' SET @Reward2 = '' SET @Reward3 = '' SET @Reward4 = '' 
SET @Refer1 = 0 SET @Refer2 = 0 SET @Refer3 = 0 SET @Refer4 = 0 
SET @Bill1 = 0 SET @Bill2 = 0 SET @Bill3 = 0 SET @Bill4 = 0 SET @Bill5 = 0 SET @Bill6 = 0 SET @Bill7 = 0 SET @Bill8 = 0 

-- Get Sales Totals and Referred Shopper counts ------------------------------------------------------------
SET @PastDate = @Today
SELECT @Sales1 = ISNULL(SUM(Total),0) FROM Payment2 WHERE MerchantID = @MerchantID AND Status > 0 AND PayDate >= @PastDate
SELECT @Refer1 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SET @PastDate = DATEADD(day, -7, @Today)
SELECT @Sales2 = ISNULL(SUM(Total),0) FROM Payment2 WHERE MerchantID = @MerchantID AND Status > 0 AND PayDate >= @PastDate
SELECT @Refer2 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SET @PastDate = DATEADD(day, -30, @Today)
SELECT @Sales3 = ISNULL(SUM(Total),0) FROM Payment2 WHERE MerchantID = @MerchantID AND Status > 0 AND PayDate >= @PastDate
SELECT @Refer3 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SELECT @Sales4 = ISNULL(SUM(Total),0) FROM Payment2 WHERE MerchantID = @MerchantID AND Status > 0
SELECT @Refer4 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 

DECLARE Promo_cursor CURSOR LOCAL STATIC FOR 
SELECT top 4 SendDate, PromoName FROM Promo WHERE MerchantID = @MerchantID AND Status = 3 ORDER BY SendDate DESC
OPEN Promo_cursor
FETCH NEXT FROM Promo_cursor INTO @SendDate, @PromoName
SET @cnt = 1
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @cnt = 1 SET @Promo1 = dbo.wtfn_DateOnlyStr(@SendDate) + ' - ' + @PromoName
	IF @cnt = 2 SET @Promo2 = dbo.wtfn_DateOnlyStr(@SendDate) + ' - ' + @PromoName
	IF @cnt = 3 SET @Promo3 = dbo.wtfn_DateOnlyStr(@SendDate) + ' - ' + @PromoName
	IF @cnt = 3 SET @Promo4 = dbo.wtfn_DateOnlyStr(@SendDate) + ' - ' + @PromoName
	FETCH NEXT FROM Promo_cursor INTO @SendDate, @PromoName
	SET @cnt = @cnt + 1
END
CLOSE Promo_cursor
DEALLOCATE Promo_cursor

DECLARE Award_cursor CURSOR LOCAL STATIC FOR 
SELECT TOP 4 AwardType, Amount, Description FROM Award WHERE MerchantID = @MerchantID AND Status = 1 ORDER BY AwardType, Seq
OPEN Award_cursor
FETCH NEXT FROM Award_cursor INTO @AwardType, @Amount, @Description
SET @cnt = 1
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @AwardType = 1
		SET @Description = CAST(@Amount AS VARCHAR(10)) + '% ' + @Description 
	ELSE
		SET @Description = CAST(@Amount AS VARCHAR(10)) + ' pts ' + @Description
		
	IF @cnt = 1 SET @Reward1 = @Description
	IF @cnt = 2 SET @Reward2 = @Description
	IF @cnt = 3 SET @Reward3 = @Description
	IF @cnt = 4 SET @Reward4 = @Description
	FETCH NEXT FROM Award_cursor INTO @AwardType, @Amount, @Description
	SET @cnt = @cnt + 1
END
CLOSE Award_cursor
DEALLOCATE Award_cursor

-- Get All Cash Payments waiting to be approved ------------------------------------------------------------
SELECT @Bill1 = COUNT(*), @Bill2 = ISNULL(SUM(Cashback+Fee),0) FROM Payment2 WHERE MerchantID = @MerchantID AND PayType = 1 AND Status = 1
SELECT @Bill3 = COUNT(*), @Bill4 = ISNULL(SUM(Cashback+Fee),0) FROM Payment2 WHERE MerchantID = @MerchantID AND PayType = 1 AND Status = 2
SELECT @Bill5 = COUNT(*), @Bill6 = ISNULL(SUM(Merchant),0) FROM Payment2 WHERE MerchantID = @MerchantID AND PayType = 2 AND Status = 2
SELECT @Bill7 = COUNT(*), @Bill8 = ISNULL(SUM(Amount),0) FROM Commission WHERE OwnerType=150 AND OwnerID = @MerchantID AND PayoutID = 0 AND Show = 0

-- 1. Sales ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Sales1 AS VARCHAR(10)) + '^' + CAST(@Sales2 AS VARCHAR(10)) + '^' + CAST(@Sales3 AS VARCHAR(10)) + '^' + CAST(@Sales4 AS VARCHAR(10)) + '|'

-- 2. Promos ----------------------------------------------------------------------------------

SET @Result = @Result + @Promo1 + '^' + @Promo2 + '^' + @Promo3 + '^' + @Promo4 + '|'

-- 3. Rewards / Awards ----------------------------------------------------------------------------------

SET @Result = @Result + @Reward1 + '^' + @Reward2 + '^' + @Reward3 + '^' + @Reward4 + '|'

-- 4. Referred Shoppers ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Refer1 AS VARCHAR(10)) + '^' + CAST(@Refer2 AS VARCHAR(10)) + '^' + CAST(@Refer3 AS VARCHAR(10)) + '^' + CAST(@Refer4 AS VARCHAR(10)) + '|'

-- 5. Billing Info ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Bill1 AS VARCHAR(10)) + '^' + CAST(@Bill2 AS VARCHAR(10)) + '^' + CAST(@Bill3 AS VARCHAR(10)) + '^' + CAST(@Bill4 AS VARCHAR(10)) + '^' + CAST(@Bill5 AS VARCHAR(10)) + '^' + CAST(@Bill6 AS VARCHAR(10)) + '^' + CAST(@Bill7 AS VARCHAR(10)) + '^' + CAST(@Bill8 AS VARCHAR(10))

GO
