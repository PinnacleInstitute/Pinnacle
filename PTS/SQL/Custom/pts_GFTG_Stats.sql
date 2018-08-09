EXEC [dbo].pts_CheckProc 'pts_GFTG_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_GFTG_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_GFTG_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @Total int
DECLARE @01 int, @07 int, @099 int
DECLARE @11 int, @17 int, @199 int
DECLARE @21 int, @27 int, @299 int
DECLARE @31 int, @37 int, @399 int
DECLARE @41 int, @47 int, @499 int
DECLARE @51 int, @57 int, @599 int
DECLARE @T1 int, @T7 int, @T99 int
DECLARE @S1 money, @S7 money, @S30 money, @S99 money, @S1T varchar(15), @S7T varchar(15), @S30T varchar(15), @S99T varchar(15)
DECLARE @P1 money, @P7 money, @P30 money, @P99 money, @P1T varchar(15), @P7T varchar(15), @P30T varchar(15), @P99T varchar(15)

SET @CompanyID = 13

SET	@01 = 0 SET	@07 = 0 SET	@099 = 0 
SET	@11 = 0 SET	@17 = 0 SET	@199 = 0 
SET	@21 = 0 SET	@27 = 0 SET	@299 = 0 
SET	@31 = 0 SET	@37 = 0 SET	@399 = 0 
SET	@41 = 0 SET	@47 = 0 SET	@499 = 0 
SET	@51 = 0 SET	@57 = 0 SET	@599 = 0 
SET	@T1 = 0 SET	@T7 = 0 SET	@T99 = 0 
SET @S1 = 0.0 SET @S7 = 0.0 SET @S30 = 0.0 SET @S99 = 0.0
SET @P1 = 0.0 SET @P7 = 0.0 SET @P30 = 0.0 SET @P99 = 0.0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now
-- Wholesale Buyers
SELECT @01 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliates
SELECT @11 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Silver
SELECT @21 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Gold
SELECT @31 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Platinum
SELECT @41 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Emerald+
SELECT @51 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title >= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T1 = @01 + @11 + @21 + @31 + @41 + @51

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

-- Wholesale Buyers
SELECT @07 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliates
SELECT @17 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Silver
SELECT @27 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Gold
SELECT @37 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Platinum
SELECT @47 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Emerald+
SELECT @57 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title >= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T7 = @07 + @17 + @27 + @37 + @47 + @57

-- ****************************************
-- Wholesale Buyers
SELECT @099 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 0 AND EnrollDate < @EndDate

-- Affiliates
SELECT @199 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 1 AND EnrollDate < @EndDate

-- Silver
SELECT @299 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 2 AND EnrollDate < @EndDate

-- Gold
SELECT @399 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 3 AND EnrollDate < @EndDate

-- Platinum
SELECT @499 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title = 4 AND EnrollDate < @EndDate

-- Emerald+
SELECT @599 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title >= 5 AND EnrollDate < @EndDate

-- Total Members
SET @T99 = @099 + @199 + @299 + @399 + @499 + @599

--select * from SalesOrder order by SalesOrderID desc

-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)

select @S1 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
 where so.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(10),@S1, 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

select @P1 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P1T = '$'+ CONVERT(varchar(10),@P1, 1)
SET @P1T = LEFT(@P1T, CHARINDEX('.', @P1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(10),@S7, 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

select @P7 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P7T = '$'+ CONVERT(varchar(10),@P7, 1)
SET @P7T = LEFT(@P7T, CHARINDEX('.', @P7T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(10),@S30, 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

select @P30 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @P30T = '$'+ CONVERT(varchar(10),@P30, 1)
SET @P30T = LEFT(@P30T, CHARINDEX('.', @P30T)-1 )

select @S99 = ISNULL(SUM(pa.Total),0) from Payment AS pa join SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID join Member AS me ON so.MemberID = me.MemberID
where so.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(10),@S99, 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

select @P99 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate < @EndDate
SET @P99T = '$'+ CONVERT(varchar(10),@P99, 1)
SET @P99T = LEFT(@P99T, CHARINDEX('.', @P99T)-1 )

-- ********* SUPPORT TICKETS ********************************************
-- 1.Submitted  2.Assigned  3.Resolved  4.Postponed  5.Total
-- a.1hr  b.4hr  c.12hr  d.1day  e.2day  f.3day  g.7day  h.14day t.total
-- **********************************************************************
DECLARE @Z1a int, @Z1b int, @Z1c int, @Z1d int, @Z1e int, @Z1f int, @Z1g int, @Z1h int, @Z1t int
DECLARE @Z2a int, @Z2b int, @Z2c int, @Z2d int, @Z2e int, @Z2f int, @Z2g int, @Z2h int, @Z2t int
DECLARE @Z3a int, @Z3b int, @Z3c int, @Z3d int, @Z3e int, @Z3f int, @Z3g int, @Z3h int, @Z3t int
DECLARE @Z4a int, @Z4b int, @Z4c int, @Z4d int, @Z4e int, @Z4f int, @Z4g int, @Z4h int, @Z4t int
DECLARE @Z5a int, @Z5b int, @Z5c int, @Z5d int, @Z5e int, @Z5f int, @Z5g int, @Z5h int, @Z5t int
SET	@Z1a=0 SET @Z1b=0 SET @Z1c=0 SET @Z1d=0 SET @Z1e=0 SET @Z1f=0 SET @Z1g=0 SET @Z1h=0 SET @Z1t=0  
SET	@Z2a=0 SET @Z2b=0 SET @Z2c=0 SET @Z2d=0 SET @Z2e=0 SET @Z2f=0 SET @Z2g=0 SET @Z2h=0 SET @Z2t=0  
SET	@Z3a=0 SET @Z3b=0 SET @Z3c=0 SET @Z3d=0 SET @Z3e=0 SET @Z3f=0 SET @Z3g=0 SET @Z3h=0 SET @Z3t=0  
SET	@Z4a=0 SET @Z4b=0 SET @Z4c=0 SET @Z4d=0 SET @Z4e=0 SET @Z4f=0 SET @Z4g=0 SET @Z4h=0 SET @Z4t=0  
SET	@Z5a=0 SET @Z5b=0 SET @Z5c=0 SET @Z5d=0 SET @Z5e=0 SET @Z5f=0 SET @Z5g=0 SET @Z5h=0 SET @Z5t=0  

SET @EndDate = GETDATE()
IF @Days > 0 SET @EndDate = DATEADD(d, @Days * -1, @EndDate)

-- ****** SUPPORT TICKETS 1 HR ******
SET @StartDate = DATEADD(hh, -1, @EndDate)
SELECT @Z1a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4a = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5a = @Z1a + @Z2a + @Z3a + @Z4a  

-- ****** SUPPORT TICKETS 4 HR ******
SET @StartDate = DATEADD(hh, -4, @EndDate)
SELECT @Z1b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4b = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5b = @Z1b + @Z2b + @Z3b + @Z4b  

-- ****** SUPPORT TICKETS 12 HR ******
SET @StartDate = DATEADD(hh, -12, @EndDate)
SELECT @Z1c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4c = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5c = @Z1c + @Z2c + @Z3c + @Z4c  

-- ****** SUPPORT TICKETS 1 DAY ******
SET @StartDate = DATEADD(d, -1, @EndDate)
SELECT @Z1d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4d = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5d = @Z1d + @Z2d + @Z3d + @Z4d  

-- ****** SUPPORT TICKETS 2 DAYS ******
SET @StartDate = DATEADD(d, -2, @EndDate)
SELECT @Z1e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4e = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5e = @Z1e + @Z2e + @Z3e + @Z4e  

-- ****** SUPPORT TICKETS 3 DAYS ******
SET @StartDate = DATEADD(d, -3, @EndDate)
SELECT @Z1f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4f = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5f = @Z1f + @Z2f + @Z3f + @Z4f  

-- ****** SUPPORT TICKETS 7 DAYS ******
SET @StartDate = DATEADD(d, -7, @EndDate)
SELECT @Z1g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4g = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5g = @Z1g + @Z2g + @Z3g + @Z4g  

-- ****** SUPPORT TICKETS 14 DAYS ******
SET @StartDate = DATEADD(d, -14, @EndDate)
SELECT @Z1h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z2h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z3h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SELECT @Z4h = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate >= @StartDate AND IssueDate < @EndDate
SET @Z5h = @Z1h + @Z2h + @Z3h + @Z4h  

-- ****** SUPPORT TICKETS TOTAL ******
SELECT @Z1t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status <= 1 AND IssueDate < @EndDate
SELECT @Z2t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 2 AND IssueDate < @EndDate
SELECT @Z3t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 3 AND IssueDate < @EndDate
SELECT @Z4t = ISNULL(COUNT(IssueID),0) FROM Issue WHERE CompanyID = @CompanyID AND Status = 4 AND IssueDate < @EndDate
SET @Z5t = @Z1t + @Z2t + @Z3t + @Z4t  


SET @Result = '<PTSSTATS ' + 
'm01="'  + CAST(@01 AS VARCHAR(10)) + '" ' +
'm07="'  + CAST(@07 AS VARCHAR(10))  + '" ' +
'm099="' + CAST(@099 AS VARCHAR(10)) + '" ' +
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
'm51="'  + CAST(@51 AS VARCHAR(10)) + '" ' +
'm57="'  + CAST(@57 AS VARCHAR(10))  + '" ' +
'm599="' + CAST(@599 AS VARCHAR(10)) + '" ' +
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
'z1a="'  + CAST(@Z1a AS VARCHAR(10)) + '" ' +
'z1b="'  + CAST(@Z1b AS VARCHAR(10)) + '" ' +
'z1c="'  + CAST(@Z1c AS VARCHAR(10)) + '" ' +
'z1d="'  + CAST(@Z1d AS VARCHAR(10)) + '" ' +
'z1e="'  + CAST(@Z1e AS VARCHAR(10)) + '" ' +
'z1f="'  + CAST(@Z1f AS VARCHAR(10)) + '" ' +
'z1g="'  + CAST(@Z1g AS VARCHAR(10)) + '" ' +
'z1h="'  + CAST(@Z1h AS VARCHAR(10)) + '" ' +
'z1t="'  + CAST(@Z1t AS VARCHAR(10)) + '" ' +
'z2a="'  + CAST(@Z2a AS VARCHAR(10)) + '" ' +
'z2b="'  + CAST(@Z2b AS VARCHAR(10)) + '" ' +
'z2c="'  + CAST(@Z2c AS VARCHAR(10)) + '" ' +
'z2d="'  + CAST(@Z2d AS VARCHAR(10)) + '" ' +
'z2e="'  + CAST(@Z2e AS VARCHAR(10)) + '" ' +
'z2f="'  + CAST(@Z2f AS VARCHAR(10)) + '" ' +
'z2g="'  + CAST(@Z2g AS VARCHAR(10)) + '" ' +
'z2h="'  + CAST(@Z2h AS VARCHAR(10)) + '" ' +
'z2t="'  + CAST(@Z2t AS VARCHAR(10)) + '" ' +
'z3a="'  + CAST(@Z3a AS VARCHAR(10)) + '" ' +
'z3b="'  + CAST(@Z3b AS VARCHAR(10)) + '" ' +
'z3c="'  + CAST(@Z3c AS VARCHAR(10)) + '" ' +
'z3d="'  + CAST(@Z3d AS VARCHAR(10)) + '" ' +
'z3e="'  + CAST(@Z3e AS VARCHAR(10)) + '" ' +
'z3f="'  + CAST(@Z3f AS VARCHAR(10)) + '" ' +
'z3g="'  + CAST(@Z3g AS VARCHAR(10)) + '" ' +
'z3h="'  + CAST(@Z3h AS VARCHAR(10)) + '" ' +
'z3t="'  + CAST(@Z3t AS VARCHAR(10)) + '" ' +
'z4a="'  + CAST(@Z4a AS VARCHAR(10)) + '" ' +
'z4b="'  + CAST(@Z4b AS VARCHAR(10)) + '" ' +
'z4c="'  + CAST(@Z4c AS VARCHAR(10)) + '" ' +
'z4d="'  + CAST(@Z4d AS VARCHAR(10)) + '" ' +
'z4e="'  + CAST(@Z4e AS VARCHAR(10)) + '" ' +
'z4f="'  + CAST(@Z4f AS VARCHAR(10)) + '" ' +
'z4g="'  + CAST(@Z4g AS VARCHAR(10)) + '" ' +
'z4h="'  + CAST(@Z4h AS VARCHAR(10)) + '" ' +
'z4t="'  + CAST(@Z4t AS VARCHAR(10)) + '" ' +
'z5a="'  + CAST(@Z5a AS VARCHAR(10)) + '" ' +
'z5b="'  + CAST(@Z5b AS VARCHAR(10)) + '" ' +
'z5c="'  + CAST(@Z5c AS VARCHAR(10)) + '" ' +
'z5d="'  + CAST(@Z5d AS VARCHAR(10)) + '" ' +
'z5e="'  + CAST(@Z5e AS VARCHAR(10)) + '" ' +
'z5f="'  + CAST(@Z5f AS VARCHAR(10)) + '" ' +
'z5g="'  + CAST(@Z5g AS VARCHAR(10)) + '" ' +
'z5h="'  + CAST(@Z5h AS VARCHAR(10)) + '" ' +
'z5t="'  + CAST(@Z5t AS VARCHAR(10)) + '" ' +
'/>'
GO

