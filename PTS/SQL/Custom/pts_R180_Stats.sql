EXEC [dbo].pts_CheckProc 'pts_R180_Stats'
GO

--DECLARE @Result varchar(1000) EXEC pts_R180_Stats 0, @Result OUTPUT print @Result

CREATE PROCEDURE [dbo].pts_R180_Stats
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
-- ***********************************************************************
--	Company Statistics
-- ***********************************************************************
DECLARE	@CompanyID int, @Now datetime, @StartDate datetime, @EndDate datetime, @Total int
DECLARE @MA1 int, @MA7 int, @MA99 int  -- Members Active
DECLARE @MC1 int, @MC7 int, @MC99 int  -- Members Inactive
DECLARE @MT1 int, @MT7 int, @MT99 int  -- Members Total
DECLARE @FP1 int, @FP7 int, @FP99 int  -- Friends Pending
DECLARE @FA1 int, @FA7 int, @FA99 int  -- Friends Active
DECLARE @FC1 int, @FC7 int, @FC99 int  -- Friends Inactive
DECLARE @FT1 int, @FT7 int, @FT99 int  -- Friends Total 

DECLARE @P11 int, @P17 int, @P199 int  -- Ads Placed - Place 1
DECLARE @C11 int, @C17 int, @C199 int  -- Ads Clicked - Place 1
DECLARE @P21 int, @P27 int, @P299 int  -- Ads Placed - Place 2
DECLARE @C21 int, @C27 int, @C299 int  -- Ads Clicked - Place 2
DECLARE @P31 int, @P37 int, @P399 int  -- Ads Placed - Place 3
DECLARE @C31 int, @C37 int, @C399 int  -- Ads Clicked - Place 3
DECLARE @P41 int, @P47 int, @P499 int  -- Ads Placed - Place 4
DECLARE @C41 int, @C47 int, @C499 int  -- Ads Clicked - Place 4
DECLARE @P51 int, @P57 int, @P599 int  -- Ads Placed - Total
DECLARE @C51 int, @C57 int, @C599 int  -- Ads Clicked - Total
DECLARE @R1 money, @R2 money, @R3 money, @R4 money, @R5 money  -- Ads Click Rates

SET @CompanyID = 12

SET	@MA1 = 0 SET @MA7 = 0 SET @MA99 = 0 
SET	@MC1 = 0 SET @MC7 = 0 SET @MC99 = 0 
SET	@MT1 = 0 SET @MT7 = 0 SET @MT99 = 0 
SET	@FP1 = 0 SET @FP7 = 0 SET @FP99 = 0 
SET	@FA1 = 0 SET @FA7 = 0 SET @FA99 = 0 
SET	@FC1 = 0 SET @FC7 = 0 SET @FC99 = 0 
SET	@FT1 = 0 SET @FT7 = 0 SET @FT99 = 0 

SET @P11 = 0 SET @P17 = 0 SET @P199 = 0
SET @C11 = 0 SET @C17 = 0 SET @C199 = 0
SET @P21 = 0 SET @P27 = 0 SET @P299 = 0
SET @C21 = 0 SET @C27 = 0 SET @C299 = 0
SET @P31 = 0 SET @P37 = 0 SET @P399 = 0
SET @C31 = 0 SET @C37 = 0 SET @C399 = 0
SET @P41 = 0 SET @P47 = 0 SET @P499 = 0
SET @C41 = 0 SET @C47 = 0 SET @C499 = 0
SET @P51 = 0 SET @P57 = 0 SET @P599 = 0
SET @C51 = 0 SET @C57 = 0 SET @C599 = 0
SET @R1 = 0 SET @R2 = 0 SET @R3 = 0 SET @R4 = 0 SET @R5 = 0 

SET @Now = dbo.wtfn_DateOnly(GETDATE())
IF @Days > 0 SET @Now = DATEADD(d, @Days * -1, @Now)
SET @EndDate = DATEADD(d, 1, @Now)
 
--	-- ****************************************
SET @StartDate = @Now
-- Members
SELECT @MA1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 3 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @MC1 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @MT1 = @MA1 + @MC1

SELECT @FP1 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status = 1 AND fr.FriendDate >= @StartDate AND fr.FriendDate < @EndDate

SELECT @FA1 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status = 2 AND fr.FriendDate >= @StartDate AND fr.FriendDate < @EndDate

SELECT @FC1 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status >= 3 AND fr.FriendDate >= @StartDate AND fr.FriendDate < @EndDate

-- Total Friends
SET @FT1 = @FP1 + @FA1 + @FC1

-- Ads
SELECT @P11 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 1 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C11 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 1 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SELECT @P21 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 2 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C21 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 2 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
--SELECT @P31 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 3 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
--SELECT @C31 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 3 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SELECT @P41 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 4 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C41 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 4 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SET @P51 = @P11 + @P21 + @P31 + @P41 
SET @C51 = @C11 + @C21 + @C31 + @C41 

-- ****************************************
SET @Days = (DATEPART(dw,@Now)-1) * -1
IF @Days = 0 SET @Days = -7
SET @StartDate = DATEADD(d, @Days, @EndDate)

-- Members
SELECT @MA7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

SELECT @MC7 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 4 AND EnrollDate >= @StartDate AND EnrollDate < @EndDate

-- Total Members
SET @MT7 = @MA7 + @MC7

SELECT @FP7 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status = 1 AND fr.FriendDate >= @StartDate AND fr.FriendDate < @EndDate

SELECT @FA7 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status = 2 AND fr.FriendDate >= @StartDate AND fr.FriendDate < @EndDate

SELECT @FC7 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status >= 3 AND fr.FriendDate >= @StartDate AND fr.FriendDate < @EndDate

-- Total Friends
SET @FT7 = @FP7 + @FA7 + @FC7

-- Ads
SELECT @P17 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 1 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C17 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 1 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SELECT @P27 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 2 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C27 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 2 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
--SELECT @P37 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 3 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
--SELECT @C37 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 3 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SELECT @P47 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 4 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C47 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 4 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SET @P57 = @P17 + @P27 + @P37 + @P47 
SET @C57 = @C17 + @C27 + @C37 + @C47


-- ****************************************
-- Members
SELECT @MA99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND EnrollDate < @EndDate

SELECT @MC99 = ISNULL(COUNT(MemberID),0) FROM Member
WHERE CompanyID = @CompanyID AND Status >= 4 AND EnrollDate < @EndDate

-- Total Members
SET @MT99 = @MA99 + @MC99

SELECT @FP99 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status = 1 AND fr.FriendDate < @EndDate

SELECT @FA99 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status = 2 AND fr.FriendDate < @EndDate

SELECT @FC99 = ISNULL(COUNT(fr.MemberID),0) FROM Friend AS fr JOIN Member AS me ON fr.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND fr.Status >= 3 AND fr.FriendDate < @EndDate

-- Total Friends
SET @FT99 = @FP99 + @FA99 + @FC99

-- Ads
SELECT @P199 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 1 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C199 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 1 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SELECT @P299 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 2 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C299 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 2 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
--SELECT @P399 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 3 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
--SELECT @C399 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 3 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SELECT @P499 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 4 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate
SELECT @C499 = ISNULL(COUNT(AdTrackID),0) FROM AdTrack WHERE Place = 4 AND PlaceDate >= @StartDate AND PlaceDate < @EndDate AND ClickDate > 0
SET @P599 = @P199 + @P299 + @P399 + @P499 
SET @C599 = @C199 + @C299 + @C399 + @C499 
IF @P199 > 0 SET @R1 = ((CAST(@C199 AS MONEY) / CAST(@P199 AS money)) * 100) 
IF @P299 > 0 SET @R2 = ((CAST(@C299 AS MONEY) / CAST(@P299 AS money)) * 100) 
--IF @P399 > 0 SET @R3 = ((CAST(@C399 AS MONEY) / CAST(@P399 AS money)) * 100) 
IF @P499 > 0 SET @R4 = ((CAST(@C499 AS MONEY) / CAST(@P499 AS money)) * 100) 
IF @P599 > 0 SET @R5 = ((CAST(@C599 AS MONEY) / CAST(@P599 AS money)) * 100) 

SET @Result = '<PTSSTATS ' + 
'ma1="'  + dbo.wtfn_FormatNumber2(CAST(@MA1 AS VARCHAR(10))) + '" ' +
'ma7="'  + dbo.wtfn_FormatNumber2(CAST(@MA7 AS VARCHAR(10)))  + '" ' +
'ma99="' + dbo.wtfn_FormatNumber2(CAST(@MA99 AS VARCHAR(10))) + '" ' +
'mc1="'  + dbo.wtfn_FormatNumber2(CAST(@MC1 AS VARCHAR(10))) + '" ' +
'mc7="'  + dbo.wtfn_FormatNumber2(CAST(@MC7 AS VARCHAR(10)))  + '" ' +
'mc99="' + dbo.wtfn_FormatNumber2(CAST(@MC99 AS VARCHAR(10))) + '" ' +
'mt1="'  + dbo.wtfn_FormatNumber2(CAST(@MT1 AS VARCHAR(10))) + '" ' +
'mt7="'  + dbo.wtfn_FormatNumber2(CAST(@MT7 AS VARCHAR(10)))  + '" ' +
'mt99="' + dbo.wtfn_FormatNumber2(CAST(@MT99 AS VARCHAR(10))) + '" ' +
'fp1="'  + dbo.wtfn_FormatNumber2(CAST(@FP1 AS VARCHAR(10))) + '" ' +
'fp7="'  + dbo.wtfn_FormatNumber2(CAST(@FP7 AS VARCHAR(10)))  + '" ' +
'fp99="' + dbo.wtfn_FormatNumber2(CAST(@FP99 AS VARCHAR(10))) + '" ' +
'fa1="'  + dbo.wtfn_FormatNumber2(CAST(@FA1 AS VARCHAR(10))) + '" ' +
'fa7="'  + dbo.wtfn_FormatNumber2(CAST(@FA7 AS VARCHAR(10)))  + '" ' +
'fa99="' + dbo.wtfn_FormatNumber2(CAST(@FA99 AS VARCHAR(10))) + '" ' +
'fc1="'  + dbo.wtfn_FormatNumber2(CAST(@FC1 AS VARCHAR(10))) + '" ' +
'fc7="'  + dbo.wtfn_FormatNumber2(CAST(@FC7 AS VARCHAR(10)))  + '" ' +
'fc99="' + dbo.wtfn_FormatNumber2(CAST(@FC99 AS VARCHAR(10))) + '" ' +
'ft1="'  + dbo.wtfn_FormatNumber2(CAST(@FT1 AS VARCHAR(10))) + '" ' +
'ft7="'  + dbo.wtfn_FormatNumber2(CAST(@FT7 AS VARCHAR(10)))  + '" ' +
'ft99="' + dbo.wtfn_FormatNumber2(CAST(@FT99 AS VARCHAR(10))) + '" ' +
'p11="'  + dbo.wtfn_FormatNumber2(CAST(@P11 AS VARCHAR(10))) + '" ' +
'p17="'  + dbo.wtfn_FormatNumber2(CAST(@P17 AS VARCHAR(10)))  + '" ' +
'p199="' + dbo.wtfn_FormatNumber2(CAST(@P199 AS VARCHAR(10))) + '" ' +
'c11="'  + dbo.wtfn_FormatNumber2(CAST(@C11 AS VARCHAR(10))) + '" ' +
'c17="'  + dbo.wtfn_FormatNumber2(CAST(@C17 AS VARCHAR(10)))  + '" ' +
'c199="' + dbo.wtfn_FormatNumber2(CAST(@C199 AS VARCHAR(10))) + '" ' +
'p21="'  + dbo.wtfn_FormatNumber2(CAST(@P21 AS VARCHAR(10))) + '" ' +
'p27="'  + dbo.wtfn_FormatNumber2(CAST(@P27 AS VARCHAR(10)))  + '" ' +
'p299="' + dbo.wtfn_FormatNumber2(CAST(@P299 AS VARCHAR(10))) + '" ' +
'c21="'  + dbo.wtfn_FormatNumber2(CAST(@C21 AS VARCHAR(10))) + '" ' +
'c27="'  + dbo.wtfn_FormatNumber2(CAST(@C27 AS VARCHAR(10)))  + '" ' +
'c299="' + dbo.wtfn_FormatNumber2(CAST(@C299 AS VARCHAR(10))) + '" ' +
--'p31="'  + dbo.wtfn_FormatNumber2(CAST(@P31 AS VARCHAR(10))) + '" ' +
--'p37="'  + dbo.wtfn_FormatNumber2(CAST(@P37 AS VARCHAR(10)))  + '" ' +
--'p399="' + dbo.wtfn_FormatNumber2(CAST(@P399 AS VARCHAR(10))) + '" ' +
--'c31="'  + dbo.wtfn_FormatNumber2(CAST(@C31 AS VARCHAR(10))) + '" ' +
--'c37="'  + dbo.wtfn_FormatNumber2(CAST(@C37 AS VARCHAR(10)))  + '" ' +
--'c399="' + dbo.wtfn_FormatNumber2(CAST(@C399 AS VARCHAR(10))) + '" ' +
'p41="'  + dbo.wtfn_FormatNumber2(CAST(@P41 AS VARCHAR(10))) + '" ' +
'p47="'  + dbo.wtfn_FormatNumber2(CAST(@P47 AS VARCHAR(10)))  + '" ' +
'p499="' + dbo.wtfn_FormatNumber2(CAST(@P499 AS VARCHAR(10))) + '" ' +
'c41="'  + dbo.wtfn_FormatNumber2(CAST(@C41 AS VARCHAR(10))) + '" ' +
'c47="'  + dbo.wtfn_FormatNumber2(CAST(@C47 AS VARCHAR(10)))  + '" ' +
'c499="' + dbo.wtfn_FormatNumber2(CAST(@C499 AS VARCHAR(10))) + '" ' +
'p51="'  + dbo.wtfn_FormatNumber2(CAST(@P51 AS VARCHAR(10))) + '" ' +
'p57="'  + dbo.wtfn_FormatNumber2(CAST(@P57 AS VARCHAR(10)))  + '" ' +
'p599="' + dbo.wtfn_FormatNumber2(CAST(@P599 AS VARCHAR(10))) + '" ' +
'c51="'  + dbo.wtfn_FormatNumber2(CAST(@C51 AS VARCHAR(10))) + '" ' +
'c57="'  + dbo.wtfn_FormatNumber2(CAST(@C57 AS VARCHAR(10)))  + '" ' +
'c599="' + dbo.wtfn_FormatNumber2(CAST(@C599 AS VARCHAR(10))) + '" ' +
'r1="' + CAST(@R1 AS VARCHAR(10)) + '%" ' +
'r2="' + CAST(@R2 AS VARCHAR(10)) + '%" ' +
--'r3="' + CAST(@R3 AS VARCHAR(10)) + '%" ' +
'r4="' + CAST(@R4 AS VARCHAR(10)) + '%" ' +
'r5="' + CAST(@R5 AS VARCHAR(10)) + '%" ' +
'/>'

GO

