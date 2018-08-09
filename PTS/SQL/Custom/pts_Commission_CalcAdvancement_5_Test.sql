EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_5_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_5_Test 5339, 5, 0, 0, 0, @Qualify OUTPUT PRINT @Qualify

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_5_Test
   @MemberID int,
   @Title int,
   @Maintain int,
   @Sales money,
   @EnrollDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON
-- **************************************************
-- Check if this affiliate can qualify for this title
-- **************************************************
DECLARE @Legs int, @BV money, @FastTrack int, @MinSales money
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0
SET @BV = 0

-- Test for a Reseller
IF @Title <= 1 SET @Qualify = 1

-- Get Personal Sales Volume 
IF @Title >= 2 SELECT @BV = BV, @FastTrack = IsMaster FROM Member Where MemberID = @MemberID

IF @BV >= 40
BEGIN
--	Test for an Affiliate
	IF @Title = 2 SET @Qualify = 1

--	Test for a Sr. Affiliate
	IF @Title = 3
	BEGIN
--			2 Active Affiliates 
			SELECT @Legs = COUNT(*) FROM Member
--			Where ReferralID = @MemberID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND Title >= 2 AND EnrollDate <= @EnrollDate
			Where SponsorID = @MemberID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND MaxMembers >= 2 AND EnrollDate <= @EnrollDate
			IF @Legs >= 2 SET @Qualify = 1
	END

--	If Manager, get the member's team group sales volume
	IF @Title = 4
	BEGIN
		SELECT @Sales = SUM(BV+QV) FROM Member 
		Where SponsorID = @MemberID AND BusAccts < 4 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
	END
--	If Director or Executive, get the member's team group sales volume
	IF ( @Title = 5 OR @Title = 6 )
	BEGIN
		SELECT @Sales = SUM(BV+QV) FROM Member 
		Where SponsorID = @MemberID AND BusAccts = @Title-1 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
	END
--print 'Group Sales: ' + CAST(@Sales AS VARCHAR(10))
--	Test for a Manager
	IF @FastTrack = 0 SET @MinSales = 240 ELSE SET @MinSales = 80
	IF @Title = 4 AND @Sales >= @MinSales
	BEGIN
		IF @Maintain > 0
			SET @Qualify = 1
		ELSE
		BEGIN
--			2 Active Affiliate Legs(MaxMembers) on their Affiliate Team(BusAccts)
			SELECT @Legs = COUNT(*) FROM Member
--			Where ReferralID = @MemberID AND BusAccts < 4 AND MaxMembers >= 2 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
			Where SponsorID = @MemberID AND BusAccts < 4 AND MaxMembers >= 2 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
			IF @Legs >= 2 SET @Qualify = 1
		END	
	END
--	Test for a Director
	IF @Title = 5 AND @Sales >= 1200
	BEGIN
		IF @Maintain > 0
			SET @Qualify = 1
		ELSE
		BEGIN
--			4 Active Manager Legs(MaxMembers) on their Manager Team(BusAccts)
			SELECT @Legs = COUNT(*) FROM Member
--			Where ReferralID = @MemberID AND BusAccts = 4 AND MaxMembers >= 4 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
			Where SponsorID = @MemberID AND BusAccts = 4 AND MaxMembers >= 4 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
			IF @Legs >= 4 SET @Qualify = 1
		END	
	END	
--	Test for an Executive
	IF @Title = 6 AND @Sales >= 6000
	BEGIN
		IF @Maintain > 0
			SET @Qualify = 1
		ELSE
		BEGIN
--			4 Active Director Legs(MaxMembers) on their Director Team(BusAccts)
			SELECT @Legs = COUNT(*) FROM Member
--			Where ReferralID = @MemberID AND BusAccts = 5 AND MaxMembers >= 5 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
			Where SponsorID = @MemberID AND BusAccts = 5 AND MaxMembers >= 5 AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate <= @EnrollDate
			IF @Legs >= 4 SET @Qualify = 1
		END	
	END	
END
GO