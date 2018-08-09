EXEC [dbo].pts_CheckProc 'pts_Nexxus_Dashboard_Org'
GO

--DECLARE @Result varchar(1000) EXEC pts_Nexxus_Dashboard_Org 1, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Dashboard_Org
   @MerchantID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Merchant Dashboard
-- ***********************************************************************
DECLARE @CompanyID int, @Today datetime, @PastDate datetime
DECLARE @Bonus1 money, @Bonus2 money, @Bonus3 money, @Bonus4 money, @Bonus5 money
DECLARE @Refer1 int, @Refer2 int, @Refer3 int, @Refer4 int

SET @CompanyID = 21
SET @Today = dbo.wtfn_DateOnly(GETDATE())
SET @Result = ''
SET @Refer1 = 0 SET @Refer2 = 0 SET @Refer3 = 0 SET @Refer4 = 0 
SET @Bonus1 = 0 SET @Bonus2 = 0 SET @Bonus3 = 0 SET @Bonus4 = 0 SET @Bonus5 = 0 

-- Get Commission Totals and Referred Shopper counts ------------------------------------------------------------
SET @PastDate = @Today
SELECT @Bonus1 = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerType = 150 AND OwnerID = @MerchantID AND Show = 0 AND CommDate >= @PastDate
SELECT @Refer1 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SET @PastDate = DATEADD(day, -7, @Today)
SELECT @Bonus2 = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerType = 150 AND OwnerID = @MerchantID AND Show = 0 AND CommDate >= @PastDate
SELECT @Refer2 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SET @PastDate = DATEADD(day, -30, @Today)
SELECT @Bonus3 = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerType = 150 AND OwnerID = @MerchantID AND Show = 0 AND CommDate >= @PastDate
SELECT @Refer3 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 AND dbo.wtfn_DateOnly(EnrollDate) >= @PastDate
SELECT @Bonus4 = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerType = 150 AND OwnerID = @MerchantID AND Show = 0
SELECT @Refer4 = COUNT(*) FROM Consumer WHERE MerchantID = @MerchantID AND ReferID = 0 
SELECT @Bonus5 = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerTYpe = 150 AND OwnerID = @MerchantID AND Show = 0 AND PayoutID = 0

-- 1. Bonuses ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Bonus1 AS VARCHAR(10)) + '^' + CAST(@Bonus2 AS VARCHAR(10)) + '^' + CAST(@Bonus3 AS VARCHAR(10)) + '^' + CAST(@Bonus4 AS VARCHAR(10)) + '^' + CAST(@Bonus5 AS VARCHAR(10)) + '|'

-- 4. Referred Shoppers ----------------------------------------------------------------------------------

SET @Result = @Result + CAST(@Refer1 AS VARCHAR(10)) + '^' + CAST(@Refer2 AS VARCHAR(10)) + '^' + CAST(@Refer3 AS VARCHAR(10)) + '^' + CAST(@Refer4 AS VARCHAR(10)) 


GO
