EXEC [dbo].pts_CheckProc 'pts_CloudZow_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_CloudZow_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@Now datetime, @StartDate datetime, @EndDate datetime, @Total int
-- R=Resellers, A=Affiliates, C=Customers, 
-- RC = Reseller Computers, AC = Affiliate Computers, CC = Customer Computers
-- RCA = Reseller Computer Average, ACA = Affiliate Computer Average, CCA = Customer Computer Average 
DECLARE 
@RToday int,
@RWeek int,
@RTotal int,
@AToday int,
@AWeek int,
@ATotal int,
@FToday int,
@FWeek int,
@FTotal int,
@CToday int,
@CWeek int,
@CTotal int,
@RCToday int,
@RCWeek int,
@RCTotal int,
@ACToday int,
@ACWeek int,
@ACTotal int,
@CCToday int,
@CCWeek int,
@CCTotal int,
@RCAToday decimal(5,2),
@RCAWeek decimal(5,2),
@RCATotal decimal(5,2),
@ACAToday decimal(5,2),
@ACAWeek decimal(5,2),
@ACATotal decimal(5,2),
@CCAToday decimal(5,2),
@CCAWeek decimal(5,2),
@CCATotal decimal(5,2),
@T7 int,
@T30 int,
@T99 int,
@I7 int,
@I30 int,
@I99 int,
@C7 int,
@C30 int,
@C99 int,
@A7 int,
@A30 int,
@A99 int,
@Z7 decimal(5,2),
@Z30 decimal(5,2),
@Z99 decimal(5,2),
@V7 decimal(5,2),
@V30 decimal(5,2),
@V99 decimal(5,2),
@S1 money,
@S7 money,
@S30 money,
@S99 money,
@S1T varchar(15),
@S7T varchar(15),
@S30T varchar(15),
@S99T varchar(15),
@SC money,
@SR money,
@SA money,
@ST money,
@P1 money,
@P2 money,
@PT money,
@SCT varchar(15),
@SRT varchar(15),
@SAT varchar(15),
@STT varchar(15),
@P1T varchar(15),
@P2T varchar(15),
@PTT varchar(15)


SET	@RToday = 0
SET	@RWeek = 0 
SET	@RTotal = 0 
SET	@AToday = 0
SET	@AWeek = 0 
SET	@ATotal = 0 
SET	@FToday = 0
SET	@FWeek = 0 
SET	@FTotal = 0 
SET	@CToday = 0
SET	@CWeek = 0
SET	@CTotal = 0
SET	@RCToday = 0
SET	@RCWeek = 0 
SET	@RCTotal = 0 
SET	@ACToday = 0
SET	@ACWeek = 0 
SET	@ACTotal = 0 
SET	@CCToday = 0
SET	@CCWeek = 0
SET	@CCTotal = 0
SET	@RCAToday = 0.0
SET	@RCAWeek = 0.0 
SET	@RCATotal = 0.0 
SET	@ACAToday = 0.0
SET	@ACAWeek = 0.0 
SET	@ACATotal = 0.0 
SET	@CCAToday = 0.0
SET	@CCAWeek = 0.0
SET	@CCATotal = 0.0
SET @T7 = 0
SET @T30 = 0
SET @T99 = 0
SET @I7 = 0
SET @I30 = 0
SET @I99 = 0
SET @C7 = 0
SET @C30 = 0
SET @C99 = 0
SET @A7 = 0
SET @A30 = 0
SET @A99 = 0
SET @Z7 = 0.0
SET @Z30 = 0.0
SET @Z99 = 0.0
SET @V7 = 0.0
SET @V30 = 0.0
SET @V99 = 0.0
SET @S1 = 0.0
SET @S7 = 0.0
SET @S30 = 0.0
SET @S99 = 0.0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now

SELECT @RToday = ISNULL(COUNT(MemberID),0), @RCToday = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @RToday > 0 SET @RCAToday = @RCToday / CAST(@RToday AS decimal(10,2)) 

SELECT @AToday = ISNULL(COUNT(MemberID),0), @ACToday = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate  AND GroupID <> 100
IF @AToday > 0 SET @ACAToday = @ACToday / CAST(@AToday AS decimal(10,2)) 

SELECT @AToday = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate  AND GroupID <> 100 AND IsMaster = 0

SELECT @FToday = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate  AND GroupID <> 100 AND IsMaster != 0

SELECT @CToday = ISNULL(COUNT(MemberID),0), @CCToday = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 0 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate  AND GroupID <> 100
IF @CToday > 0 SET @CCAToday = @CCToday / CAST(@CToday AS decimal(10,2))

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

SELECT @RWeek = ISNULL(COUNT(MemberID),0), @RCWeek = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @RWeek > 0 SET @RCAWeek = @RCWeek / CAST(@RWeek AS decimal(10,2))

SELECT @AWeek = ISNULL(COUNT(MemberID),0), @ACWeek = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @AWeek > 0 SET @ACAWeek = @ACWeek / CAST(@AWeek AS decimal(10,2))

SELECT @AWeek = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100 AND IsMaster = 0

SELECT @FWeek = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100 AND IsMaster != 0

SELECT @CWeek = ISNULL(COUNT(MemberID),0), @CCWeek = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 0 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @CWeek > 0 SET @CCAWeek = @CCWeek / CAST(@CWeek AS decimal(10,2))

-- ****************************************
SELECT @RTotal = ISNULL(COUNT(MemberID),0), @RCTotal = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title = 1 AND EnrollDate < @EndDate AND GroupID <> 100
IF @RTotal > 0 SET @RCATotal = @RCTotal / CAST(@RTotal AS decimal(10,2))

SELECT @ATotal = ISNULL(COUNT(MemberID),0), @ACTotal = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate < @EndDate AND GroupID <> 100
IF @ATotal > 0 SET @ACATotal = @ACTotal / CAST(@ATotal AS decimal(10,2))

SELECT @ATotal = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate < @EndDate AND GroupID <> 100 AND IsMaster = 0

SELECT @FTotal = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND Title > 1 AND EnrollDate < @EndDate AND GroupID <> 100 AND IsMaster != 0

SELECT @CTotal = ISNULL(COUNT(MemberID),0), @CCTotal = ISNULL(SUM(Process),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 0 AND Status >= 1 AND Status <= 5 AND EnrollDate < @EndDate AND GroupID <> 100
IF @CTotal > 0 SET @CCATotal = @CCTotal / CAST(@CTotal AS decimal(10,2))

-- ** Customers **************************************
SET @EndDate = DATEADD(d, -14, @Now)
SET @StartDate = DATEADD(d, -7, @EndDate)
SELECT @T7 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
SELECT @I7 = ISNULL(COUNT(MemberID),0) FROM Member AS me
WHERE  CompanyID = 5 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
AND (SELECT COUNT(*) FROM Machine WHERE MemberID = me.MemberID AND BackupUsed <> '0 B' AND BackupUsed <> '') > 0
SELECT @C7 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 0 AND Status = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
SELECT @A7 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @T7 > 0 SET @Z7 = @I7 / CAST(@T7 AS decimal(10,2))
SET @Total = @C7 + @A7
IF @I7 > 0 SET @V7 = @Total / CAST(@I7 AS decimal(10,2))

SET @StartDate = DATEADD(d, -30, @EndDate)
SELECT @T30 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
SELECT @I30 = ISNULL(COUNT(MemberID),0) FROM Member AS me
WHERE  CompanyID = 5 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
AND (SELECT COUNT(*) FROM Machine WHERE MemberID = me.MemberID AND BackupUsed <> '0 B' AND BackupUsed <> '') > 0
SELECT @C30 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 0 AND Status = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
SELECT @A30 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @T30 > 0 SET @Z30 = @I30 / CAST(@T30 AS decimal(10,2))
SET @Total = @C30 + @A30
IF @I30 > 0 SET @V30 = @Total / CAST(@I30 AS decimal(10,2))

SET @StartDate = '4/1/12'
SELECT @T99 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
SELECT @I99 = ISNULL(COUNT(MemberID),0) FROM Member AS me
WHERE  CompanyID = 5 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
AND (SELECT COUNT(*) FROM Machine WHERE MemberID = me.MemberID AND BackupUsed <> '0 B' AND BackupUsed <> '') > 0
SELECT @C99 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 0 AND Status = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
SELECT @A99 = ISNULL(COUNT(MemberID),0) FROM Member 
WHERE  CompanyID = 5 AND [Level] = 1 AND TrialDays > 0 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate AND GroupID <> 100
IF @T99 > 0 SET @Z99 = @I99 / CAST(@T99 AS decimal(10,2))
SET @Total = @C99 + @A99
IF @I99 > 0 SET @V99 = @Total / CAST(@I99 AS decimal(10,2))

-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)
select @S1 = ISNULL(SUM(Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND OwnerID = me.MemberID
 where me.CompanyID = 5 and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(10),@S1, 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND OwnerID = me.MemberID
where me.CompanyID = 5 and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(10),@S7, 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND OwnerID = me.MemberID
where me.CompanyID = 5 and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(10),@S30, 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

SET @StartDate = '4/1/12'
select @S99 = ISNULL(SUM(Total),0) from Payment AS pa join Member AS me ON pa.OwnerType = 4 AND OwnerID = me.MemberID
where me.CompanyID = 5 and pa.status = 3 and pa.PayDate >= @StartDate and pa.PayDate < @EndDate
--select @S99 = ISNULL(SUM(Total),0) from Payment where status = 3 and PayDate >= @StartDate and PayDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(10),@S99, 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

-- ** Sales per Type **************************************
SET @EndDate = DATEADD(d, 1, @Now)
select @SC = ISNULL(SUM(Price),0) from Member where CompanyID = 5 AND Status = 1 AND Level = 0 AND GroupID <> 100 AND Billing = 3 AND EnrollDate < @EndDate
SET @SCT = '$'+ CONVERT(varchar(10),@SC, 1)
SET @SCT = LEFT(@SCT, CHARINDEX('.', @SCT)-1 )

select @SR = ISNULL(SUM(Price),0) from Member where CompanyID = 5 AND Status = 1 AND Level = 1 AND Title <= 1 AND GroupID <> 100 AND Billing = 3 AND EnrollDate < @EndDate
SET @SRT = '$'+ CONVERT(varchar(10),@SR, 1)
SET @SRT = LEFT(@SRT, CHARINDEX('.', @SRT)-1 )

select @SA = ISNULL(SUM(Price),0) from Member where CompanyID = 5 AND Status = 1 AND Level = 1  AND Title > 1 AND GroupID <> 100 AND Billing = 3 AND EnrollDate < @EndDate
SET @SAT = '$'+ CONVERT(varchar(10),@SA, 1)
SET @SAT = LEFT(@SAT, CHARINDEX('.', @SAT)-1 )

select @ST = @SC + @SR + @SA
SET @STT = '$'+ CONVERT(varchar(10),@ST, 1)
SET @STT = LEFT(@STT, CHARINDEX('.', @STT)-1 )

select @P1 = ISNULL(SUM(Price),0) from Member where CompanyID = 5 AND Status = 2 AND Level = 0 AND GroupID <> 100 AND Billing = 3 AND EnrollDate < @EndDate
SET @P1T = '$'+ CONVERT(varchar(10),@P1, 1)
SET @P1T = LEFT(@P1T, CHARINDEX('.', @P1T)-1 )

select @P2 = ISNULL(SUM(Price),0) from Member where CompanyID = 5 AND Status = 4 AND Level = 1 AND GroupID <> 100 AND Billing = 3 AND EnrollDate < @EndDate
SET @P2T = '$'+ CONVERT(varchar(10),@P2, 1)
SET @P2T = LEFT(@P2T, CHARINDEX('.', @P2T)-1 )

select @PT = @P1 + @P2
SET @PTT = '$'+ CONVERT(varchar(10),@PT, 1)
SET @PTT = LEFT(@PTT, CHARINDEX('.', @PTT)-1 )

--DECLARE @Result varchar(1000) EXEC pts_CloudZow_Stats 0, @Result OUTPUT print @Result

SET @Result = '<PTSSTATS ' + 
'rtoday="' + CAST(@RToday AS VARCHAR(10)) + '" ' +
'rweek="'  + CAST(@RWeek AS VARCHAR(10))  + '" ' +
'rtotal="' + CAST(@RTotal AS VARCHAR(10)) + '" ' +
'atoday="' + CAST(@AToday AS VARCHAR(10)) + '" ' +
'aweek="'  + CAST(@AWeek AS VARCHAR(10))  + '" ' +
'atotal="' + CAST(@ATotal AS VARCHAR(10)) + '" ' +
'ftoday="' + CAST(@FToday AS VARCHAR(10)) + '" ' +
'fweek="'  + CAST(@FWeek AS VARCHAR(10))  + '" ' +
'ftotal="' + CAST(@FTotal AS VARCHAR(10)) + '" ' +
'ctoday="'  + CAST(@CToday AS VARCHAR(10)) + '" ' +
'cweek="'   + CAST(@CWeek AS VARCHAR(10))  + '" ' +
'ctotal="'  + CAST(@CTotal AS VARCHAR(10)) + '" ' +
'rctoday="' + CAST(@RCToday AS VARCHAR(10)) + '" ' +
'rcweek="'  + CAST(@RCWeek AS VARCHAR(10))  + '" ' +
'rctotal="' + CAST(@RCTotal AS VARCHAR(10)) + '" ' +
'actoday="' + CAST(@ACToday AS VARCHAR(10)) + '" ' +
'acweek="'  + CAST(@ACWeek AS VARCHAR(10))  + '" ' +
'actotal="' + CAST(@ACTotal AS VARCHAR(10)) + '" ' +
'cctoday="'  + CAST(@CCToday AS VARCHAR(10)) + '" ' +
'ccweek="'   + CAST(@CCWeek AS VARCHAR(10))  + '" ' +
'cctotal="'  + CAST(@CCTotal AS VARCHAR(10)) + '" ' +
'rcatoday="' + CAST(@RCAToday AS VARCHAR(10)) + '" ' +
'rcaweek="'  + CAST(@RCAWeek AS VARCHAR(10))  + '" ' +
'rcatotal="' + CAST(@RCATotal AS VARCHAR(10)) + '" ' +
'acatoday="' + CAST(@ACAToday AS VARCHAR(10)) + '" ' +
'acaweek="'  + CAST(@ACAWeek AS VARCHAR(10))  + '" ' +
'acatotal="' + CAST(@ACATotal AS VARCHAR(10)) + '" ' +
'ccatoday="' + CAST(@CCAToday AS VARCHAR(10)) + '" ' +
'ccaweek="'  + CAST(@CCAWeek AS VARCHAR(10))  + '" ' +
'ccatotal="' + CAST(@CCATotal AS VARCHAR(10)) + '" ' +
't7="'       + CAST(@T7 AS VARCHAR(10)) + '" ' +
't30="'      + CAST(@T30 AS VARCHAR(10))  + '" ' +
't99="'      + CAST(@T99 AS VARCHAR(10)) + '" ' +
'i7="'       + CAST(@I7 AS VARCHAR(10)) + '" ' +
'i30="'      + CAST(@I30 AS VARCHAR(10))  + '" ' +
'i99="'      + CAST(@I99 AS VARCHAR(10)) + '" ' +
'c7="'       + CAST(@C7 AS VARCHAR(10)) + '" ' +
'c30="'      + CAST(@C30 AS VARCHAR(10))  + '" ' +
'c99="'      + CAST(@C99 AS VARCHAR(10)) + '" ' +
'a7="'       + CAST(@A7 AS VARCHAR(10)) + '" ' +
'a30="'      + CAST(@A30 AS VARCHAR(10))  + '" ' +
'a99="'      + CAST(@A99 AS VARCHAR(10)) + '" ' +
'z7="'      + CAST(@Z7 AS VARCHAR(10)) + '" ' +
'z30="'     + CAST(@Z30 AS VARCHAR(10))  + '" ' +
'z99="'     + CAST(@Z99 AS VARCHAR(10)) + '" ' +
'v7="'       + CAST(@V7 AS VARCHAR(10)) + '" ' +
'v30="'      + CAST(@V30 AS VARCHAR(10))  + '" ' +
'v99="'      + CAST(@V99 AS VARCHAR(10)) + '" ' +
's1="'       + @S1T + '" ' +
's7="'       + @S7T + '" ' +
's30="'      + @S30T + '" ' +
's99="'      + @S99T + '" ' +
'sc="'       + @SCT + '" ' +
'sr="'       + @SRT + '" ' +
'sa="'      + @SAT + '" ' +
'st="'      + @STT + '" ' +
'p1="'       + @P1T + '" ' +
'p2="'      + @P2T + '" ' +
'pt="'      + @PTT + '" ' +
'/>'
GO

