EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_19_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_19_Test 12551, 7, 0, @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 19

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_19_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @team int, @sales int
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0

--Get total active personal sales
SET @sales = 0
IF  @Title > 1
BEGIN
	SELECT @sales = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Level = 0
END

--Get total active personal recruits >= previous title
SET @team = 0
IF  @Title >= 3 AND @Title <= 7 
BEGIN
	SELECT @team = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Level = 1 AND Title >= @Title-1
END

--Get total active recruits in any leg >= previous title
IF  @Title >= 8 AND @Title <= 10 
BEGIN
	SELECT @team = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Level = 1 AND MaxMembers >= @Title-1
END

-- Affiliate
IF @Title <= 1 SET @Qualify = 1	
	
-- Qualified Affiliate	
IF @Title = 2 AND @sales >= 1 SET @Qualify = 1	

-- Senior Affiliate	
IF @Title = 3 AND @team >= 2 AND @sales >= 2 SET @Qualify = 1	

-- Affiliate Trainer
IF @Title = 4 AND @team >= 2 AND @sales >= 2 SET @Qualify = 1	

-- Team Leader	
IF @Title = 5 AND @team >= 2 AND @sales >= 2 SET @Qualify = 1	

-- Sales Manager	
IF @Title = 6 AND @team >= 4 AND @sales >= 5 SET @Qualify = 1	

-- Marketing Director	
IF @Title = 7 AND @team >= 4 AND @sales >= 10 SET @Qualify = 1	

-- Vice President	
IF @Title = 8 AND @team >= 5 AND @sales >= 15 SET @Qualify = 1	

-- Senior VP	
IF @Title = 9 AND @team >= 5 AND @sales >= 20 SET @Qualify = 1	

-- Executive VP	
IF @Title = 10 AND @team >= 5 AND @sales >= 25 SET @Qualify = 1	

--print 'Title: ' + CAST(@Title AS varchar(10)) + '   Personal: ' + CAST(@Personal AS varchar(10)) + '   Team: ' + CAST(@Team AS varchar(10))

GO
