EXEC [dbo].pts_CheckProc 'pts_Member_CalcTitle'
GO

--EXEC pts_Member_CalcTitle 582, '10/1/08'

CREATE PROCEDURE [dbo].pts_Member_CalcTitle
   @CompanyID int,
   @FromDate datetime
AS

SET NOCOUNT ON

-- *********************************************************************************
IF @CompanyID = 582
BEGIN
-- *********************************************************************************

DECLARE @MemberID int, @QV money, @SponsorID int, @Title int, @NewTitle int, @Legs int, @MinLegs int
DECLARE @MemberTitleID int, @MinTitle int, @TitleDate datetime

-- --------------------------------------------------------------------------------------------------------
-- calculate the earned title for each member
-- if title has changed, update the membertitle log 
-- --------------------------------------------------------------------------------------------------------
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Title, MinTitle, TitleDate
FROM Member WHERE CompanyID = @CompanyID AND Status = 1

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @MinTitle, @TitleDate

WHILE @@FETCH_STATUS = 0
BEGIN
--	-- get their number of legs and total points from their sponsored members
	SELECT  @Legs = ISNULL(COUNT(MemberID),0), @QV = ISNULL(SUM(QV),0)
	FROM Member WHERE SponsorID = @MemberID

	SET @NewTitle = 0

--	-- Test for 10 Star qualification
	IF @NewTitle = 0 AND @Legs >= 5 AND @QV >= 100000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 15000
		IF @MinLegs >= 5 SET @NewTitle = 10
	END
--	-- Test for 9 Star qualification
	IF @NewTitle = 0 AND @Legs >= 4 AND @QV >= 50000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 10000
		IF @MinLegs >= 4 SET @NewTitle = 9
	END
--	-- Test for 8 Star qualification
	IF @NewTitle = 0 AND @Legs >= 3 AND @QV >= 20000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 6000
		IF @MinLegs >= 3 SET @NewTitle = 8
	END
--	-- Test for 7 Star qualification
	IF @NewTitle = 0 AND @Legs >= 3 AND @QV >= 15000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 4000
		IF @MinLegs >= 3 SET @NewTitle = 7
	END
--	-- Test for 6 Star qualification
	IF @NewTitle = 0 AND @Legs >= 3 AND @QV >= 10000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 2500
		IF @MinLegs >= 3 SET @NewTitle = 6
	END
--	-- Test for 5 Star qualification
	IF @NewTitle = 0 AND @Legs >= 3 AND @QV >= 7500
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 2000
		IF @MinLegs >= 3 SET @NewTitle = 5
	END
--	-- Test for 4 Star qualification
	IF @NewTitle = 0 AND @Legs >= 3 AND @QV >= 5000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 1500
		IF @MinLegs >= 3 SET @NewTitle = 4
	END
--	-- Test for 3 Star qualification
	IF @NewTitle = 0 AND @Legs >= 3 AND @QV >= 2500
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 800
		IF @MinLegs >= 3 SET @NewTitle = 3
	END
--	-- Test for 2 Star qualification
	IF @NewTitle = 0 AND @Legs >= 2 AND @QV >= 1000
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 400
		IF @MinLegs >= 2 SET @NewTitle = 2
	END
--	-- Test for 1 Star qualification
	IF @NewTitle = 0 AND @Legs >= 2 AND @QV >= 400
	BEGIN
		SELECT @MinLegs = ISNULL(COUNT(MemberID),0) FROM Member 
		WHERE SponsorID = @MemberID AND QV >= 100
		IF @MinLegs >= 2 SET @NewTitle = 1
	END

--	if the title changed
	IF @Title != @NewTitle
	BEGIN
--		-- If the new title is lower than the minimum title AND
--		-- the minimum title is locked forever or locked past the date being processed THEN
--		-- Don't change the title
		IF @NewTitle < @MinTitle AND ( @TitleDate = 0 OR @TitleDate >= @FromDate ) SET @NewTitle = @Title
		
		IF @Title != @NewTitle
		BEGIN
			UPDATE Member SET Title = @NewTitle WHERE MemberID = @MemberID
--			-- MemberTitleID,MemberID,TitleDate,Title,IsEarned,UserID
			EXEC pts_MemberTitle_Add @MemberTitleID, @MemberID, @FromDate, @NewTitle, 1, 1
		END	
	END

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @MinTitle, @TitleDate
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


END

GO