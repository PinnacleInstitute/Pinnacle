EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_21_Test'
GO

--DECLARE @Qualify int, @Result varchar(20) EXEC pts_Commission_CalcAdvancement_21_Test 39524, 6, 0, @Qualify OUTPUT, @Result OUTPUT PRINT @Qualify PRINT @Result
--select * from Title where CompanyID = 21

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_21_Test
   @MemberID int,
   @Title int,
   @EnrollDate datetime,
   @Qualify int OUTPUT,
   @Result VARCHAR(20) OUTPUT
AS

SET NOCOUNT ON

DECLARE @Options2 varchar(100), @cnt int, @GroupVolume money , @Max int, @Goal money, @StarTitle int
SET @Qualify = 0
SET @Result = ''
SET @cnt = 0
SET @GroupVolume = 0
SET @StarTitle = 0

-- Automatically qualify member and affiliate title
IF @Title <= 2 SET @Qualify = 1	

-- 1 Star, 2 Star, 3 Star
IF  @Title IN (3,4,5)
BEGIN
	SET @StarTitle = @Title
	
	-- Get number of referred Affiliates (1 Star+)
	SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Title >= 2
	SET @Result = '0'
	IF @Title = 3 AND @cnt >= 1 SET @Qualify = 1
	IF @Title = 4 AND @cnt >= 2 SET @Qualify = 1
	IF @Title = 5 AND @cnt >= 3 SET @Qualify = 1

--	Get 3 Star current team volume for need next calc
	IF @Title = 5
	BEGIN
		SET @Max = 150 * .35
		SELECT @GroupVolume = ISNULL( SUM( dbo.wtfn_Max( BV2 + QV2, @Max) ), 0) FROM Member WHERE ReferralID = @MemberID
	END 

--	IF not enough referrals check for Diamond group sales volume
	IF @Qualify = 0 SET @Title = 6
END

-- All other titles 
IF  @Title >= 6 AND @Title <= 14 
BEGIN
	SET @Goal = CASE @Title
		WHEN 6 THEN 150      -- Diamond
		WHEN 7 THEN 600      -- 2 Diamond
		WHEN 8 THEN 2000     -- 3 Diamond
		WHEN 9 THEN 6000     -- Platinum 
		WHEN 10 THEN 18000   -- 2Platinum
		WHEN 11 THEN 60000   -- 3Platinum
		WHEN 12 THEN 180000  -- Ambassador
		WHEN 13 THEN 500000  -- 2 Ambassador
		WHEN 14 THEN 1500000 -- 3 Ambassador
		ELSE 1500000
	END
	SET @Max = @Goal * .35
	SELECT @GroupVolume = ISNULL( SUM( dbo.wtfn_Max( BV2 + QV2, @Max) ), 0) FROM Member WHERE ReferralID = @MemberID
	IF @GroupVolume >= @Goal  SET @Qualify = 1
	
--	IF they wer a star test and not qualified for a dialmond
	IF @StarTitle > 0 AND @Qualify = 0 SET @Title = @StarTitle
	
END

-- Get Next Needed Amount
SET @Result = CAST( CASE @Title
	WHEN 3 THEN 1      -- 1 Star
	WHEN 4 THEN 1      -- 2 Star
	WHEN 5 THEN 1      -- 3 Star
	WHEN 6 THEN 150 - @GroupVolume   -- Diamond
	WHEN 7 THEN 600 - @GroupVolume      -- 2 Diamond
	WHEN 8 THEN 2000 - @GroupVolume      -- 3 Diamond
	WHEN 9 THEN 6000 - @GroupVolume     -- Platinum
	WHEN 10 THEN 18000 - @GroupVolume    -- 2 Platinum 
	WHEN 11 THEN 60000 - @GroupVolume   -- 3 Platinum
	WHEN 12 THEN 180000 - @GroupVolume   -- Ambassador
	WHEN 13 THEN 500000 - @GroupVolume  -- 2 Ambassador
	WHEN 14 THEN 1500000 - @GroupVolume  -- 3 Ambassador
END AS VARCHAR(10) )

GO
