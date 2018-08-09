EXEC [dbo].pts_CheckProc 'pts_PB_MonthlySales'
GO

--declare @Result varchar(1000) EXEC pts_PB_MonthlySales '11/1/13', @Result output print @Result

CREATE PROCEDURE [dbo].pts_PB_MonthlySales
   @QualifyDate datetime,	
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @CountGood int, @CountBad int
SET @CompanyID = 11
SET @CountGood = 0
SET @CountBad = 0

-- *******************************************************************
-- Calculate total personal and customer sales for all members 
-- *******************************************************************
UPDATE Member SET BV2 = 0, QV2 = 0 WHERE CompanyID = @CompanyID 

DECLARE @MemberID int, @Title int, @Amount money, @Required money, @FromDate datetime, @ToDate datetime, @EnrollDate datetime

SET @FromDate = CAST(CAST(Month(@QualifyDate) AS varchar(2)) + '/1/' + CAST(Year(@QualifyDate) AS varchar(4)) AS datetime)
SET @ToDate = DATEADD(M,1,@FromDate)
SET @EnrollDate = @FromDate

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Title
FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title >= 1 AND EnrollDate < @EnrollDate
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Amount = 0
	SET @Required = 0

	--	Get total Bonus Volume of personal purchases in last month
	SELECT @Amount = ISNULL(SUM(pr.price*si.quantity),0) 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID 
	JOIN SalesItem AS si ON so.SalesOrderID = si.SalesOrderID
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	WHERE me.MemberID = @MemberID AND pa.Status = 3 AND pa.PaidDate >= @FromDate AND pa.PaidDate < @ToDate

	--	Get total Bonus Volume of their customer purchases in last month
	SELECT @Amount = @Amount + ISNULL(SUM(pr.price*si.quantity),0) 
	FROM Payment AS pa
	JOIN SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
	JOIN Member AS me ON so.MemberID = me.MemberID 
	JOIN SalesItem AS si ON so.SalesOrderID = si.SalesOrderID
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	WHERE me.ReferralID = @MemberID AND me.Level = 0 AND pa.Status = 3 AND pa.PaidDate >= @FromDate AND pa.PaidDate < @ToDate

	IF @Title = 1 SET @Required = 0	  -- Associate	
	IF @Title = 2 SET @Required = 57  -- Affiliate	
	IF @Title = 3 SET @Required = 57  -- Junior
	IF @Title = 4 SET @Required = 57  -- Partner	
	IF @Title = 5 SET @Required = 57  -- Senior	
	IF @Title >= 6 SET @Required = 57 -- Executive, Diamond
	
	UPDATE Member SET BV2 = @Amount, QV2 = @Required WHERE MemberID = @MemberID

	IF @Amount >= @Required
		SET @CountGood = @CountGood + 1
	ELSE	
		SET @CountBad = @CountBad + 1
	
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@CountGood AS VARCHAR(10)) + '|' + CAST(@CountBad AS VARCHAR(10))

GO