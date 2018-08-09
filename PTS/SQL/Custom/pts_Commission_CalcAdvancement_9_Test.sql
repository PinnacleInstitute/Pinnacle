EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_9_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_9_Test 8704, 8, 0, @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 9

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_9_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Level int, @Options2 varchar(100), @Personal int, @Team int, @Total int, @Line int, @cnt int
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0

SELECT @Level = [Level], @Options2 = Options2 FROM Member WHERE MemberID = @MemberID

-- Non-Binary Advancement Tests
IF @Level > 0 AND CHARINDEX('B', @Options2) = 0
BEGIN
--	Always pass test for Affiliate
	IF @Title = 1 SET @Qualify = 1

--	Test for Bronze to Triple Diamond 
	IF @Title >= 2 AND @Title <= 8
	BEGIN
		SELECT @cnt = COUNT(MemberID) FROM Member WHERE ReferralID = @MemberID AND Title > 0 AND EnrollDate <= @EnrollDate
	END

	IF @Title = 2 AND @cnt >= 2 SET @Qualify = 1	
	IF @Title = 3 AND @cnt >= 4 SET @Qualify = 1	
	IF @Title = 4 AND @cnt >= 6 SET @Qualify = 1	
	IF @Title = 5 AND @cnt >= 7 SET @Qualify = 1	
	IF @Title = 6 AND @cnt >= 8 SET @Qualify = 1	
	IF @Title = 7 AND @cnt >= 9 SET @Qualify = 1	
	IF @Title = 8 AND @cnt >= 10 SET @Qualify = 1	

--	Test for Amabassador
	IF @Title = 9 
	BEGIN
		SELECT @cnt = COUNT(MemberID) FROM Member WHERE ReferralID = @MemberID AND Title >= 8 AND EnrollDate <= @EnrollDate
		IF @cnt >= 5 SET @Qualify = 1	
	END
END

-- Binary Advancement Tests
IF @Level > 0 AND CHARINDEX('B', @Options2) > 0
BEGIN
--	-- Automatically qualify these old titles
	IF @Title <= 3 SET @Qualify = 1	
--	-- Skip over old Emerald Title to Diamond Title
	IF @Title = 5 SET @Title = 6

	SET @Personal = 0
	SET @Team = 0
	SET @Total = 0
	SET @Line = @Title - 1

--	-- Get Personal Enrollees
	IF @Title = 7
	BEGIN
		SELECT @Personal = COUNT(MemberID) FROM Member
		WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4
		AND EnrollDate <= @EnrollDate
		AND Options2 LIKE '%115%'
	END
	IF @Title >= 8 AND @Title <= 11
	BEGIN
--		-- Get Personal Enrollees for previous team	(2D - PA)
		SELECT @Personal = COUNT(dl.DownlineID) 
		FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = @Line AND dl.ParentID = @MemberID AND me.ReferralID = @MemberID
		AND  me.Status >= 1 AND me.Status <= 4 AND me.EnrollDate <= @EnrollDate
		AND me.Options2 LIKE '%115%'

--		-- Get Team Enrollees for previous team	(3D - PA)
		SELECT @Team = COUNT(dl.DownlineID) 
		FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.Line = @Line AND dl.ParentID = @MemberID
		AND  me.Status >= 1 AND me.Status <= 4 AND me.EnrollDate <= @EnrollDate
		AND me.Options2 LIKE '%115%'
	END
--	-- Get Total Enrollees for all teams (BD - PA)	
	IF @Title >= 9 AND @Title <= 11
	BEGIN
		SELECT @Total = COUNT(dl.DownlineID) 
		FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
		WHERE dl.ParentID = @MemberID
		AND  me.Status >= 1 AND me.Status <= 4 AND me.EnrollDate <= @EnrollDate
		AND me.Options2 LIKE '%115%'
	END

--	-- Gold	
	IF @Title = 4 AND CHARINDEX('116', @Options2) > 0 SET @Qualify = 1	

--	-- Diamond	
	IF @Title = 6 AND CHARINDEX('115', @Options2) > 0 SET @Qualify = 1	

--	-- Double Diamond	
	IF @Title = 7 AND @Personal >= 2 SET @Qualify = 1	

--	-- Triple Diamond	
	IF @Title = 8 AND @Personal >= 5 AND @Team >= 20 SET @Qualify = 1	

--	-- Blue Diamond	
	IF @Title = 9 AND @Personal >= 10 AND @Team >= 40 AND @Total >= 60 SET @Qualify = 1	

--	-- Presidential	Diamond
	IF @Title = 10 AND @Personal >= 15 AND @Team >= 60 AND @Total >= 120 SET @Qualify = 1	

--	-- Presidential Ambassador 	
	IF @Title = 11 AND @Personal >= 20 AND @Team >= 80 AND @Total >= 200 SET @Qualify = 1

--print 'Title: ' + CAST(@Title AS varchar(10)) + '   Personal: ' + CAST(@Personal AS varchar(10)) + '   Team: ' + CAST(@Team AS varchar(10))

END

GO
