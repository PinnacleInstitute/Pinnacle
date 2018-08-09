EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_14_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_14_Test 11777, 10, 0, @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 14

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_14_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT,
   @Result VARCHAR(20) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Options2 varchar(100), @Personal int, @Team int, @Total int, @Line int, @cnt int, @BonusQualify int
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0
SET @Result = ''
SET @Personal = 0
SET @Team = 0
SET @Total = 0
SET @Line = @Title - 1

SELECT @Options2 = Options2, @BonusQualify = Qualify FROM Member WHERE MemberID = @MemberID

SET @Qualify = 0
--	-- Automatically qualify these titles
IF @Title <= 1 SET @Qualify = 1	

--	Affiliate	
IF @Title = 2 AND CHARINDEX('103', @Options2) > 0 SET @Qualify = 1	

--	Silver	
IF @Title = 3 AND CHARINDEX('104', @Options2) > 0 SET @Qualify = 1	

--	Gold	
IF @Title = 4
BEGIN
	IF CHARINDEX('105', @Options2) > 0 SET @Qualify = 1	
	IF @Qualify = 0
	BEGIN
		SELECT @Personal = COUNT(MemberID) FROM Member
		WHERE ReferralID = @MemberID AND Status = 1 AND Qualify > 1 AND EnrollDate <= @EnrollDate
		AND Title >= 3
		IF @Personal >= 6 SET @Qualify = 1	
		SET @Result = CAST( dbo.wtfn_Min(6 - @Personal,0) AS VARCHAR(10))
	END
END

--	Diamond	
IF @Title = 5
BEGIN
	IF CHARINDEX('109', @Options2) > 0 OR CHARINDEX('110', @Options2) > 0 OR CHARINDEX('125', @Options2) > 0 OR CHARINDEX('101', @Options2) > 0 OR CHARINDEX('131', @Options2) > 0 SET @Qualify = 1	
	IF @Qualify = 0
	BEGIN
		SELECT @Personal = COUNT(MemberID) FROM Member
		WHERE ReferralID = @MemberID AND Status = 1 AND Qualify > 1 AND EnrollDate <= @EnrollDate
		AND Title >= 4
		IF @Personal >= 6 SET @Qualify = 1	
		SET @Result = CAST( dbo.wtfn_Min(6 - @Personal,0) AS VARCHAR(10))
	END
END

--	Double Diamond	
IF @Title = 6
BEGIN
	SELECT @Personal = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID AND Status = 1 AND Qualify > 1 AND  EnrollDate <= @EnrollDate
	AND Title >= 5
	IF @Personal >= 2 SET @Qualify = 1	
	SET @Result = CAST( dbo.wtfn_Min(2 - @Personal,0) AS VARCHAR(10))
END


--	Get Team Totals for DD to AM
IF @Title >= 7 AND @Title <= 10
BEGIN
--	Get Personal Enrollees for previous team	(2D - PA)
	SELECT @Personal = COUNT(dl.DownlineID) 
	FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = @Line AND dl.ParentID = @MemberID AND me.ReferralID = @MemberID
	AND  me.Status = 1 AND me.Qualify > 1 AND me.EnrollDate <= @EnrollDate
	AND me.Title >= 5

--	Get Team Enrollees for previous team	(3D - PA)
	SELECT @Team = COUNT(dl.DownlineID) 
	FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.Line = @Line AND dl.ParentID = @MemberID
	AND  me.Status = 1 AND me.Qualify > 1 AND me.EnrollDate <= @EnrollDate
	AND me.Title >= 5
END
--	Get Total Enrollees for all teams (BD - PA)	
IF @Title >= 8 AND @Title <= 10
BEGIN
	SELECT @Total = COUNT(dl.DownlineID) 
	FROM Downline AS dl JOIN Member AS me ON dl.ChildID = me.MemberID
	WHERE dl.ParentID = @MemberID
	AND  me.Status = 1 AND me.Qualify > 1 AND me.EnrollDate <= @EnrollDate
	AND me.Title >= 5
END

--	Triple Diamond	
IF @Title = 7
BEGIN
--	IF @Personal >= 3 AND @Team >= 20 SET @Qualify = 1	
	IF @Personal >= 2 AND @Team >= 20 SET @Qualify = 1	
	SET @Result = CAST( dbo.wtfn_Min(2 - @Personal,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(20 - @Team,0) AS VARCHAR(10))
END

--	Blue Diamond	
IF @Title = 8
BEGIN
	IF @Personal >= 4 AND @Team >= 40 AND @Total >= 60 SET @Qualify = 1	
	SET @Result = CAST( dbo.wtfn_Min(4 - @Personal,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(40 - @Team,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(60 - @Total,0) AS VARCHAR(10))
END

--	Presidential Diamond
IF @Title = 9
BEGIN
--	IF @Personal >= 15 AND @Team >= 60 AND @Total >= 120 SET @Qualify = 1	
	IF @Personal >= 4 AND @Team >= 60 AND @Total >= 120 SET @Qualify = 1	
	SET @Result = CAST( dbo.wtfn_Min(4 - @Personal,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(60 - @Team,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(120 - @Total,0) AS VARCHAR(10))
END

--	Presidential Ambassador 	
IF @Title = 10
BEGIN
--	IF @Personal >= 20 AND @Team >= 80 AND @Total >= 200 SET @Qualify = 1
	IF @Personal >= 8 AND @Team >= 80 AND @Total >= 200 SET @Qualify = 1
	SET @Result = CAST( dbo.wtfn_Min(8 - @Personal,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(80 - @Team,0) AS VARCHAR(10)) + '/' + CAST( dbo.wtfn_Min(200 - @Total,0) AS VARCHAR(10))
END

--This member must be bonus qualified to be promoted.
IF @BonusQualify <= 1 SET @Qualify = 0 
	
--	print 'Title: ' + CAST(@Title AS varchar(10)) + '   Personal: ' + CAST(@Personal AS varchar(10)) + '   Team: ' + CAST(@Team AS varchar(10)) + '   Total: ' + CAST(@Total AS varchar(10))

GO
