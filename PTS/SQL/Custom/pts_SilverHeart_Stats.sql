EXEC [dbo].pts_CheckProc 'pts_SilverHeart_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_SilverHeart_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_SilverHeart_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @Total int
DECLARE @11 int, @17 int, @199 int
DECLARE @21 int, @27 int, @299 int
DECLARE @31 int, @37 int, @399 int
DECLARE @41 int, @47 int, @499 int
DECLARE @T1 int, @T7 int, @T99 int
DECLARE @S1 money, @S7 money, @S30 money, @S99 money, @S1T varchar(15), @S7T varchar(15), @S30T varchar(15), @S99T varchar(15)
DECLARE @P1 money, @P7 money, @P30 money, @P99 money, @P1T varchar(15), @P7T varchar(15), @P30T varchar(15), @P99T varchar(15)
DECLARE @W1 money, @W2 money, @W3 money, @W1T varchar(15), @W2T varchar(15), @W3T varchar(15)
DECLARE @W4 money, @W5 money, @W4T varchar(15), @W5T varchar(15)

SET @CompanyID = 20

SET	@11 = 0 SET	@17 = 0 SET	@199 = 0
SET	@21 = 0 SET	@27 = 0 SET	@299 = 0
SET	@31 = 0 SET	@37 = 0 SET	@399 = 0
SET	@41 = 0 SET	@47 = 0 SET	@499 = 0
SET	@T1 = 0 SET	@T7 = 0 SET	@T99 = 0
SET @S1 = 0.0 SET @S7 = 0.0 SET @S30 = 0.0 SET @S99 = 0.0
SET @P1 = 0.0 SET @P7 = 0.0 SET @P30 = 0.0 SET @P99 = 0.0
SET @W1 = 0.0 SET @W2 = 0.0 SET @W3 = 0.0 SET @W4 = 0.0 SET @W5 = 0.0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now
-- Member
SELECT @11 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Missionary
SELECT @21 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Crusader
SELECT @31 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Humanitarian
SELECT @41 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T1 = @11 + @21 + @31 + @41

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

SELECT @17 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Missionary
SELECT @27 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Crusader
SELECT @37 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Humanitarian
SELECT @47 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T7 = @17 + @27 + @37 + @47

-- ****************************************

SELECT @199 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 1 AND EnrollDate < @EndDate

-- Missionary
SELECT @299 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 2 AND EnrollDate < @EndDate

-- Crusader
SELECT @399 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 3 AND EnrollDate < @EndDate

-- Humanitarian
SELECT @499 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 4 AND EnrollDate < @EndDate

-- Total Members
SET @T99 = @199 + @299 + @399 + @499

--select * from SalesOrder order by SalesOrderID desc
-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)

select @S1 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
 where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(10),@S1, 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

select @P1 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P1T = '$'+ CONVERT(varchar(10),@P1, 1)
SET @P1T = LEFT(@P1T, CHARINDEX('.', @P1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(10),@S7, 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

select @P7 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P7T = '$'+ CONVERT(varchar(10),@P7, 1)
SET @P7T = LEFT(@P7T, CHARINDEX('.', @P7T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(10),@S30, 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

select @P30 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P30T = '$'+ CONVERT(varchar(10),@P30, 1)
SET @P30T = LEFT(@P30T, CHARINDEX('.', @P30T)-1 )

select @S99 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(10),@S99, 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

select @P99 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate < @EndDate
SET @P99T = '$'+ CONVERT(varchar(10),@P99, 1)
SET @P99T = LEFT(@P99T, CHARINDEX('.', @P99T)-1 )

--************************
SELECT @W1 = ISNULL(SUM(Amount),0) FROM Payout WHERE CompanyID = @CompanyID AND Status IN (1,4,5,7) 
SET @W1T = '$'+ CONVERT(varchar(15),@W1, 1)
SET @W1T = LEFT(@W1T, CHARINDEX('.', @W1T)-1 )

SELECT @W2 = ABS(ISNULL(SUM(Amount),0)) FROM Payout WHERE CompanyID = @CompanyID AND Status IN (4,5)
SET @W2T = '$'+ CONVERT(varchar(15),@W2, 1)
SET @W2T = LEFT(@W2T, CHARINDEX('.', @W2T)-1 )

SELECT @W3 = ISNULL(SUM(Amount),0) FROM Payout WHERE CompanyID = @CompanyID AND Amount > 0 AND Status IN (1,2)
SET @W3T = '$'+ CONVERT(varchar(15),@W3, 1)
SET @W3T = LEFT(@W3T, CHARINDEX('.', @W3T)-1 )

SELECT @W4 = ISNULL(SUM(Amount),0) FROM Payout AS pa JOIN Member AS me ON pa.OwnerID = me.MemberID
WHERE pa.CompanyID = @CompanyID AND pa.Status IN (1,4,5,7) AND me.Status IN (1,2,3) AND IsIncluded != 0 
SET @W4T = '$'+ CONVERT(varchar(15),@W4, 1)
SET @W4T = LEFT(@W4T, CHARINDEX('.', @W4T)-1 )

SELECT @W5 = ABS(ISNULL(SUM(Amount),0)) FROM Payout AS pa JOIN Member AS me ON pa.OwnerID = me.MemberID
WHERE pa.CompanyID = @CompanyID AND pa.Status IN (4,5) AND me.Status IN (1,2,3) AND IsIncluded != 0 
SET @W5T = '$'+ CONVERT(varchar(15),@W5, 1)
SET @W5T = LEFT(@W5T, CHARINDEX('.', @W5T)-1 )


-- ****************************************
SET @Result = '<PTSSTATS ' + 
'm11="'  + CAST(@11 AS VARCHAR(10)) + '" ' +
'm17="'  + CAST(@17 AS VARCHAR(10))  + '" ' +
'm199="' + CAST(@199 AS VARCHAR(10)) + '" ' +
'm21="'  + CAST(@21 AS VARCHAR(10)) + '" ' +
'm27="'  + CAST(@27 AS VARCHAR(10))  + '" ' +
'm299="' + CAST(@299 AS VARCHAR(10)) + '" ' +
'm31="'  + CAST(@31 AS VARCHAR(10)) + '" ' +
'm37="'  + CAST(@37 AS VARCHAR(10))  + '" ' +
'm399="' + CAST(@399 AS VARCHAR(10)) + '" ' +
'm41="'  + CAST(@41 AS VARCHAR(10)) + '" ' +
'm47="'  + CAST(@47 AS VARCHAR(10))  + '" ' +
'm499="' + CAST(@499 AS VARCHAR(10)) + '" ' +
't1="'   + CAST(@T1 AS VARCHAR(10)) + '" ' +
't7="'   + CAST(@T7 AS VARCHAR(10))  + '" ' +
't99="'  + CAST(@T99 AS VARCHAR(10)) + '" ' +
's1="'       + @S1T + '" ' +
's7="'       + @S7T + '" ' +
's30="'      + @S30T + '" ' +
's99="'      + @S99T + '" ' +
'p1="'       + @P1T + '" ' +
'p7="'       + @P7T + '" ' +
'p30="'      + @P30T + '" ' +
'p99="'      + @P99T + '" ' +
'w1="'       + @W1T + '" ' +
'w2="'       + @W2T + '" ' +
'w3="'       + @W3T + '" ' +
'w4="'       + @W4T + '" ' +
'w5="'       + @W5T + '" ' +
'/>'
GO

