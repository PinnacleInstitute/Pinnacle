EXEC [dbo].pts_CheckProc 'pts_Member_PlaceBinary3'
GO
-- *********************************************************************************
-- * This function finds the next available spot to place a new member in a binary *
-- * It first checks the sponsor's binary placement option (weak,left,right)       *
-- * If weak, it check for < 2 personal enrollees and fills left and right.        *
-- * If weak and > 2 enrollees, it looks for the leg with the least new sales      *
-- * If not weak, it build down the specified left or right leg                    * 
-- *********************************************************************************
--DECLARE @SponsorID int, @Pos int SET @SponsorID = 37702
--EXEC pts_Member_PlaceBinary3 @SponsorID OUTPUT, @Pos OUTPUT PRINT CAST(@SponsorID AS VARCHAR(10)) + ':' + CAST(@Pos AS VARCHAR(10))

CREATE PROCEDURE [dbo].pts_Member_PlaceBinary3
   @SponsorID int OUTPUT,
   @Pos int OUTPUT
AS

SET NOCOUNT ON
--Declare some constants for maintenence and readability
DECLARE @PlaceWeak int, @PlaceLeft int, @PlaceRight int, @PlaceStrong int, @LeftSide int, @RightSide int
SET @PlaceWeak = 1
SET @PlaceLeft = 2
SET @PlaceRight = 3
SET @PlaceStrong = 4
SET @LeftSide = 0
SET @RightSide = 1

DECLARE @MemberID int, @Options2 varchar(40), @place int, @cnt int, @Member1ID int, @Member2ID int, @Sale1 money, @Sale2 money
-- Get the Sponsor's binary placement option
SELECT @Options2 = Options2 FROM Member WHERE MemberID = @SponsorID
SET @place = @PlaceWeak
IF CHARINDEX( 'B2', @Options2 ) > 0	SET @place = @PlaceLeft
IF CHARINDEX( 'B3', @Options2 ) > 0 SET @place = @PlaceRight
IF CHARINDEX( 'B4', @Options2 ) > 0 SET @place = @PlaceStrong

-- get the 2 legs under this sponsor3
SET @Member1ID = 0 SET @Member2ID = 0
SELECT TOP 1 @Member1ID = MemberID FROM Member WHERE Sponsor3ID = @SponsorID AND pos = @LeftSide AND Status > 0  -- AND Status >= 1 AND Status <= 5
SELECT TOP 1 @Member2ID = MemberID FROM Member WHERE Sponsor3ID = @SponsorID AND pos = @RightSide AND Status > 0  -- AND Status >= 1 AND Status <= 5
--print 'place: ' + cast(@place as varchar(10))
-- If placement option = weak, check downline
IF @place = @PlaceWeak
BEGIN
--	If no placements, place in the left leg
	IF @Member1ID = 0 AND @Member2ID = 0 SET @place = @PlaceLeft
--	If only right placed, place left
	IF @Member1ID = 0 AND @Member2ID != 0 SET @place = @PlaceLeft
--	If only left placed, place right
	IF @Member1ID != 0 AND @Member2ID = 0 SET @place = @PlaceRight
--	If both sides placed, look for the side with the least new sales
	IF @Member1ID != 0 AND @Member2ID != 0 
	BEGIN
--		Get the total sales for each side	
		SELECT @Sale1 = QV4 FROM Member WHERE MemberID = @Member1ID
		SELECT @Sale2 = QV4 FROM Member WHERE MemberID = @Member2ID
--		If sales are equal, get the count for each side	
		IF @Sale1 = @Sale2
		BEGIN
			SELECT @Sale1 = BV4 FROM Member WHERE MemberID = @Member1ID
			SELECT @Sale2 = BV4 FROM Member WHERE MemberID = @Member2ID
		END			
		IF @Sale1 <= @Sale2 SET @place = @PlaceLeft ELSE SET @place = @PlaceRight 
	END
END
IF @place = @PlaceStrong
BEGIN
--	If no placements, place in the left leg
	IF @Member1ID = 0 AND @Member2ID = 0 SET @place = @PlaceLeft
--	If only right placed, place right
	IF @Member1ID = 0 AND @Member2ID != 0 SET @place = @PlaceRight
--	If only left placed, place left
	IF @Member1ID != 0 AND @Member2ID = 0 SET @place = @PlaceLeft
--	If both sides placed, look for the side with the most new sales
	IF @Member1ID != 0 AND @Member2ID != 0 
	BEGIN
--		Get the total sales for each side	
		SELECT @Sale1 = QV4 FROM Member WHERE MemberID = @Member1ID
		SELECT @Sale2 = QV4 FROM Member WHERE MemberID = @Member2ID
--		If sales are equal, get the count for each side	
		IF @Sale1 = @Sale2
		BEGIN
			SELECT @Sale1 = BV4 FROM Member WHERE MemberID = @Member1ID
			SELECT @Sale2 = BV4 FROM Member WHERE MemberID = @Member2ID
		END			
		IF @Sale1 <= @Sale2 SET @place = @PlaceRight ELSE SET @place = @PlaceLeft 
	END
END

-- Set leg to walk down
IF @place = @PlaceLeft
BEGIN
	SET @MemberID = @Member1ID
	SET @Pos = @LeftSide
END	
IF @place = @PlaceRight
BEGIN
	SET @MemberID = @Member2ID
	SET @Pos = @RightSide
END	

-- If MemberID = 0, no leg to walk, so return current SponsorID
-- Walk down leg looking for first available spot
--print CAST(datepart(ss,GETDATE()) AS VARCHAR(20))
WHILE @MemberID > 0
BEGIN 
--print 'member: ' + CAST(@MemberID AS VARCHAR(10))
	SET @Member1ID = 0
--	-- This is an optimization, runs much faster with Pos = constant 
	SELECT TOP 1 @Member1ID = MemberID FROM Member WHERE Sponsor3ID = @MemberID AND Pos = @Pos
--	If we found no one under this sponsor at this position, return the sponsor for the next placement
	IF @Member1ID = 0 SET @SponsorID = @MemberID
	SET @MemberID = @Member1ID
END
--print CAST(datepart(ss,GETDATE()) AS VARCHAR(20))
GO
