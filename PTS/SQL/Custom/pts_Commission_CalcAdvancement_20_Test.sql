EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_20_Test'
GO

--DECLARE @Qualify int, @Result varchar(20) EXEC pts_Commission_CalcAdvancement_20_Test 12556, 9, 0, @Qualify OUTPUT, @Result OUTPUT PRINT @Qualify PRINT @Result
--select * from Title where CompanyID = 20

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_20_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT,
   @Result VARCHAR(20) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Personal int, @Team int 
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0
SET @Result = ''
SET @Personal = 0
SET @Team = 0

-- Automatically qualify member title
IF @Title <= 1 SET @Qualify = 1	
	
-- Missionary	
IF @Title = 2
BEGIN
	SELECT @Personal = COUNT(*) FROM Member AS me WHERE ReferralID = @MemberID AND Status IN (1,4) AND Qualify > 1
	AND 3 <= ( SELECT COUNT(*) FROM Member WHERE ReferralID = me.MemberID AND Status IN (1,4) AND Qualify > 1) 
	IF @Personal >= 3 SET @Qualify = 1
	SET @Result = CAST( 3 - @Personal AS VARCHAR(10))
END

IF  @Title >= 3 AND @Title <= 4 
BEGIN
	SELECT @Personal = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status IN (1,4) AND Qualify > 1 AND Title >= @Title-1
END

-- Crusader	
IF @Title = 3
BEGIN
	IF @Personal >= 5 SET @Qualify = 1
	SET @Result = CAST( 5 - @Personal AS VARCHAR(10))
END

-- Humanitarian	
IF @Title = 4
BEGIN
	IF @Personal >= 10 SET @Qualify = 1
	SET @Result = CAST( 10 - @Personal AS VARCHAR(10))
END

GO
