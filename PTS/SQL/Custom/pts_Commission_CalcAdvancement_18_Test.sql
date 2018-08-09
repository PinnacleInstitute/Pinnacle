EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_18_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_18_Test 10733, 3, 0, @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 18

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_18_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Options2 varchar(100), @Personal int, @Team int, @Total int, @Line int, @cnt int
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0
SET @cnt = 0

IF  @Title = 2 
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status <= 4 AND EnrollDate >= @EnrollDate AND Title > 1
END

IF  @Title >= 3 AND @Title <= 5 
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status <= 4 AND EnrollDate >= @EnrollDate AND Title >= @Title-1
END

IF  @Title >= 6 AND @Title <= 7 
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status <= 4 AND EnrollDate >= @EnrollDate AND MaxMembers >= @Title-1
END

-- Free Affiliate cannot be promoted
IF @Title <= 1 SET @Qualify = 0	
-- Account Manager	
IF @Title = 2 AND @cnt >= 5 SET @Qualify = 1	
-- Sales Manager
IF @Title = 3 AND @cnt >= 5 SET @Qualify = 1	
-- Sales Director
IF @Title = 4 AND @cnt >= 5 SET @Qualify = 1	
-- VP
IF @Title = 5 AND @cnt >= 5 SET @Qualify = 1	
-- SVP
IF @Title = 6 AND @cnt >= 10 SET @Qualify = 1	
-- EVP
IF @Title = 7 AND @cnt >= 15 SET @Qualify = 1	

--print 'Title: ' + CAST(@Title AS varchar(10)) + '   Personal: ' + CAST(@Personal AS varchar(10)) + '   Team: ' + CAST(@Team AS varchar(10))

GO
