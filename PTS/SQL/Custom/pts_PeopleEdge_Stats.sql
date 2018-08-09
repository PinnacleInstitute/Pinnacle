EXEC [dbo].pts_CheckProc 'pts_PeopleEdge_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_PeopleEdge_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_PeopleEdge_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @Total int
DECLARE @M0_1 int, @M0_7 int, @M0_99 int
DECLARE @M1_1 int, @M1_7 int, @M1_99 int
DECLARE @M2_1 int, @M2_7 int, @M2_99 int
DECLARE @M3_1 int, @M3_7 int, @M3_99 int
DECLARE @M4_1 int, @M4_7 int, @M4_99 int
DECLARE @T1 int, @T2 int, @T3 int, @T4 int, @T5 int, @T6 int, @T7 int, @T99 int
DECLARE @S1 money, @S7 money, @S30 money, @S99 money, @S1T varchar(15), @S7T varchar(15), @S30T varchar(15), @S99T varchar(15)
DECLARE @F2 int, @F3 int

SET @CompanyID = 16

SET	@M0_1 = 0  SET @M0_7 = 0  SET @M0_99 = 0
SET	@M1_1 = 0  SET @M1_7 = 0  SET @M1_99 = 0
SET	@M2_1 = 0  SET @M2_7 = 0  SET @M2_99 = 0
SET	@M3_1 = 0  SET @M3_7 = 0  SET @M3_99 = 0
SET	@M4_1 = 0  SET @M4_7 = 0  SET @M4_99 = 0
SET	@T1 = 0 SET @T2 = 0 SET @T3 = 0 SET @T4 = 0 SET @T5 = 0 SET @T6 = 0 SET @T7 = 0 SET @T99 = 0
SET @S1 = 0.0
SET @S7 = 0.0
SET @S30 = 0.0
SET @S99 = 0.0
SET	@F2 = 0  SET @F3 = 0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	****** ENROLLMENTS TODAY ******
SET @StartDate = @Now

SELECT @M0_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 0 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @M1_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @M2_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 2 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @M3_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 3 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SET @M4_1 = @M0_1 + @M1_1 + @M2_1 + @M3_1  

--	****** ENROLLMENTS 7 DAYS ******
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

SELECT @M0_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 0 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @M1_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @M2_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 2 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @M3_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 3 AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SET @M4_7 = @M0_7 + @M1_7 + @M2_7 + @M3_7  

--	****** ENROLLMENTS TOTAL ******
SELECT @M0_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 0 AND Status >= 1 AND Status <= 3 AND EnrollDate < @EndDate

SELECT @M1_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 3 AND EnrollDate < @EndDate

SELECT @M2_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 2 AND Status >= 1 AND Status <= 3 AND EnrollDate < @EndDate

SELECT @M3_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  CompanyID = @CompanyID AND [Level] = 3 AND Status >= 1 AND Status <= 3 AND EnrollDate < @EndDate

SET @M4_99 = @M0_99 + @M1_99 + @M2_99 + @M3_99  

-- ****** MEMBERSHIP STATUS ******
SELECT @T1 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 3 AND EnrollDate < @EndDate
--SELECT @T2 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status = 2 AND EnrollDate < @EndDate
--SELECT @T3 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status = 3 AND EnrollDate < @EndDate
SELECT @T4 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status = 4 AND EnrollDate < @EndDate
SELECT @T5 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status = 5 AND EnrollDate < @EndDate
SELECT @T6 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status = 6 AND EnrollDate < @EndDate
SELECT @T7 = ISNULL(COUNT(MemberID),0) FROM Member WHERE CompanyID = @CompanyID AND Status = 7 AND EnrollDate < @EndDate
SET @T99 = @T1 + @T2 + @T3 + @T4 + @T5 + @T6 + @T7

-- ****** SALES TODAY ******
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)
select @S1 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
 where me.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(10),ROUND(@S1,0), 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

-- ****** SALES 7 DAYS ******
SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(10),ROUND(@S7,0), 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

-- ****** SALES 30 DAYS ******
SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(10),ROUND(@S30,0), 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

-- ****** SALES TOTAL ******
select @S99 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 3 and pa.PayDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(10),ROUND(@S99,0), 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

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

-- ****** FREE LEADERSHIP MEMBERSHIPS ******
SELECT @F2 = COUNT(me.MemberID) FROM Member AS me WHERE me.CompanyID = 7 AND me.level = 2 AND me.Status >= 1 AND me.Status <= 4
AND 4 <= (SELECT COUNT(MemberID) FROM Member WHERE ReferralID = me.MemberID AND level = 2 AND Status >= 1 AND Status <= 4)

-- ****** FREE BASIC MEMBERSHIPS ******
SELECT @F3 = COUNT(me.MemberID) FROM Member AS me WHERE me.CompanyID = 7 AND me.level = 3 AND me.Status >= 1 AND me.Status <= 4
AND 4 <= (SELECT COUNT(MemberID) FROM Member WHERE ReferralID = me.MemberID AND (level = 2 OR Level = 3) AND Status >= 1 AND Status <= 4)


SET @Result = '<PTSSTATS ' + 
'm0_1="'  + CAST(@M0_1 AS VARCHAR(10)) + '" ' +
'm1_1="'  + CAST(@M1_1 AS VARCHAR(10)) + '" ' +
'm2_1="'  + CAST(@M2_1 AS VARCHAR(10)) + '" ' +
'm3_1="'  + CAST(@M3_1 AS VARCHAR(10)) + '" ' +
'm4_1="'  + CAST(@M4_1 AS VARCHAR(10)) + '" ' +
'm0_7="'  + CAST(@M0_7 AS VARCHAR(10)) + '" ' +
'm1_7="'  + CAST(@M1_7 AS VARCHAR(10)) + '" ' +
'm2_7="'  + CAST(@M2_7 AS VARCHAR(10)) + '" ' +
'm3_7="'  + CAST(@M3_7 AS VARCHAR(10)) + '" ' +
'm4_7="'  + CAST(@M4_7 AS VARCHAR(10)) + '" ' +
'm0_99="'  + CAST(@M0_99 AS VARCHAR(10)) + '" ' +
'm1_99="'  + CAST(@M1_99 AS VARCHAR(10)) + '" ' +
'm2_99="'  + CAST(@M2_99 AS VARCHAR(10)) + '" ' +
'm3_99="'  + CAST(@M3_99 AS VARCHAR(10)) + '" ' +
'm4_99="'  + CAST(@M4_99 AS VARCHAR(10)) + '" ' +
't1="'  + CAST(@T1 AS VARCHAR(10)) + '" ' +
't2="'  + CAST(@T2 AS VARCHAR(10)) + '" ' +
't3="'  + CAST(@T3 AS VARCHAR(10)) + '" ' +
't4="'  + CAST(@T4 AS VARCHAR(10)) + '" ' +
't5="'  + CAST(@T5 AS VARCHAR(10)) + '" ' +
't6="'  + CAST(@T6 AS VARCHAR(10)) + '" ' +
't7="'  + CAST(@T7 AS VARCHAR(10)) + '" ' +
't99="'  + CAST(@T99 AS VARCHAR(10)) + '" ' +
's1="'       + @S1T + '" ' +
's7="'       + @S7T + '" ' +
's30="'      + @S30T + '" ' +
's99="'      + @S99T + '" ' +
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
'f2="'  + CAST(@F2 AS VARCHAR(10)) + '" ' +
'f3="'  + CAST(@F3 AS VARCHAR(10)) + '" ' +
'/>'
GO

