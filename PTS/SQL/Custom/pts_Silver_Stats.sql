EXEC [dbo].pts_CheckProc 'pts_Silver_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_Silver_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Silver_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @Total int
DECLARE @T1 int, @T7 int, @T99 int
DECLARE @S1 money, @S7 money, @S30 money, @S99 money, @S1T varchar(15), @S7T varchar(15), @S30T varchar(15), @S99T varchar(15)
DECLARE @P1 money, @P7 money, @P30 money, @P99 money, @P1T varchar(15), @P7T varchar(15), @P30T varchar(15), @P99T varchar(15)

SET @CompanyID = 10

SET	@T1 = 0
SET	@T7 = 0 
SET	@T99 = 0 
SET @S1 = 0.0
SET @S7 = 0.0
SET @S30 = 0.0
SET @S99 = 0.0
SET @P1 = 0.0
SET @P7 = 0.0
SET @P30 = 0.0
SET @P99 = 0.0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now

-- Total Members
SELECT @T1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

SELECT @T7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- ****************************************
SELECT @T99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND EnrollDate < @EndDate

--select * from SalesOrder order by SalesOrderID desc

-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)

select @S1 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
 where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(10),@S1, 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

select @P1 = ISNULL(SUM(co.Total),0) from Commission AS co
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P1T = '$'+ CONVERT(varchar(10),@P1, 1)
SET @P1T = LEFT(@P1T, CHARINDEX('.', @P1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(10),@S7, 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

select @P7 = ISNULL(SUM(co.Total),0) from Commission AS co
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P7T = '$'+ CONVERT(varchar(10),@P7, 1)
SET @P7T = LEFT(@P7T, CHARINDEX('.', @P7T)-1 )


SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(10),@S30, 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

select @P30 = ISNULL(SUM(co.Total),0) from Commission AS co
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P30T = '$'+ CONVERT(varchar(10),@P30, 1)
SET @P30T = LEFT(@P30T, CHARINDEX('.', @P30T)-1 )

SET @StartDate = '7/19/2013'
select @S99 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(10),@S99, 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

select @P99 = ISNULL(SUM(pa.Amount),0) from Payout AS pa
where pa.CompanyID = @CompanyID and pa.status = 2 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate

select @P99 = ISNULL(SUM(co.Total),0) from Commission AS co
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P99T = '$'+ CONVERT(varchar(10),@P99, 1)
SET @P99T = LEFT(@P99T, CHARINDEX('.', @P99T)-1 )


SET @Result = '<PTSSTATS ' + 
't1="'  + CAST(@T1 AS VARCHAR(10)) + '" ' +
't7="'  + CAST(@T7 AS VARCHAR(10))  + '" ' +
't99="' + CAST(@T99 AS VARCHAR(10)) + '" ' +
's1="'       + @S1T + '" ' +
's7="'       + @S7T + '" ' +
's30="'      + @S30T + '" ' +
's99="'      + @S99T + '" ' +
'p1="'       + @P1T + '" ' +
'p7="'       + @P7T + '" ' +
'p30="'      + @P30T + '" ' +
'p99="'      + @P99T + '" ' +
'/>'
GO

