EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_11_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_11_Test 14862, 5, 0, @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 11

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_11_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Level int, @Options2 varchar(100), @Personal int, @Customer int, @Amount money, @FromDate datetime, @ToDate datetime, @BonusQualify int
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0
SET @ToDate = @EnrollDate
SET @FromDate = DATEADD(m, -1, @ToDate)

SELECT @Level = [Level], @Options2 = Options2, @BonusQualify = Qualify FROM Member WHERE MemberID = @MemberID

SET @Personal = 0
SET @Customer = 0
SET @Amount = 0

IF @Title >= 3 AND @Title <= 7
BEGIN
--	Get total number of active personal recruits
	SELECT @Personal = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND EnrollDate <= @EnrollDate

--	Get total number of active personal customers
	SELECT @Customer = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 0 AND EnrollDate <= @EnrollDate
END

IF @BonusQualify >  1
BEGIN
--	Associate	
	IF @Title = 1 SET @Qualify = 1	

--	Affiliate	
	IF @Title = 2 SET @Qualify = 1	

--	Junior
	IF @Title = 3 AND ( (@Personal >= 3 AND @Customer >= 5) OR CHARINDEX( @Options2, '101' ) > 0 ) SET @Qualify = 1

--	Partner	
	IF @Title = 4 AND ( (@Personal >= 5 AND @Customer >= 10) OR CHARINDEX( @Options2, '102' ) > 0 ) SET @Qualify = 1

--	Senior	
	IF @Title = 5 AND ( (@Personal >= 15 AND @Customer >= 25) OR CHARINDEX( @Options2, '103' ) > 0 ) SET @Qualify = 1

--	Executive
	IF @Title = 6 AND @Personal >= 30 AND @Customer >= 45 SET @Qualify = 1

--	Diamond 	
	IF @Title = 7 AND @Personal >= 60 AND @Customer >= 100 SET @Qualify = 1
END
GO

