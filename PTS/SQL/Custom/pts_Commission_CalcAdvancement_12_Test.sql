EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_12_Test'
GO

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_12_Test
   @MemberID int,
   @Title int,
   @Advance int OUTPUT
AS

SET NOCOUNT ON
-- *********************************************
-- Check if this agent can advance to this title
-- *********************************************

DECLARE @cnt int

-- Check if agent meets the next recruiting requirement
SET @Advance = 0

-- Test for MA = 1 Associate
If @Title = 3
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 1 AND Status <= 3
	IF @cnt >= 1 SET @Advance = 1
END

-- Test for MD = 2 Associates or 1 MA
If @Title = 4
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 1 AND Status <= 3
	IF @cnt >= 2
		SET @Advance = 1
	ELSE
	BEGIN
		SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 2 AND Status <= 3
		IF @cnt >= 1 SET @Advance = 1
	END
END

-- Test for EMD = 4 Associates or 2 MA or 1 MD
If @Title = 5
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 1 AND Status <= 3
	IF @cnt >= 4
		SET @Advance = 1
	ELSE
	BEGIN
		SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 2 AND Status <= 3
		IF @cnt >= 2
			SET @Advance = 1
		ELSE
		BEGIN
			SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 3 AND Status <= 3
			IF @cnt >= 1 SET @Advance = 1
		END
	END
END

-- Test for SEMD = 8 Associates or 4 MA or 2 MD or 1 EMD
If @Title = 6
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 1 AND Status <= 3
	IF @cnt >= 8
		SET @Advance = 1
	ELSE
	BEGIN
		SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 2 AND Status <= 3
		IF @cnt >= 4
			SET @Advance = 1
		ELSE
		BEGIN
			SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 3 AND Status <= 3
			IF @cnt >= 2
				SET @Advance = 1
			ELSE
			BEGIN
				SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @MemberID AND Title > 4 AND Status <= 3
				IF @cnt >= 1 SET @Advance = 1
			END
		END
	END
END
-- *********************************************************************************
-- If the agent meets the recruiting requirement, check for commission requirements 
-- Super = 1 mo.   Quick = 3 of 4 mos.   Annual = 1 yr. 
-- *********************************************************************************
IF @Advance = 1
BEGIN
	DECLARE @PrevMonth datetime, @SuperDate datetime, @QuickFromDate datetime, @QuickToDate datetime 
	DECLARE @AnnualFromDate datetime, @AnnualToDate datetime, @Amount money 
	SET @PrevMonth = DATEADD( m, -1, GETDATE() )
	SET @SuperDate = CAST( CAST(MONTH(@PrevMonth) AS CHAR(2)) + '/1/' + CAST(YEAR(@PrevMonth) AS CHAR(4)) AS DATETIME )
	SET @QuickToDate = @SuperDate
	SET @QuickFromDate = DATEADD( m, -4, @SuperDate )
	SET @AnnualToDate = @SuperDate
	SET @AnnualFromDate = DATEADD( m, -12, @SuperDate )

	SET @Advance = 0

-- 	-- Test for MA = $75,000 GV Super, $20,000 GV Quick, or $200,000 GV Annual
	If @Title = 3
	BEGIN
--		-- Check Super
		SELECT @cnt = COUNT(*) FROM MemberSales 
		WHERE MemberID = @MemberID AND SalesDate = @SuperDate AND GV >= 75000
		IF @cnt >= 1 SET @Advance = 1

--		-- If not, Check Quick
		IF @Advance = 0
		BEGIN
			SELECT @cnt = COUNT(*) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @QuickFromDate AND SalesDate <= @QuickToDate AND GV >= 20000
			IF @cnt >= 3 SET @Advance = 1
		END

--		-- If not, Check Annual
		IF @Advance = 0
		BEGIN
			SELECT @Amount = SUM(GV) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @AnnualFromDate AND SalesDate <= @AnnualToDate
			IF @Amount >= 200000 SET @Advance = 1
		END
	END

-- 	-- Test for MA = $150,000 GV Super, $40,000 GV Quick, or $400,000 GV Annual
	If @Title = 4
	BEGIN
--		-- Check Super
		SELECT @cnt = COUNT(*) FROM MemberSales 
		WHERE MemberID = @MemberID AND SalesDate = @SuperDate AND GV >= 150000
		IF @cnt >= 1 SET @Advance = 1

--		-- If not, Check Quick
		IF @Advance = 0
		BEGIN
			SELECT @cnt = COUNT(*) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @QuickFromDate AND SalesDate <= @QuickToDate AND GV >= 40000
			IF @cnt >= 3 SET @Advance = 1
		END

--		-- If not, Check Annual
		IF @Advance = 0
		BEGIN
			SELECT @Amount = SUM(GV) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @AnnualFromDate AND SalesDate <= @AnnualToDate
			IF @Amount >= 400000 SET @Advance = 1
		END
	END
-- 	-- Test for MA = $300,000 GV Super, $100,000 GV Quick, or $1,000,000 GV Annual
	If @Title = 5
	BEGIN
--		-- Check Super
		SELECT @cnt = COUNT(*) FROM MemberSales 
		WHERE MemberID = @MemberID AND SalesDate = @SuperDate AND GV >= 300000
		IF @cnt >= 1 SET @Advance = 1

--		-- If not, Check Quick
		IF @Advance = 0
		BEGIN
			SELECT @cnt = COUNT(*) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @QuickFromDate AND SalesDate <= @QuickToDate AND GV >= 100000
			IF @cnt >= 3 SET @Advance = 1
		END

--		-- If not, Check Annual
		IF @Advance = 0
		BEGIN
			SELECT @Amount = SUM(GV) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @AnnualFromDate AND SalesDate <= @AnnualToDate
			IF @Amount >= 1000000 SET @Advance = 1
		END
	END
-- 	-- Test for MA = $500,000 GV Super, $200,000 GV + $50,000 PV Quick, or $2,000,000 GV Annual
	If @Title = 6
	BEGIN
--		-- Check Super
		SELECT @cnt = COUNT(*) FROM MemberSales 
		WHERE MemberID = @MemberID AND SalesDate = @SuperDate AND GV >= 500000
		IF @cnt >= 1 SET @Advance = 1

--		-- If not, Check Quick
		IF @Advance = 0
		BEGIN
			SELECT @cnt = COUNT(*) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @QuickFromDate AND SalesDate <= @QuickToDate AND GV >= 200000

--			-- If we have the 3 of 4 months GV, check PV
			IF @cnt >= 3
			BEGIN
				SELECT @cnt = COUNT(*) FROM MemberSales 
				WHERE MemberID = @MemberID 
				AND SalesDate >= @QuickFromDate AND SalesDate <= @QuickToDate AND PV >= 50000
				IF @cnt >= 3 SET @Advance = 1
			END
		END

--		-- If not, Check Annual
		IF @Advance = 0
		BEGIN
			SELECT @Amount = SUM(GV) FROM MemberSales 
			WHERE MemberID = @MemberID 
			AND SalesDate >= @AnnualFromDate AND SalesDate <= @AnnualToDate
			IF @Amount >= 2000000 SET @Advance = 1
		END
	END
END

GO