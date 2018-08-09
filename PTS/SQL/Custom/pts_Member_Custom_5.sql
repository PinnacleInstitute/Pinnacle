EXEC [dbo].pts_CheckProc 'pts_Member_Custom_5'
GO

--DECLARE @Result varchar(1000) EXEC pts_Member_Custom_5 1, 100, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Member_Custom_5
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
	DECLARE @Title int
END

-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
IF @Status = 100
BEGIN
	DECLARE	@Now datetime, @StartDate datetime, @EndDate datetime, @Days int
--	-- Number of Days to look back
	SET @Days = @MemberID
--	-- A=Affiliates, C=Customers, 
--	-- AC = Affiliate Computers, CC = Customer Computers
--	-- ACA = Affiliate Computer Average, CCA = Customer Computer Average 
	DECLARE 
	@AToday int,
	@AWeek int,
	@ATotal int,
	@CToday int,
	@CWeek int,
	@CTotal int,
	@ACToday int,
	@ACWeek int,
	@ACTotal int,
	@CCToday int,
	@CCWeek int,
	@CCTotal int,
	@ACAToday decimal(5,2),
	@ACAWeek decimal(5,2),
	@ACATotal decimal(5,2),
	@CCAToday decimal(5,2),
	@CCAWeek decimal(5,2),
	@CCATotal decimal(5,2)

	SET	@AToday = 0
	SET	@AWeek = 0 
	SET	@ATotal = 0 
	SET	@CToday = 0
	SET	@CWeek = 0
	SET	@CTotal = 0
	SET	@ACToday = 0
	SET	@ACWeek = 0 
	SET	@ACTotal = 0 
	SET	@CCToday = 0
	SET	@CCWeek = 0
	SET	@CCTotal = 0
	SET	@ACAToday = 0.0
	SET	@ACAWeek = 0.0 
	SET	@ACATotal = 0.0 
	SET	@CCAToday = 0.0
	SET	@CCAWeek = 0.0
	SET	@CCATotal = 0.0

	SET @Now = dbo.wtfn_DateOnly(GETDATE())
	IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
	SET @EndDate = DATEADD(d, 1, @Now)

--	-- ****************************************
	SET @StartDate = @Now

	SELECT @AToday = ISNULL(COUNT(MemberID),0), @ACToday = ISNULL(SUM(Process),0) FROM Member 
	WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate 
	IF @AToday > 0 SET @ACAToday = @ACToday / CAST(@AToday AS decimal(10,2)) 

	SELECT @CToday = ISNULL(COUNT(MemberID),0), @CCToday = ISNULL(SUM(Process),0) FROM Member 
	WHERE  CompanyID = 5 AND [Level] = 0 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate 
	IF @CToday > 0 SET @CCAToday = @CCToday / CAST(@CToday AS decimal(10,2))

--	-- ****************************************
	SET @Days = (DATEPART(dw,@Now)-1) * -1
	IF @Days = 0 SET @Days = -7
	SET @StartDate = DATEADD(d, @Days, @EndDate)

	SELECT @AWeek = ISNULL(COUNT(MemberID),0), @ACWeek = ISNULL(SUM(Process),0) FROM Member 
	WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate 
	IF @AWeek > 0 SET @ACAWeek = @ACWeek / CAST(@AWeek AS decimal(10,2))
	
	SELECT @CWeek = ISNULL(COUNT(MemberID),0), @CCWeek = ISNULL(SUM(Process),0) FROM Member 
	WHERE  CompanyID = 5 AND [Level] = 0 AND Status >= 1 AND Status <= 5 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate
	IF @CWeek > 0 SET @CCAWeek = @CCWeek / CAST(@CWeek AS decimal(10,2))

--	-- ****************************************
	SELECT @ATotal = ISNULL(COUNT(MemberID),0), @ACTotal = ISNULL(SUM(Process),0) FROM Member 
	WHERE  CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND EnrollDate < @EndDate
	IF @ATotal > 0 SET @ACATotal = @ACTotal / CAST(@ATotal AS decimal(10,2))

	SELECT @CTotal = ISNULL(COUNT(MemberID),0), @CCTotal = ISNULL(SUM(Process),0) FROM Member 
	WHERE  CompanyID = 5 AND [Level] = 0 AND Status >= 1 AND Status <= 5 AND EnrollDate < @EndDate
	IF @CTotal > 0 SET @CCATotal = @CCTotal / CAST(@CTotal AS decimal(10,2))

	SET @Result = '<PTSSTATS ' + 
	'atoday="' + CAST(@AToday AS VARCHAR(10)) + '" ' +
	'aweek="'  + CAST(@AWeek AS VARCHAR(10))  + '" ' +
	'atotal="' + CAST(@ATotal AS VARCHAR(10)) + '" ' +
	'ctoday="'  + CAST(@CToday AS VARCHAR(10)) + '" ' +
	'cweek="'   + CAST(@CWeek AS VARCHAR(10))  + '" ' +
	'ctotal="'  + CAST(@CTotal AS VARCHAR(10)) + '" ' +
	'actoday="' + CAST(@ACToday AS VARCHAR(10)) + '" ' +
	'acweek="'  + CAST(@ACWeek AS VARCHAR(10))  + '" ' +
	'actotal="' + CAST(@ACTotal AS VARCHAR(10)) + '" ' +
	'cctoday="'  + CAST(@CCToday AS VARCHAR(10)) + '" ' +
	'ccweek="'   + CAST(@CCWeek AS VARCHAR(10))  + '" ' +
	'cctotal="'  + CAST(@CCTotal AS VARCHAR(10)) + '" ' +
	'acatoday="' + CAST(@ACAToday AS VARCHAR(10)) + '" ' +
	'acaweek="'  + CAST(@ACAWeek AS VARCHAR(10))  + '" ' +
	'acatotal="' + CAST(@ACATotal AS VARCHAR(10)) + '" ' +
	'ccatoday="'  + CAST(@CCAToday AS VARCHAR(10)) + '" ' +
	'ccaweek="'   + CAST(@CCAWeek AS VARCHAR(10))  + '" ' +
	'ccatotal="'  + CAST(@CCATotal AS VARCHAR(10)) + '" ' +
	'/>'

END

GO