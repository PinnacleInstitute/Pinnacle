EXEC [dbo].pts_CheckProc 'pts_TellAll_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_TellAll_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_TellAll_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @Total int
DECLARE @M11 int, @M17 int, @M199 int
DECLARE @M21 int, @M27 int, @M299 int
DECLARE @M31 int, @M37 int, @M399 int
DECLARE @M41 int, @M47 int, @M499 int
DECLARE @M51 int, @M57 int, @M599 int
DECLARE @M61 int, @M67 int, @M699 int
DECLARE @T1 int, @T7 int, @T99 int
DECLARE @S1 money, @S7 money, @S30 money, @S99 money, @S1T varchar(15), @S7T varchar(15), @S30T varchar(15), @S99T varchar(15)
DECLARE @B1 money, @B7 money, @B30 money, @B99 money, @B1T varchar(15), @B7T varchar(15), @B30T varchar(15), @B99T varchar(15)

SET @CompanyID = 19

SET	@M11 = 0 SET	@M17 = 0 SET	@M199 = 0
SET	@M21 = 0 SET	@M27 = 0 SET	@M299 = 0
SET	@M31 = 0 SET	@M37 = 0 SET	@M399 = 0
SET	@M41 = 0 SET	@M47 = 0 SET	@M499 = 0
SET	@M51 = 0 SET	@M57 = 0 SET	@M599 = 0
SET	@M61 = 0 SET	@M67 = 0 SET	@M699 = 0
SET	@T1 = 0 SET	@T7 = 0 SET	@T99 = 0
SET @S1 = 0.0 SET @S7 = 0.0 SET @S30 = 0.0 SET @S99 = 0.0
SET @B1 = 0.0 SET @B7 = 0.0 SET @B30 = 0.0 SET @B99 = 0.0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now

-- Affiliate
SELECT @M11 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Qualified Affiliate
SELECT @M21 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Senior Affiliate
SELECT @M31 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliate Trainer
SELECT @M41 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Team Leader
SELECT @M51 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Sales Manager+
SELECT @M61 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title >= 6 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T1 = @M11 + @M21 + @M31 + @M41 + @M51 + @M61

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

-- Affiliate
SELECT @M17 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Qualified Affiliate
SELECT @M27 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Senior Affiliate
SELECT @M37 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliate Trainer
SELECT @M47 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Team Leader
SELECT @M57 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Sales Manager+
SELECT @M67 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title >= 6 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T7 = @M17 + @M27 + @M37 + @M47 + @M57 + @M67

-- ****************************************
-- Affiliate
SELECT @M199 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 1 AND EnrollDate < @EndDate

-- Qualified Affiliate
SELECT @M299 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 2 AND EnrollDate < @EndDate

-- Senior Affiliate
SELECT @M399 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 3 AND EnrollDate < @EndDate

-- Affiliate Trainer
SELECT @M499 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 4 AND EnrollDate < @EndDate

-- Team Leader
SELECT @M599 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 5 AND EnrollDate < @EndDate

-- Sales Manager+
SELECT @M699 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title >= 6 AND EnrollDate < @EndDate

-- Total Members
SET @T99 = @M199 + @M299 + @M399 + @M499 + @M599 + @M699

--select * from SalesOrder order by SalesOrderID desc
-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)

select @S1 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
 where me.CompanyID = @CompanyID and pa.status = 1 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(10),@S1, 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

select @B1 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B1T = '$'+ CONVERT(varchar(10),@B1, 1)
SET @B1T = LEFT(@B1T, CHARINDEX('.', @B1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 1 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(10),@S7, 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

select @B7 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B7T = '$'+ CONVERT(varchar(10),@B7, 1)
SET @B7T = LEFT(@B7T, CHARINDEX('.', @B7T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 1 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(10),@S30, 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

select @B30 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B30T = '$'+ CONVERT(varchar(10),@B30, 1)
SET @B30T = LEFT(@B30T, CHARINDEX('.', @B30T)-1 )

select @S99 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 1 and pa.PayDate >= '1/1/14' and pa.PayDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(10),@S99, 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

select @B99 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate < @EndDate
SET @B99T = '$'+ CONVERT(varchar(10),@B99, 1)
SET @B99T = LEFT(@B99T, CHARINDEX('.', @B99T)-1 )

SET @Result = '<PTSSTATS ' + 
'm11="'  + CAST(@M11 AS VARCHAR(10)) + '" ' +
'm17="'  + CAST(@M17 AS VARCHAR(10))  + '" ' +
'm199="' + CAST(@M199 AS VARCHAR(10)) + '" ' +
'm21="'  + CAST(@M21 AS VARCHAR(10)) + '" ' +
'm27="'  + CAST(@M27 AS VARCHAR(10))  + '" ' +
'm299="' + CAST(@M299 AS VARCHAR(10)) + '" ' +
'm31="'  + CAST(@M31 AS VARCHAR(10)) + '" ' +
'm37="'  + CAST(@M37 AS VARCHAR(10))  + '" ' +
'm399="' + CAST(@M399 AS VARCHAR(10)) + '" ' +
'm41="'  + CAST(@M41 AS VARCHAR(10)) + '" ' +
'm47="'  + CAST(@M47 AS VARCHAR(10))  + '" ' +
'm499="' + CAST(@M499 AS VARCHAR(10)) + '" ' +
'm51="'  + CAST(@M51 AS VARCHAR(10)) + '" ' +
'm57="'  + CAST(@M57 AS VARCHAR(10))  + '" ' +
'm599="' + CAST(@M599 AS VARCHAR(10)) + '" ' +
'm61="'  + CAST(@M61 AS VARCHAR(10)) + '" ' +
'm67="'  + CAST(@M67 AS VARCHAR(10))  + '" ' +
'm699="' + CAST(@M699 AS VARCHAR(10)) + '" ' +
't1="'  + CAST(@T1 AS VARCHAR(10)) + '" ' +
't7="'  + CAST(@T7 AS VARCHAR(10))  + '" ' +
't99="' + CAST(@T99 AS VARCHAR(10)) + '" ' +
's1="'      + @S1T + '" ' +
's7="'      + @S7T + '" ' +
's30="'     + @S30T + '" ' +
's99="'     + @S99T + '" ' +
'b1="'       + @B1T + '" ' +
'b7="'       + @B7T + '" ' +
'b30="'      + @B30T + '" ' +
'b99="'      + @B99T + '" ' +
'/>'
GO

