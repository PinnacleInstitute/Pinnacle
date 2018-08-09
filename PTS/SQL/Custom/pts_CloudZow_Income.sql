EXEC [dbo].pts_CheckProc 'pts_CloudZow_Income'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_Income '7/30/12', 643, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_Income
   @StartDate datetime ,
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @Title int, @MemberTitle int, @Level int, @EnrollDate datetime
DECLARE @EndDate datetime, @cnt int, @day int
DECLARE @RC money, @FS1 money, @FS2 money, @FSS money, @FSM money, @FT1 money, @FT2 money
DECLARE @T1 money, @T2 money, @T3 money, @T4 money, @T5 money, @T6 money, @T7 money
DECLARE @L1 money, @L2 money, @L3 money, @M money
DECLARE @tmp1 money, @tmp2 money, @tmp3 money, @tmpCount int
DECLARE @mo varchar(12), @yr varchar(4)

SET @RC=0 SET @FS1=0 SET @FS2=0 SET @FSS=0 SET @FSM=0 SET @FT1=0 SET @FT2=0
SET @T1=0 SET @T2=0 SET @T3=0 SET @T4=0 SET @T5=0 SET @T6=0 SET @T7=0
SET @L1=0 SET @L2=0 SET @L3=0 SET @M=0

IF @StartDate = 0 SET @StartDate = dbo.wtfn_DateOnly(GETDATE())

SET @day = DATEPART(dw,@StartDate)  
SET @day = @day - 2
IF @day < 0 SET @day = 6
SET @StartDate = DATEADD(day, @day * -1, @StartDate) 
SET @EndDate = DATEADD( day, 7, @StartDate )
SET @mo = DATENAME(month,@StartDate)
SET @yr = DATENAME(year,@StartDate)

SELECT @Title = Title2, @EnrollDate = dbo.wtfn_DateOnly(EnrollDate) FROM Member WHERE MemberID = @MemberID

-- ***********************************************
-- Retail Commissions (for resellers and affiliates)
-- ***********************************************
SELECT @RC = ISNULL(SUM(Price),0) * .10 FROM Member 
WHERE Status = 1 AND Level = 0 AND ReferralID = @MemberID
AND CAST(@mo+' '+DATENAME(day,PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
AND CAST(@mo+' '+DATENAME(day,PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
-- AFFILIATE BONUSES (not for resellers)
-- ***********************************************
IF @Title >= 2
BEGIN
-- ***********************************************
-- FAST START BONUSES
-- ***********************************************
--	1st Level Fast Start Bonus
-- ***********************************************
	SELECT @cnt = COUNT(A.MemberID)
	FROM Member As A
	WHERE A.ReferralID = @MemberID AND A.Status = 1
	AND A.EnrollDate >= @StartDate AND A.EnrollDate <= @EndDate
	AND A.IsMaster = 0 AND A.Price = 40
	SET @FS1 = @cnt * 10 

-- ***********************************************
--	2nd Level Fast Start Bonus
-- ***********************************************
	SELECT @cnt = COUNT(B.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	WHERE A.ReferralID = @MemberID AND B.Status = 1
	AND B.EnrollDate >= @StartDate AND B.EnrollDate <= @EndDate
	AND B.IsMaster = 0 AND B.Price = 40
	SET @FS2 = @cnt * 5 

-- ***********************************************
-- FAST TRACK BONUSES
-- ***********************************************
--	1st Level Fast Track Bonus
-- ***********************************************
	SELECT @cnt = COUNT(A.MemberID)
	FROM Member As A
	WHERE A.ReferralID = @MemberID AND A.Status = 1
	AND A.EnrollDate >= @StartDate AND A.EnrollDate <= @EndDate
	AND A.IsMaster = 1
	SET @FT1 = @cnt * 100 

-- ***********************************************
--	2nd Level Fast Track Bonus
-- ***********************************************
	SELECT @cnt = COUNT(B.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	WHERE A.ReferralID = @MemberID AND B.Status = 1
	AND B.EnrollDate >= @StartDate AND B.EnrollDate <= @EndDate
	AND B.IsMaster = 1
	SET @FT2 = @cnt * 50 

-- ***********************************************
--	Fast Start Senior Affiliate Bonus 7 day / $20
-- ***********************************************
	IF @EnrollDate >= DATEADD(day, -7, @StartDate)
	BEGIN
--		Get the number of new active Affiliates enrolled by this member in 7 days
		SET @tmpCount = 0
		SELECT @tmpCount = COUNT(*) FROM Member 
		WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2
		AND EnrollDate < DATEADD(d,7,@EnrollDate)
		IF @tmpCount >= 2 SET @FSS = 20
	END

-- ***********************************************
--	Fast Start Manager Bonus 14 day / $20
-- ***********************************************
	IF @EnrollDate >= DATEADD(day, -14, @StartDate)
	BEGIN
--		Get the number of new active Affiliates enrolled by this member in 7 days
		SET @tmpCount = 0
		SELECT @tmpCount = COUNT(*) FROM Member 
		WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 3
		AND EnrollDate < DATEADD(d,14,@EnrollDate)
		IF @tmpCount >= 2 SET @FSM = 20
	END

-- ***********************************************
-- TEAM BONUSES
-- ***********************************************
--	1st Level Team Bonus
-- ***********************************************
	SELECT @T1 = ISNULL(SUM(A.BV),0) * .10
	FROM Member As A
	WHERE A.SponsorID = @MemberID AND A.Status = 1 AND A.Level = 1 AND A.BV > 0
	AND CAST(@mo+' '+DATENAME(day,A.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,A.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	2nd Level Team Bonus
-- ***********************************************
	SELECT @T2 = ISNULL(SUM(B.BV),0) * .05
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	WHERE A.SponsorID = @MemberID AND B.Status = 1 AND B.Level = 1 AND B.BV > 0
	AND CAST(@mo+' '+DATENAME(day,B.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,B.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	3rd Level Team Bonus
-- ***********************************************
	SELECT @T3 = ISNULL(SUM(C.BV),0) * .05
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	WHERE A.SponsorID = @MemberID AND C.Status = 1 AND C.Level = 1 AND C.BV > 0
	AND CAST(@mo+' '+DATENAME(day,C.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,C.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	4th Level Monthly Bonus
-- ***********************************************
	SELECT @T4 = ISNULL(SUM(D.BV),0) * .05
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	WHERE A.SponsorID = @MemberID AND D.Status = 1 AND D.Level = 1 AND D.BV > 0
	AND CAST(@mo+' '+DATENAME(day,D.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,D.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	5th Level Team Bonus
-- ***********************************************
	SELECT @T5 = ISNULL(SUM(E.BV),0) * .05
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	JOIN Member AS E ON D.MemberID = E.SponsorID
	WHERE A.SponsorID = @MemberID AND E.Status = 1 AND E.Level = 1 AND E.BV > 0
	AND CAST(@mo+' '+DATENAME(day,E.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,E.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	6th Level Team Bonus
-- ***********************************************
	SELECT @T6 = ISNULL(SUM(F.BV),0) * .05
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	JOIN Member AS E ON D.MemberID = E.SponsorID
	JOIN Member AS F ON E.MemberID = F.SponsorID
	WHERE A.SponsorID = @MemberID AND F.Status = 1 AND F.Level = 1 AND F.BV > 0
	AND CAST(@mo+' '+DATENAME(day,F.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,F.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	7th Level Team Bonus
-- ***********************************************
	SELECT @T7 = ISNULL(SUM(G.BV),0) * .05
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.SponsorID
	JOIN Member AS C ON B.MemberID = C.SponsorID
	JOIN Member AS D ON C.MemberID = D.SponsorID
	JOIN Member AS E ON D.MemberID = E.SponsorID
	JOIN Member AS F ON E.MemberID = F.SponsorID
	JOIN Member AS G ON F.MemberID = G.SponsorID
	WHERE A.SponsorID = @MemberID AND G.Status = 1 AND G.Level = 1 AND G.BV > 0
	AND CAST(@mo+' '+DATENAME(day,G.PaidDate)+' '+@yr AS DATETIME) >= @StartDate 
	AND CAST(@mo+' '+DATENAME(day,G.PaidDate)+' '+@yr AS DATETIME) < @EndDate

-- ***********************************************
--	Leadership Bonuses
-- ***********************************************
	EXEC pts_CloudZow_IncomeLeader @MemberID, @Title, @StartDate, @L1 output, @L2 output, @L3 output 

-- ***********************************************
--	Matching Leadership Bonuses
-- ***********************************************
	SET @MemberTitle = @Title
	
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, Title FROM Member
	WHERE  ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 4
	
	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmp1=0 SET @tmp2=0 SET @tmp3=0 
		EXEC pts_CloudZow_IncomeLeader @MemberID, @Title, @StartDate, @tmp1 output, @tmp2 output, @tmp3 output 
		SET @M = @M + @tmp1 + @tmp2 + @tmp3
		FETCH NEXT FROM Member_cursor INTO @MemberID, @Title
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor
	
	IF @MemberTitle < 4 SET @M = @M * .10
	IF @MemberTitle = 4 SET @M = @M * .15
	IF @MemberTitle = 5 SET @M = @M * .20
	IF @MemberTitle = 6 SET @M = @M * .25
END


DECLARE @FS money, @T money, @Total money

SET @FS = @FS1 + @FS2 + @FSS + @FSM + @FT1 + @FT2
SET @T = @T1 + @T2 + @T3 + @T4 + @T5 + @T6 + @T7
SET @Total = @FS + @T + @L1 + @L2 + @L3 + @M

SET @Result = 'rc="' + CAST(@RC AS VARCHAR(10)) + '" '  
SET @Result = @Result + 'fs="' + CAST(@FS AS VARCHAR(10)) + '" '  
SET @Result = @Result + 't="' + CAST(@T AS VARCHAR(10)) + '" '  
SET @Result = @Result + 'l1="' + CAST(@L1 AS VARCHAR(10)) + '" '  
SET @Result = @Result + 'l2="' + CAST(@L2 AS VARCHAR(10)) + '" '  
SET @Result = @Result + 'l3="' + CAST(@L3 AS VARCHAR(10)) + '" '  
SET @Result = @Result + 'm="' + CAST(@M AS VARCHAR(10)) + '" '  
SET @Result = @Result + 'total="' + CAST(@Total AS VARCHAR(10)) + '"'  

GO