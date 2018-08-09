EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_8_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_8_Test 7109, 3, @Qualify OUTPUT PRINT @Qualify

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_8_Test
   @MemberID int,
   @Title int,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @cnt int, @QualifyDate datetime
SET @Qualify = 0

-- Always pass test for Life Coach
IF @Title <= 1 SET @Qualify = 1

-- Test for Senior Coach 
IF @Title = 2 
BEGIN
--	SELECT @QualifyDate = EnrollDate FROM Member Where MemberID = @MemberID
--	SET @QualifyDate = DATEADD(d, 60, @QualifyDate )
	SELECT @cnt = COUNT(MemberID) FROM Member WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4
	IF @cnt >= 2 SET @Qualify = 1	
END

-- Test for Master Coach 
IF @Title = 3 
BEGIN
	SELECT @QualifyDate = EnrollDate FROM Member Where MemberID = @MemberID
	SET @QualifyDate = DATEADD(yy, 1, @QualifyDate )
	SELECT @cnt = COUNT(MemberID) FROM Member WHERE ReferralID = @MemberID AND Title >= 2 AND EnrollDate < @QualifyDate
	IF @cnt >= 10 SET @Qualify = 1	
END

GO
