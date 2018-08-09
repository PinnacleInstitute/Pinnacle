EXEC [dbo].pts_CheckProc 'pts_Pinnacle_GroupStats'
GO

--DECLARE @Result varchar(1000) EXEC pts_Pinnacle_GroupStats 6528, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_Pinnacle_GroupStats
   @GroupID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Group Membership Statistics
--  Active Level 0-3 Members today, week, all
--  Total Members
--  Active Members
--  Trial Members
--  Free Members
--  Suspended Members
--  InActive Members
--  Cancelled Members
--  Terminated Members
-- ***********************************************************************
DECLARE	@Now datetime, @StartDate datetime, @EndDate datetime, @Days int, @Total int
DECLARE @L0_1 int, @L0_7 int, @L0_99 int
DECLARE @L1_1 int, @L1_7 int, @L1_99 int
DECLARE @L2_1 int, @L2_7 int, @L2_99 int
DECLARE @L3_1 int, @L3_7 int, @L3_99 int
DECLARE @S1 int, @S2 int, @S3 int, @S4 int, @S5 int, @S6 int, @S7 int, @S99 int

SET	@L0_1 = 0  SET @L0_7 = 0  SET @L0_99 = 0
SET	@L1_1 = 0  SET @L1_7 = 0  SET @L1_99 = 0
SET	@L2_1 = 0  SET @L2_7 = 0  SET @L2_99 = 0
SET	@L3_1 = 0  SET @L3_7 = 0  SET @L3_99 = 0
SET	@S1 = 0 SET @S2 = 0 SET @S3 = 0 SET @S4 = 0 SET @S5 = 0 SET @S6 = 0 SET @S7 = 0 SET @S99 = 0

SET @Now = dbo.wtfn_DateOnly(GETDATE())
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now

SELECT @L0_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 0 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @L1_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @L2_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 2 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @L3_1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 3 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

SELECT @L0_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 0 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @L1_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @L2_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 2 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @L3_7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 3 AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- ****************************************
SELECT @L0_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 0 AND Status >= 1 AND Status <= 4 AND EnrollDate < @EndDate

SELECT @L1_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND EnrollDate < @EndDate

SELECT @L2_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 2 AND Status >= 1 AND Status <= 4 AND EnrollDate < @EndDate

SELECT @L3_99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE  GroupID = @GroupID AND [Level] = 3 AND Status >= 1 AND Status <= 4 AND EnrollDate < @EndDate

-- ****************************************
SELECT @S1 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 1
SELECT @S2 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 2
SELECT @S3 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 3
SELECT @S4 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 4
SELECT @S5 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 5
SELECT @S6 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 6
SELECT @S7 = ISNULL(COUNT(MemberID),0) FROM Member WHERE  GroupID = @GroupID AND Status = 7
SET @S99 = @S1 + @S2 + @S3 + @S4 + @S5 + @S6 + @S7 + @S99

SET @Result = '<PTSSTATS ' + 
'l0_1="'  + CAST(@L0_1 AS VARCHAR(10)) + '" ' +
'l1_1="'  + CAST(@L1_1 AS VARCHAR(10)) + '" ' +
'l2_1="'  + CAST(@L2_1 AS VARCHAR(10)) + '" ' +
'l3_1="'  + CAST(@L3_1 AS VARCHAR(10)) + '" ' +
'l0_7="'  + CAST(@L0_7 AS VARCHAR(10)) + '" ' +
'l1_7="'  + CAST(@L1_7 AS VARCHAR(10)) + '" ' +
'l2_7="'  + CAST(@L2_7 AS VARCHAR(10)) + '" ' +
'l3_7="'  + CAST(@L3_7 AS VARCHAR(10)) + '" ' +
'l0_99="'  + CAST(@L0_99 AS VARCHAR(10)) + '" ' +
'l1_99="'  + CAST(@L1_99 AS VARCHAR(10)) + '" ' +
'l2_99="'  + CAST(@L2_99 AS VARCHAR(10)) + '" ' +
'l3_99="'  + CAST(@L3_99 AS VARCHAR(10)) + '" ' +
's1="'  + CAST(@S1 AS VARCHAR(10)) + '" ' +
's2="'  + CAST(@S2 AS VARCHAR(10)) + '" ' +
's3="'  + CAST(@S3 AS VARCHAR(10)) + '" ' +
's4="'  + CAST(@S4 AS VARCHAR(10)) + '" ' +
's5="'  + CAST(@S5 AS VARCHAR(10)) + '" ' +
's6="'  + CAST(@S6 AS VARCHAR(10)) + '" ' +
's7="'  + CAST(@S7 AS VARCHAR(10)) + '" ' +
's99="'  + CAST(@S99 AS VARCHAR(10)) + '" ' +
'/>'

GO

