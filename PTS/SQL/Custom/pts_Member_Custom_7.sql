EXEC [dbo].pts_CheckProc 'pts_Member_Custom_7'
GO

--DECLARE @Result varchar(1000) EXEC pts_Member_Custom_7 87101, 1, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Member_Custom_7
   @MemberID int ,
   @Status int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Level int

-- ***********************************************************************
--	Income Calculator
-- ***********************************************************************
IF @Status = 1
BEGIN
	DECLARE @Title int, @EnrollDate datetime, @Now datetime, @StartDate datetime, @EndDate datetime, @cnt int
	DECLARE @T money, @E1 money, @E2 money, @E3 money, @EL1 money, @EL2 money, @EL3 money, @ES money
	DECLARE @M1 money, @M2 money, @M3 money, @M4 money, @M5 money, @ML1 money, @ML2 money, @ML3 money, @MS money, @Total money
	DECLARE @E money, @EL money, @M money, @ML money

	SET @T = 0 SET @E1 = 0 SET @E2 = 0 SET @E3 = 0 SET @EL1 = 0 SET @EL2 = 0 SET @EL3 = 0 SET @ES = 0
	SET SET @M1 = 0 SET @M2 = 0 SET @M3 = 0 SET @M4 = 0 SET @M5 = 0 SET @ML1 = 0 SET @ML2 = 0 SET @ML3 = 0 SET @MS = 0

	SET @Now = dbo.wtfn_DateOnly(GETDATE())
	SET @StartDate = CAST( CAST( MONTH(@Now) AS VARCHAR(2)) + '/1/' + CAST( YEAR(@Now) AS VARCHAR(4)) AS DATETIME )	
	SET @EndDate = DATEADD( day, -1, DATEADD( month, 1, @Startdate ) )

	SELECT @Title = Title, @Level = [Level], @EnrollDate = EnrollDate FROM Member WHERE MemberID = @MemberID

-- *****************************
-- Enroller Bonuses
-- *****************************
--	-- Member Training Bonus
	IF @EnrollDate >= @StartDate AND @EnrollDate <= @EndDate
	BEGIN
		SET @T = 30
	END	

--	-- 1st Level Enroller Bonus
	SELECT @cnt = COUNT(A.MemberID)
	FROM Member As A
	WHERE A.ReferralID = @MemberID AND A.Status = 1
	AND A.EnrollDate >= @StartDate AND A.EnrollDate <= @EndDate
	SET @E1 = @cnt * 40 

--	-- 2nd Level Enroller Bonus
	SELECT @cnt = COUNT(B.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	WHERE A.ReferralID = @MemberID AND B.Status = 1
	AND B.EnrollDate >= @StartDate AND B.EnrollDate <= @EndDate
	SET @E2 = @cnt * 15 

--	-- 3rd Level Enroller Bonus
	SELECT @cnt = COUNT(C.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	JOIN Member AS C ON B.MemberID = C.ReferralID
	WHERE A.ReferralID = @MemberID AND C.Status = 1
	AND C.EnrollDate >= @StartDate AND C.EnrollDate <= @EndDate
	SET @E3 = @cnt * 10 

--	-- Manager Leadership Bonus
	IF @Title >= 2
	BEGIN
		SELECT @cnt = COUNT(*) 
		FROM Downline AS dl 
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = 1 AND dl.ParentID = @MemberID AND me.Status = 1
		AND me.EnrollDate >= @StartDate AND me.EnrollDate <= @EndDate
		SET @EL1 = @cnt * 10 
	END

--	-- Director Leadership Bonus
	IF @Title >= 3
	BEGIN
		SELECT @cnt = COUNT(*) 
		FROM Downline AS dl 
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = 2 AND dl.ParentID = @MemberID AND me.Status = 1
		AND me.EnrollDate >= @StartDate AND me.EnrollDate <= @EndDate
		SET @EL2 = @cnt * 10 
	END

--	-- Executive Leadership Bonus
	IF @Title >= 4
	BEGIN
		SELECT @cnt = COUNT(*) 
		FROM Downline AS dl 
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = 3 AND dl.ParentID = @MemberID AND me.Status = 1
		AND me.EnrollDate >= @StartDate AND me.EnrollDate <= @EndDate
		SET @EL3 = @cnt * 5 
	END

--	-- Monthly Sponsorship Bonus
	SELECT @cnt = COUNT(*) 
	FROM Downline AS dl 
	JOIN Member AS me ON dl.ParentID = me.MemberID
	JOIN Member AS m2 ON dl.ChildID = m2.MemberID
	WHERE dl.Line >= 1 AND dl.Line <= 3
	AND me.ReferralID = @MemberID AND me.Status = 1
	AND m2.EnrollDate >= @StartDate AND m2.EnrollDate <= @EndDate
	SET @ES = @cnt * 1 


-- *****************************
-- Monthly Bonuses
-- *****************************
--	-- 1st Level Monthly Bonus
	SELECT @cnt = COUNT(A.MemberID)
	FROM Member As A
	WHERE A.ReferralID = @MemberID AND A.Status = 1
	SET @M1 = @cnt * 5 

--	-- 2nd Level Monthly Bonus
	SELECT @cnt = COUNT(B.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	WHERE A.ReferralID = @MemberID AND B.Status = 1
	SET @M2 = @cnt * 4 

--	-- 3rd Level Monthly Bonus
	SELECT @cnt = COUNT(C.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	JOIN Member AS C ON B.MemberID = C.ReferralID
	WHERE A.ReferralID = @MemberID AND C.Status = 1
	SET @M3 = @cnt * 3 

--	-- 4th Level Monthly Bonus
	SELECT @cnt = COUNT(D.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	JOIN Member AS C ON B.MemberID = C.ReferralID
	JOIN Member AS D ON C.MemberID = D.ReferralID
	WHERE A.ReferralID = @MemberID AND C.Status = 1
	SET @M4 = @cnt * 2 

--	-- 5th Level Monthly Bonus
	SELECT @cnt = COUNT(E.MemberID)
	FROM Member As A
	JOIN Member AS B ON A.MemberID = B.ReferralID
	JOIN Member AS C ON B.MemberID = C.ReferralID
	JOIN Member AS D ON C.MemberID = D.ReferralID
	JOIN Member AS E ON D.MemberID = E.ReferralID
	WHERE A.ReferralID = @MemberID AND C.Status = 1
	SET @M5 = @cnt * 4 

--	-- Manager Leadership Bonus
	IF @Title >= 2
	BEGIN
		SELECT @cnt = COUNT(*) 
		FROM Downline AS dl 
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = 1 AND dl.ParentID = @MemberID AND me.Status = 1
		SET @ML1 = @cnt * 5 
	END

--	-- Director Leadership Bonus
	IF @Title >= 3
	BEGIN
		SELECT @cnt = COUNT(*) 
		FROM Downline AS dl 
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = 2 AND dl.ParentID = @MemberID AND me.Status = 1
		SET @ML2 = @cnt * 3 
	END

--	-- Executive Leadership Bonus
	IF @Title >= 4
	BEGIN
		SELECT @cnt = COUNT(*) 
		FROM Downline AS dl 
		JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = 3 AND dl.ParentID = @MemberID AND me.Status = 1
		SET @ML3 = @cnt * 2 
	END

--	-- Monthly Sponsorship Bonus
	SELECT @cnt = COUNT(*) 
	FROM Downline AS dl 
	JOIN Member AS me ON dl.ParentID = me.MemberID
	WHERE dl.Line >= 1 AND dl.Line <= 3
	AND me.ReferralID = @MemberID AND me.Status = 1
	SET @MS = @cnt * 1 

	SET @E = @E1 + @E2 + @E3
	SET @EL = @EL1 + @EL2 + @EL3
	SET @M = @M1 + @M2 + @M3 + @M4 + @M5
	SET @ML = @ML1 + @ML2 + @ML3
	SET @Total = @T + @E + @EL + @ES + @M + @ML + @MS

	SET @Result = 't="' + CAST(@T AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'e="' + CAST(@E AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'el="' + CAST(@EL AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'es="' + CAST(@ES AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'm="' + CAST(@M AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'ml="' + CAST(@ML AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'ms="' + CAST(@MS AS VARCHAR(10)) + '" '  
	SET @Result = @Result + 'total="' + CAST(@Total AS VARCHAR(10)) + '"'  
END

-- ***********************************************************************
--	Introductory Offer Upgrade to new level or standard membership
-- ***********************************************************************
IF @Status = 2
BEGIN

DECLARE @Price money, @BillingID int, @ID int, @PaidDate datetime, @MinTitle int
DECLARE @PayType int, @tmpDescription varchar(200), @BillingInfo varchar(200) 

SET @PaidDate = dbo.wtfn_DateOnly(GETDATE())

SELECT @Title = Title, @MinTitle = MinTitle, @BillingID = BillingID FROM Member WHERE MemberID = @MemberID

	IF @Title = 1 SET @Price = 125
	IF @Title = 11
	BEGIN
		IF @MinTitle = 12 SET @Price = 13.95
		IF @MinTitle = 13 SET @Price = 34.95
		IF @MinTitle = 14 SET @Price = 76.95
	END
	IF @Title = 12
	BEGIN
		IF @MinTitle = 13 SET @Price = 24.95
		IF @MinTitle = 14 SET @Price = 66.95
	END
	IF @Title = 13
	BEGIN
		IF @MinTitle = 14 SET @Price = 46.95
	END

	SET @PayType = 0
	SET @BillingInfo = ''
	SELECT @PayType = 
		CASE PayType
		WHEN 1 THEN CardType 
		WHEN 2 THEN 5
		WHEN 3 THEN 7
		ELSE 0
		END, 
			@BillingInfo = 
		CASE PayType
		WHEN 1 THEN CAST(CardType AS varchar(10)) + '; ' + CardNumber + '; ' + CAST(CardMo AS varchar(10)) + '/' + CAST(CardYr AS varchar(10)) + '; ' + CardCode + '; ' + CardName + '; ' + Street1 + '; ' + Street2 + '; ' + City + '; ' + State + '; ' + Zip + '; ' + co.Code + '; ' + Token
		WHEN 2 THEN CheckBank + '; ' + CheckRoute + '; ' + CheckAccount + '; ' + CheckNumber + '; ' + CheckName + '; ' + CAST(CheckAcctType AS varchar(2))
		WHEN 4 THEN CAST(CardType AS varchar(10)) + '; ' + CardName
		ELSE ''
		END
	FROM Billing AS bi
	LEFT OUTER JOIN Country AS co ON bi.CountryID = co.CountryID
	WHERE BillingID = @BillingID

	IF @PayType < 7 SET @tmpDescription = 'Charged:[' + @BillingInfo + ']' ELSE SET @tmpDescription = ''

--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
	EXEC pts_Payment_Add @ID, 0, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
		     @Price, @Price, 0, 0, 0, @tmpDescription, '', 1, '', '', 1, 0, 0, 0, 0, 1

	IF @Title >= 11 AND @Title <= 13 UPDATE Member SET Title = MinTitle, MinTitle = 0 WHERE MemberID = @MemberID

	SET @Result = CAST(@ID AS varchar(10))
END

GO