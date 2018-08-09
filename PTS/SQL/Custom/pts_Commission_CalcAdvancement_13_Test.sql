EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_13_Test'
GO

--DECLARE @Qualify int EXEC pts_Commission_CalcAdvancement_13_Test 10300, 5, 0, @Qualify OUTPUT PRINT @Qualify
--select * from Title where CompanyID = 13

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_13_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Options2 varchar(100), @Members int, @Legs int
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0

SELECT @Options2 = Options2, @Legs = Process FROM Member WHERE MemberID = @MemberID

SET @Members = 0

IF @Title >= 2 AND @Title <= 5
BEGIN
--	Get total number of active Silver+ recruits
	SELECT @Members = COUNT(MemberID) FROM Member
	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Title >= 2 AND EnrollDate <= @EnrollDate

--  Credit Silver Pack Purchase
	IF CHARINDEX('101', @Options2) > 0 SET @Members = @Members + 2

--  Credit Gold Pack Purchase
	IF CHARINDEX('102', @Options2) > 0 SET @Members = @Members + 3

--  Credit Platinum Pack Purchase
	IF CHARINDEX('103', @Options2) > 0 SET @Members = @Members + 4

--  Credit Upgrade Affiliate-Silver
	IF CHARINDEX('121', @Options2) > 0 SET @Members = @Members + 2

--  Credit Upgrade Affiliate-Gold
	IF CHARINDEX('122', @Options2) > 0 SET @Members = @Members + 3

--  Credit Upgrade Affiliate-Platinum
	IF CHARINDEX('123', @Options2) > 0 SET @Members = @Members + 4

--  Credit Upgrade Silver-Gold
	IF CHARINDEX('124', @Options2) > 0 SET @Members = @Members + 1

--  Credit Upgrade Silver-Platinum
	IF CHARINDEX('125', @Options2) > 0 SET @Members = @Members + 2

--  Credit Upgrade Gold-Platinum
	IF CHARINDEX('126', @Options2) > 0 SET @Members = @Members + 1
END

--IF @Title >= 6 AND @Title <= 11
--BEGIN
--	SELECT @Legs = COUNT(MemberID) FROM Member
--	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND BV2 >= 12 AND EnrollDate <= @EnrollDate
--END
--	-- Affiliate	
IF @Title = 1 SET @Qualify = 1	

--	-- Silver
IF @Title = 2 AND @Members >= 2 SET @Qualify = 1

--	-- Gold	
IF @Title = 3 AND @Members >= 3 SET @Qualify = 1

--	-- Platinum	
IF @Title = 4 AND @Members >= 4 SET @Qualify = 1

--	-- Emerald
IF @Title = 5 AND @Members >= 6 SET @Qualify = 1

--	-- Ruby 	
IF @Title = 6 AND @Legs >= 2 SET @Qualify = 1

--	-- Diamond 	
IF @Title = 7 AND @Legs >= 5 SET @Qualify = 1

--	-- Blue Diamond 	
IF @Title = 8 AND @Legs >= 8 SET @Qualify = 1

--	-- Presidential 	
IF @Title = 9 AND @Legs >= 12 SET @Qualify = 1

--	-- Ambassador 	
IF @Title = 10 AND @Legs >= 16 SET @Qualify = 1

--	-- Global 	
IF @Title = 11 AND @Legs >= 20 SET @Qualify = 1


GO

