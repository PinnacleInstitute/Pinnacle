EXEC [dbo].pts_CheckProc 'pts_Nexxus_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_Nexxus_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @90Date datetime, @Total int
DECLARE @M11 int, @M17 int, @M199 int
DECLARE @M21 int, @M27 int, @M299 int
DECLARE @M31 int, @M37 int, @M399 int
DECLARE @M41 int, @M47 int, @M499 int
DECLARE @M51 int, @M57 int, @M599 int
DECLARE @M61 int, @M67 int, @M699 int
DECLARE @M71 int, @M77 int, @M799 int
DECLARE @M81 int, @M87 int, @M899 int
DECLARE @A1 int, @A7 int, @A99 int
DECLARE @C1 int, @C7 int, @C99 int
DECLARE @T1 int, @T7 int, @T99 int
DECLARE @S1 money, @S7 money, @S30 money, @S99 money, @S100 money 
DECLARE @S1T varchar(15), @S7T varchar(15), @S30T varchar(15), @S99T varchar(15), @S100T varchar(15)
DECLARE @B1 money, @B7 money, @B30 money, @B99 money, @B100 money
DECLARE @B1T varchar(15), @B7T varchar(15), @B30T varchar(15), @B99T varchar(15), @B100T varchar(15)
DECLARE @W1 money, @W2 money, @W3 money, @W1T varchar(15), @W2T varchar(15), @W3T varchar(15)
DECLARE @W4 money, @W5 money, @W4T varchar(15), @W5T varchar(15)
DECLARE @AA int, @AC int, @AE int, @AV int

SET @CompanyID = 21

SET	@M11 = 0 SET	@M17 = 0 SET	@M199 = 0
SET	@M21 = 0 SET	@M27 = 0 SET	@M299 = 0
SET	@M31 = 0 SET	@M37 = 0 SET	@M399 = 0
SET	@M41 = 0 SET	@M47 = 0 SET	@M499 = 0
SET	@M51 = 0 SET	@M57 = 0 SET	@M599 = 0
SET	@M61 = 0 SET	@M67 = 0 SET	@M699 = 0
SET	@M71 = 0 SET	@M77 = 0 SET	@M799 = 0
SET	@M81 = 0 SET	@M87 = 0 SET	@M899 = 0
SET	@A1 = 0 SET	@A7 = 0 SET	@A99 = 0
SET	@C1 = 0 SET	@C7 = 0 SET	@C99 = 0
SET	@T1 = 0 SET	@T7 = 0 SET	@T99 = 0
SET @S1 = 0.0 SET @S7 = 0.0 SET @S30 = 0.0 SET @S99 = 0.0
SET @B1 = 0.0 SET @B7 = 0.0 SET @B30 = 0.0 SET @B99 = 0.0
SET @W1 = 0.0 SET @W2 = 0.0 SET @W3 = 0.0 SET @W4 = 0.0 SET @W5 = 0.0
SET @AA = 0 SET @AC = 0 SET @AE = 0 SET @AV = 0


SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now

-- Member
SELECT @M11 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 3 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliate
SELECT @M21 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- 1 Star
SELECT @M31 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- 2 Star
SELECT @M41 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- 3 Star
SELECT @M51 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Diamond
SELECT @M61 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (6,7,8) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Platinum
SELECT @M71 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (9,10,11) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Ambassador
SELECT @M81 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (12,13,14) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Suspended
SELECT @A1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (4,5) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Cancelled
SELECT @C1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (6,7) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Active Members
SET @T1 = @M21 + @M31 + @M41 + @M51 + @M61 + @M71 + @M81

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

-- Members
SELECT @M17 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 3 AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliates
SELECT @M27 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- 1 Star
SELECT @M37 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- 2 Star
SELECT @M47 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- 3 Star
SELECT @M57 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Diamond
SELECT @M67 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (6,7,8) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Platinum
SELECT @M77 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (9,10,11) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Ambassador
SELECT @M87 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (12,13,14) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Suspended
SELECT @A7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (4,5) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Cancelled
SELECT @C7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (6,7) AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Active Members
SET @T7 = @M27 + @M37 + @M47 + @M57 + @M67 + @M77 + @M87

-- ****************************************
-- Member
SELECT @M199 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 3 AND Title = 1 AND EnrollDate < @EndDate

-- Affiliate
SELECT @M299 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 2 AND EnrollDate < @EndDate

-- 1 Star
SELECT @M399 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 3 AND EnrollDate < @EndDate

-- 2 Star
SELECT @M499 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 4 AND EnrollDate < @EndDate

-- 3 Star
SELECT @M599 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title = 5 AND EnrollDate < @EndDate

-- Diamond
SELECT @M699 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (6,7,8) AND EnrollDate < @EndDate

-- Platinum
SELECT @M799 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (9,10,11) AND EnrollDate < @EndDate

-- Ambassador
SELECT @M899 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Title IN (12,13,14) AND EnrollDate < @EndDate

-- Suspended
SELECT @A99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (4,5) AND EnrollDate < @EndDate

-- Cancelled
SELECT @C99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (6,7) AND EnrollDate < @EndDate

-- Active Afiliate with Sales or Purchases in last 90 days
SET @90Date = DATEADD(day, -90, @EndDate)
SELECT @AA = ISNULL(COUNT(MemberID),0) FROM Member AS me
WHERE CompanyID = @CompanyID AND Status = 1 AND EnrollDate < @EndDate
AND 0 < (SELECT SUM(Amount) FROM Payment WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status = 3 AND PaidDate > @90Date )

-- Active Afiliate with Retailed Certificates in last 90 days
SELECT @AE = ISNULL(COUNT(MemberID),0) FROM Member AS me
WHERE CompanyID = @CompanyID AND Status = 1 AND EnrollDate < @EndDate
AND 0 < (SELECT COUNT(*) FROM Gift WHERE MemberID = me.MemberID AND Member2ID != 0 AND PaidDate > @90Date )

-- Active Afiliate visited/signed in last 90 days
SELECT @AV = ISNULL(COUNT(MemberID),0) FROM Member AS me
WHERE CompanyID = @CompanyID AND Status = 1 AND VisitDate > @90Date AND EnrollDate < @EndDate  

-- Total Active Members
SET @T99 = @M299 + @M399 + @M499 + @M599 + @M699 + @M799 + @M899

-- Calculate Customer to Affiliate Ratio
SET @AC = CAST( round((@M199 / CAST(@AE AS float)) * 100,0) AS INT)


--select * from SalesOrder order by SalesOrderID desc
-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)
select @S1 = ISNULL(SUM(pa.Total), 0) from Payment AS pa
where pa.CompanyID = @CompanyID AND pa.status = 3 AND pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
SET @S1T = '$'+ CONVERT(varchar(15),@S1, 1)
SET @S1T = LEFT(@S1T, CHARINDEX('.', @S1T)-1 )

select @B1 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B1T = '$'+ CONVERT(varchar(15),@B1, 1)
SET @B1T = LEFT(@B1T, CHARINDEX('.', @B1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S7 = ISNULL(SUM(pa.Total), 0) from Payment AS pa
where pa.CompanyID = @CompanyID AND pa.status = 3 AND pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
SET @S7T = '$'+ CONVERT(varchar(15),@S7, 1)
SET @S7T = LEFT(@S7T, CHARINDEX('.', @S7T)-1 )

select @B7 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B7T = '$'+ CONVERT(varchar(15),@B7, 1)
SET @B7T = LEFT(@B7T, CHARINDEX('.', @B7T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S30 = ISNULL(SUM(pa.Total), 0) from Payment AS pa
where pa.CompanyID = @CompanyID AND pa.status = 3 AND pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
SET @S30T = '$'+ CONVERT(varchar(15),@S30, 1)
SET @S30T = LEFT(@S30T, CHARINDEX('.', @S30T)-1 )

select @B30 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B30T = '$'+ CONVERT(varchar(15),@B30, 1)
SET @B30T = LEFT(@B30T, CHARINDEX('.', @B30T)-1 )

SET @StartDate = '1/1/17'
select @S99 = ISNULL(SUM(pa.Total), 0) from Payment AS pa
where pa.CompanyID = @CompanyID AND pa.status = 3 AND pa.PaidDate >= @StartDate AND pa.PaidDate < @EndDate
SET @S99T = '$'+ CONVERT(varchar(15),@S99, 1)
SET @S99T = LEFT(@S99T, CHARINDEX('.', @S99T)-1 )

select @S100 = ISNULL(SUM(pa.Total), 0) from Payment AS pa
where pa.CompanyID = @CompanyID AND pa.status = 3 AND pa.PaidDate < @EndDate
SET @S100T = '$'+ CONVERT(varchar(15),@S100, 1)
SET @S100T = LEFT(@S100T, CHARINDEX('.', @S100T)-1 )

select @B99 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B99T = '$'+ CONVERT(varchar(15),@B99, 1)
SET @B99T = LEFT(@B99T, CHARINDEX('.', @B99T)-1 )

select @B100 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate < @EndDate
SET @B100T = '$'+ CONVERT(varchar(15),@B100, 1)
SET @B100T = LEFT(@B100T, CHARINDEX('.', @B100T)-1 )

--************************
SELECT @W1 = ISNULL(SUM(Amount),0) FROM Payout WHERE CompanyID = @CompanyID AND Status IN (1,4,5,7) 
SET @W1T = '$'+ CONVERT(varchar(15),@W1, 1)
SET @W1T = LEFT(@W1T, CHARINDEX('.', @W1T)-1 )

SELECT @W2 = ABS(ISNULL(SUM(Amount),0)) FROM Payout WHERE CompanyID = @CompanyID AND Status IN (4,5)
SET @W2T = '$'+ CONVERT(varchar(15),@W2, 1)
SET @W2T = LEFT(@W2T, CHARINDEX('.', @W2T)-1 )

SELECT @W3 = ISNULL(SUM(Amount),0) FROM Payout WHERE CompanyID = @CompanyID AND Amount > 0 AND Status = 1
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

SET @Result = '<PTSSTATS ' + 
'm11="'  + CAST(@M11 AS varchar(15)) + '" ' +
'm17="'  + CAST(@M17 AS varchar(15))  + '" ' +
'm199="' + CAST(@M199 AS varchar(15)) + '" ' +
'm21="'  + CAST(@M21 AS varchar(15)) + '" ' +
'm27="'  + CAST(@M27 AS varchar(15))  + '" ' +
'm299="' + CAST(@M299 AS varchar(15)) + '" ' +
'm31="'  + CAST(@M31 AS varchar(15)) + '" ' +
'm37="'  + CAST(@M37 AS varchar(15))  + '" ' +
'm399="' + CAST(@M399 AS varchar(15)) + '" ' +
'm41="'  + CAST(@M41 AS varchar(15)) + '" ' +
'm47="'  + CAST(@M47 AS varchar(15))  + '" ' +
'm499="' + CAST(@M499 AS varchar(15)) + '" ' +
'm51="'  + CAST(@M51 AS varchar(15)) + '" ' +
'm57="'  + CAST(@M57 AS varchar(15))  + '" ' +
'm599="' + CAST(@M599 AS varchar(15)) + '" ' +
'm61="'  + CAST(@M61 AS varchar(15)) + '" ' +
'm67="'  + CAST(@M67 AS varchar(15))  + '" ' +
'm699="' + CAST(@M699 AS varchar(15)) + '" ' +
'm71="'  + CAST(@M71 AS varchar(15)) + '" ' +
'm77="'  + CAST(@M77 AS varchar(15))  + '" ' +
'm799="' + CAST(@M799 AS varchar(15)) + '" ' +
'm81="'  + CAST(@M81 AS varchar(15)) + '" ' +
'm87="'  + CAST(@M87 AS varchar(15))  + '" ' +
'm899="' + CAST(@M899 AS varchar(15)) + '" ' +
'aa="'  + CAST(@AA AS varchar(15)) + '" ' +
'ac="'  + CAST(@AC AS varchar(15)) + '%" ' +
'ae="'  + CAST(@AE AS varchar(15)) + '" ' +
'av="'  + CAST(@AV AS varchar(15)) + '" ' +
'a1="'  + CAST(@A1 AS varchar(15)) + '" ' +
'a7="'  + CAST(@A7 AS varchar(15))  + '" ' +
'a99="' + CAST(@A99 AS varchar(15)) + '" ' +
'c1="'  + CAST(@C1 AS varchar(15)) + '" ' +
'c7="'  + CAST(@C7 AS varchar(15))  + '" ' +
'c99="' + CAST(@C99 AS varchar(15)) + '" ' +
't1="'  + CAST(@T1 AS varchar(15)) + '" ' +
't7="'  + CAST(@T7 AS varchar(15))  + '" ' +
't99="' + CAST(@T99 AS varchar(15)) + '" ' +
's1="'      + @S1T + '" ' +
's7="'      + @S7T + '" ' +
's30="'     + @S30T + '" ' +
's99="'     + @S99T + '" ' +
's100="'    + @S100T + '" ' +
'b1="'       + @B1T + '" ' +
'b7="'       + @B7T + '" ' +
'b30="'      + @B30T + '" ' +
'b99="'      + @B99T + '" ' +
'b100="'     + @B100T + '" ' +
'w1="'       + @W1T + '" ' +
'w2="'       + @W2T + '" ' +
'w3="'       + @W3T + '" ' +
'w4="'       + @W4T + '" ' +
'w5="'       + @W5T + '" ' +
'/>'
GO

