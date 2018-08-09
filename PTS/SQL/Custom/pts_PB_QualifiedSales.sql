EXEC [dbo].pts_CheckProc 'pts_PB_QualifiedSales'
GO

--DECLARE @Qualify int EXEC pts_PB_QualifiedSales 9917, 7, '7/7/13', @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 11

CREATE PROCEDURE [dbo].pts_PB_QualifiedSales
   @MemberID int,
   @Title int,
   @QualifyDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Amount money, @FromDate datetime, @ToDate datetime
IF @QualifyDate = 0 SET @QualifyDate = dbo.wtfn_DateOnly(GETDATE())
SET @FromDate = CAST(CAST(Month(@QualifyDate) AS varchar(2)) + '/1/' + CAST(Year(@QualifyDate) AS varchar(4)) AS datetime)
SET @ToDate = DATEADD(M,1,@FromDate)

SET @Qualify = 0
SET @Amount = 0

IF @Title >= 3 AND @Title <= 7
BEGIN
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
END

IF @Amount < 57 SET @Qualify = -1

--	Associate	
IF @Title = 1 SET @Qualify = 1	

--	Affiliate+
IF @Title >= 2 AND @Amount >= 57 SET @Qualify = 1

GO

