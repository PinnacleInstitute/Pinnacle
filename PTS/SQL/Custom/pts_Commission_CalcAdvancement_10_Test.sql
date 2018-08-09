EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_10_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_10_Test 8725, 7, '7/7/13', @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 9

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_10_Test
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

SET @Personal = 0
SET @Team = 0
SET @Total = 0
SET @Line = @Title - 1

--	-- Get Personal Enrollees
IF @Title = 2
BEGIN
	SELECT @Personal = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4
	AND EnrollDate <= @EnrollDate
END
IF @Title >= 3 AND @Title <= 7
BEGIN
--		-- Get Personal Enrollees for previous team	(2D - PA)
	SELECT @Personal = COUNT(dl.DownlineID) 
	FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = @Line AND dl.ParentID = @MemberID AND me.ReferralID = @MemberID
	AND  me.Status >= 1 AND me.Status <= 4 AND me.EnrollDate <= @EnrollDate

--		-- Get Team Enrollees for previous team	(3D - PA)
	SELECT @Team = COUNT(dl.DownlineID) 
	FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = @Line AND dl.ParentID = @MemberID
	AND  me.Status >= 1 AND me.Status <= 4 AND me.EnrollDate <= @EnrollDate
END
--	-- Get Total Enrollees for all teams (BD - PA)	
IF @Title >= 5 AND @Title <= 7
BEGIN
	SELECT @Total = COUNT(dl.DownlineID) 
	FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.ParentID = @MemberID
	AND  me.Status >= 1 AND me.Status <= 4 AND me.EnrollDate <= @EnrollDate
	AND me.Options2 LIKE '%115%'
END

--	-- Affiliate	
IF @Title = 1 SET @Qualify = 1	

--	-- Diamond	
--IF @Title = 2 SET @Qualify = 1	

--	-- Double Diamond
IF @Title = 3 AND @Personal >= 2 SET @Qualify = 1	

--	-- Triple Diamond	
IF @Title = 4 AND @Personal >= 5 AND @Team >= 20 SET @Qualify = 1	

--	-- Blue Diamond	
IF @Title = 5 AND @Personal >= 10 AND @Team >= 40 AND @Total >= 60 SET @Qualify = 1	

--	-- Presidential	Diamond
IF @Title = 6 AND @Personal >= 15 AND @Team >= 60 AND @Total >= 120 SET @Qualify = 1	

--	-- Presidential Ambassador 	
IF @Title = 7 AND @Personal >= 20 AND @Team >= 80 AND @Total >= 200 SET @Qualify = 1


GO
