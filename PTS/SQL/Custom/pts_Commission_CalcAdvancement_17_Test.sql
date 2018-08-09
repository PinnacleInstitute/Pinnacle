EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_17_Test'
GO

--DECLARE @Qualify int, @Result varchar(20) EXEC pts_Commission_CalcAdvancement_17_Test 35528, 6, 0, @Qualify OUTPUT, @Result OUTPUT PRINT @Qualify PRINT @Result
--select * from Title where CompanyID = 17

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_17_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT,
   @Result VARCHAR(20) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Options2 varchar(100), @Personal int, @Team int, @Total int, @Line int, @cnt int, @cnt2 int, @pos int, @code VARCHAR(5), @EnrollerDate datetime, @Enroller7Date datetime
IF @EnrollDate = 0 SET @EnrollDate = GETDATE()
SET @Qualify = 0
SET @Result = ''
SET @Personal = 0
SET @Team = 0
SET @Total = 0
SET @Line = @Title - 1

SELECT @Options2 = Options2, @EnrollerDate = dbo.wtfn_DateOnly(EnrollDate) FROM Member WHERE MemberID = @MemberID

SET @cnt = 0
SET @cnt2 = 0

--Test if they recruited 2 in their first 7 days
IF  @Title >= 5 AND @Title <= 6 
BEGIN
--	Allow existing members before 11/20/15 to have from 11/20 to 12/31 for the promotion
	IF @EnrollerDate < '11/20/2015' 
	BEGIN
	  SET @EnrollerDate = '11/20/2015' 
	  SET @Enroller7Date = '12/31/2015' 
	END
	ELSE
	BEGIN
		SET @Enroller7Date = DATEADD(D, 8, @EnrollerDate) 
	END
	SELECT @cnt2 = COUNT(*) FROM Member AS me WHERE me.ReferralID = @MemberID AND me.Status = 1 
	AND dbo.wtfn_DateOnly(me.EnrollDate) >= @EnrollerDate AND dbo.wtfn_DateOnly(me.EnrollDate) <= @Enroller7Date
	AND 1 <= ( SELECT COUNT(*) FROM Payment WHERE CompanyID = 17 AND OwnerID = me.MemberID AND Status = 3 AND PaidDate >= @EnrollerDate AND PaidDate <= @Enroller7Date )
END

IF  @Title >= 3 AND @Title <= 8 
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Title >= @Title-1
END

IF  @Title >= 9 AND @Title <= 10 
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND MaxMembers >= @Title-1
END

-- Automatically qualify member title
IF @Title <= 3 SET @Qualify = 1	
	
-- Affiliate	
--IF @Title = 2
--BEGIN
--	SET @pos = CHARINDEX('102', @Options2)
--	IF @pos > 0 SET @Qualify = 1
--END

-- Bronze	
--IF @Title = 3
--BEGIN
--	SET @pos = CHARINDEX('103', @Options2)
--	IF @cnt >= 2 OR @pos > 0 SET @Qualify = 1
--	SET @Result = CAST( 2 - @cnt AS VARCHAR(10))
--END

-- Silver	
IF @Title = 4
BEGIN
	SET @pos = CHARINDEX('104', @Options2)
	IF @cnt >= 2 OR @pos > 0 SET @Qualify = 1
	SET @Result = CAST( 2 - @cnt AS VARCHAR(10))
END

-- Gold	
IF @Title = 5
BEGIN
	SET @pos = CHARINDEX('105', @Options2)
	IF @cnt2 >= 2 OR @cnt >= 2 OR @pos > 0 SET @Qualify = 1
	SET @Result = CAST( 2 - @cnt AS VARCHAR(10))
END

-- Diamond	
IF @Title = 6
BEGIN
	IF @cnt2 >= 2 OR @cnt >= 2 SET @Qualify = 1
	SET @Result = CAST( 2 - @cnt AS VARCHAR(10))
END

-- 2 Diamond	
IF @Title = 7
BEGIN
	IF @cnt >= 5 SET @Qualify = 1
	SET @Result = CAST( 5 - @cnt AS VARCHAR(10))
END

-- 3 Diamond	
IF @Title = 8 
BEGIN
	IF @cnt >= 7 SET @Qualify = 1
	SET @Result = CAST( 7 - @cnt AS VARCHAR(10))
END

-- Platinum	
IF @Title = 9
BEGIN
	IF @cnt >= 10 SET @Qualify = 1
	SET @Result = CAST( 10 - @cnt AS VARCHAR(10))
END

-- Palladium	
IF @Title = 10
BEGIN
	IF @cnt >= 15 SET @Qualify = 1
	SET @Result = CAST( 15 - @cnt AS VARCHAR(10))
END


GO
