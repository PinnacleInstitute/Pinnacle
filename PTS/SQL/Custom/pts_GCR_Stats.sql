EXEC [dbo].pts_CheckProc 'pts_GCR_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_GCR_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_GCR_Stats
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
DECLARE @A1 int, @A7 int, @A99 int
DECLARE @C1 int, @C7 int, @C99 int
DECLARE @T1 int, @T7 int, @T99 int
DECLARE @S11 money, @S17 money, @S130 money, @S199 money, @S11T varchar(15), @S17T varchar(15), @S130T varchar(15), @S199T varchar(15)
DECLARE @S21 money, @S27 money, @S230 money, @S299 money, @S21T varchar(15), @S27T varchar(15), @S230T varchar(15), @S299T varchar(15)
DECLARE @S31 money, @S37 money, @S330 money, @S399 money, @S31T varchar(15), @S37T varchar(15), @S330T varchar(15), @S399T varchar(15)
DECLARE @B1 money, @B7 money, @B30 money, @B99 money, @B1T varchar(15), @B7T varchar(15), @B30T varchar(15), @B99T varchar(15)
DECLARE @W1 money, @W2 money, @W3 money, @W1T varchar(15), @W2T varchar(15), @W3T varchar(15)
DECLARE @W4 money, @W5 money, @W4T varchar(15), @W5T varchar(15)

SET @CompanyID = 17

SET	@M11 = 0 SET	@M17 = 0 SET	@M199 = 0
SET	@M21 = 0 SET	@M27 = 0 SET	@M299 = 0
SET	@M31 = 0 SET	@M37 = 0 SET	@M399 = 0
SET	@M41 = 0 SET	@M47 = 0 SET	@M499 = 0
SET	@M51 = 0 SET	@M57 = 0 SET	@M599 = 0
SET	@A1 = 0 SET	@A7 = 0 SET	@A99 = 0
SET	@C1 = 0 SET	@C7 = 0 SET	@C99 = 0
SET	@T1 = 0 SET	@T7 = 0 SET	@T99 = 0
SET @S11 = 0.0 SET @S17 = 0.0 SET @S130 = 0.0 SET @S199 = 0.0
SET @S21 = 0.0 SET @S27 = 0.0 SET @S230 = 0.0 SET @S299 = 0.0
SET @S31 = 0.0 SET @S37 = 0.0 SET @S330 = 0.0 SET @S399 = 0.0
SET @B1 = 0.0 SET @B7 = 0.0 SET @B30 = 0.0 SET @B99 = 0.0
SET @W1 = 0.0 SET @W2 = 0.0 SET @W3 = 0.0 SET @W4 = 0.0 SET @W5 = 0.0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now

-- Member
SELECT @M11 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliate
SELECT @M21 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Bronze
SELECT @M31 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Silver
SELECT @M41 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Gold
SELECT @M51 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Diamond+
SELECT @M61 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title >= 6 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Active
SELECT @A1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status=1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Cancelled
SELECT @C1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status=6 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T1 = @M11 + @M21 + @M31 + @M41 + @M51 + @M61

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

-- Members
SELECT @M17 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Affiliates
SELECT @M27 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 2 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Bronze
SELECT @M37 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Silver
SELECT @M47 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Gold
SELECT @M57 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Diamond+
SELECT @M67 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title >= 6 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Active
SELECT @A7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status=1 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Cancelled
SELECT @C7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status=6 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @T7 = @M17 + @M27 + @M37 + @M47 + @M57 + @M67

-- ****************************************
-- Member
SELECT @M199 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 1 AND EnrollDate < @EndDate

-- Affiliate
SELECT @M299 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 2 AND EnrollDate < @EndDate

-- Bronze
SELECT @M399 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 3 AND EnrollDate < @EndDate

-- Silver
SELECT @M499 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 4 AND EnrollDate < @EndDate

-- Gold
SELECT @M599 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title = 5 AND EnrollDate < @EndDate

-- Diamond+
SELECT @M699 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status IN (1,2) AND Title >= 6 AND EnrollDate < @EndDate

-- Active
SELECT @A99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status=1 AND EnrollDate < @EndDate

-- Cancelled
SELECT @C99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status=6 AND EnrollDate < @EndDate

-- Total Members
SET @T99 = @M199 + @M299 + @M399 + @M499 + @M599 + @M699

--select * from SalesOrder order by SalesOrderID desc
-- ** Sales per Time **************************************
SET @EndDate = DATEADD(d, 1, @Now)
SET @StartDate = DATEADD(d, -1, @EndDate)

select @S11 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN pa.Total - 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN pa.Total - 299.95
		ELSE pa.Total
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
 where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
		AND ( ( Purpose IN ( '104', '204' ) AND Total > 69.95  )
		OR 	( Purpose IN ( '105', '205' ) AND Total > 299.95 ) 
		OR 	( Purpose = 'GCRCOIN' ) )
SET @S11T = '$'+ CONVERT(varchar(15),@S11, 1)
SET @S11T = LEFT(@S11T, CHARINDEX('.', @S11T)-1 )

select @S21 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN 299.95
		ELSE 0
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
 where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
		AND Purpose IN ( '104', '204','105', '205' )
SET @S21T = '$'+ CONVERT(varchar(15),@S21, 1)
SET @S21T = LEFT(@S21T, CHARINDEX('.', @S21T)-1 )

select @S31 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
 where me.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate and pa.PaidDate > 0
SET @S31T = '$'+ CONVERT(varchar(15),@S31, 1)
SET @S31T = LEFT(@S31T, CHARINDEX('.', @S31T)-1 )

select @B1 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= '11/6/15' and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B1T = '$'+ CONVERT(varchar(15),@B1, 1)
SET @B1T = LEFT(@B1T, CHARINDEX('.', @B1T)-1 )

SET @StartDate = DATEADD(d, -7, @EndDate)
select @S17 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN pa.Total - 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN pa.Total - 299.95
		ELSE pa.Total
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
		AND ( ( Purpose IN ( '104', '204' ) AND Total > 69.95  )
		OR 	( Purpose IN ( '105', '205' ) AND Total > 299.95 ) 
		OR 	( Purpose = 'GCRCOIN' ) )
SET @S17T = '$'+ CONVERT(varchar(15),@S17, 1)
SET @S17T = LEFT(@S17T, CHARINDEX('.', @S17T)-1 )

select @S27 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN 299.95
		ELSE 0
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
		AND Purpose IN ( '104', '204','105', '205' )
SET @S27T = '$'+ CONVERT(varchar(15),@S27, 1)
SET @S27T = LEFT(@S27T, CHARINDEX('.', @S27T)-1 )

select @S37 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate and pa.PaidDate > 0
SET @S37T = '$'+ CONVERT(varchar(15),@S37, 1)
SET @S37T = LEFT(@S37T, CHARINDEX('.', @S37T)-1 )

select @B7 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= '11/6/15' and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B7T = '$'+ CONVERT(varchar(15),@B7, 1)
SET @B7T = LEFT(@B7T, CHARINDEX('.', @B7T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S130 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN pa.Total - 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN pa.Total - 299.95
		ELSE pa.Total
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
		AND ( ( Purpose IN ( '104', '204' ) AND Total > 69.95  )
		OR 	( Purpose IN ( '105', '205' ) AND Total > 299.95 ) 
		OR 	( Purpose = 'GCRCOIN' ) )
SET @S130T = '$'+ CONVERT(varchar(15),@S130, 1)
SET @S130T = LEFT(@S130T, CHARINDEX('.', @S130T)-1 )

select @S230 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN 299.95
		ELSE 0
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate
		AND Purpose IN ( '104', '204','105', '205' )
SET @S230T = '$'+ CONVERT(varchar(15),@S230, 1)
SET @S230T = LEFT(@S230T, CHARINDEX('.', @S230T)-1 )

select @S330 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate >= @StartDate and pa.PaidDate < @EndDate and pa.PaidDate > 0
SET @S330T = '$'+ CONVERT(varchar(15),@S330, 1)
SET @S330T = LEFT(@S330T, CHARINDEX('.', @S330T)-1 )

select @B30 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= '11/6/15' and co.CommDate >= @StartDate and co.CommDate < @EndDate
SET @B30T = '$'+ CONVERT(varchar(15),@B30, 1)
SET @B30T = LEFT(@B30T, CHARINDEX('.', @B30T)-1 )

SET @StartDate = DATEADD(d, -30, @EndDate)
select @S199 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN pa.Total - 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN pa.Total - 299.95
		ELSE pa.Total
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate < @EndDate
		AND ( ( Purpose IN ( '104', '204' ) AND Total > 69.95  )
		OR 	( Purpose IN ( '105', '205' ) AND Total > 299.95 ) 
		OR 	( Purpose = 'GCRCOIN' ) )
SET @S199T = '$'+ CONVERT(varchar(15),@S199, 1)
SET @S199T = LEFT(@S199T, CHARINDEX('.', @S199T)-1 )

select @S299 = ISNULL(SUM(
	CASE 
		WHEN pa.Purpose IN ( '104', '204' ) THEN 69.95
		WHEN pa.Purpose IN ( '105', '205' ) THEN 299.95
		ELSE 0
	END), 0)
from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and me.Status <=2 and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate < @EndDate
		AND Purpose IN ( '104', '204','105', '205' )
SET @S299T = '$'+ CONVERT(varchar(15),@S299, 1)
SET @S299T = LEFT(@S299T, CHARINDEX('.', @S299T)-1 )

select @S399 = ISNULL(SUM(pa.Total),0) from Payment AS pa join Member AS me ON pa.OwnerID = me.MemberID
where me.CompanyID = @CompanyID and pa.status = 3 and pa.PaidDate >= '11/6/15' and pa.PaidDate < @EndDate and pa.PaidDate > 0
SET @S399T = '$'+ CONVERT(varchar(15),@S399, 1)
SET @S399T = LEFT(@S399T, CHARINDEX('.', @S399T)-1 )

select @B99 = ISNULL(SUM(co.Total),0) from Commission AS co join Member AS me ON co.OwnerType = 4 AND co.OwnerID = me.MemberID
where co.CompanyID = @CompanyID and co.CommDate >= '11/6/15' and co.CommDate < @EndDate
SET @B99T = '$'+ CONVERT(varchar(15),@B99, 1)
SET @B99T = LEFT(@B99T, CHARINDEX('.', @B99T)-1 )

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
'a1="'  + CAST(@A1 AS varchar(15)) + '" ' +
'a7="'  + CAST(@A7 AS varchar(15))  + '" ' +
'a99="' + CAST(@A99 AS varchar(15)) + '" ' +
'c1="'  + CAST(@C1 AS varchar(15)) + '" ' +
'c7="'  + CAST(@C7 AS varchar(15))  + '" ' +
'c99="' + CAST(@C99 AS varchar(15)) + '" ' +
't1="'  + CAST(@T1 AS varchar(15)) + '" ' +
't7="'  + CAST(@T7 AS varchar(15))  + '" ' +
't99="' + CAST(@T99 AS varchar(15)) + '" ' +
's11="'      + @S11T + '" ' +
's17="'      + @S17T + '" ' +
's130="'     + @S130T + '" ' +
's199="'     + @S199T + '" ' +
's21="'      + @S21T + '" ' +
's27="'      + @S27T + '" ' +
's230="'     + @S230T + '" ' +
's299="'     + @S299T + '" ' +
's31="'      + @S31T + '" ' +
's37="'      + @S37T + '" ' +
's330="'     + @S330T + '" ' +
's399="'     + @S399T + '" ' +
'b1="'       + @B1T + '" ' +
'b7="'       + @B7T + '" ' +
'b30="'      + @B30T + '" ' +
'b99="'      + @B99T + '" ' +
'w1="'       + @W1T + '" ' +
'w2="'       + @W2T + '" ' +
'w3="'       + @W3T + '" ' +
'w4="'       + @W4T + '" ' +
'w5="'       + @W5T + '" ' +
'/>'
GO

