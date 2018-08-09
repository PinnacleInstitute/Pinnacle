EXEC [dbo].pts_CheckProc 'pts_Member_PlaceSponsor2'
GO
-- ********************************************************************************
-- * This function finds the next available spot to place a new member            *
-- * It first checks the current sponsor2 for availability                         *
-- * If no availability, it then asks each child to find its next available spot. *
-- * Each child calls this function recursively                                   *
-- ********************************************************************************
DECLARE @Sponsor2ID int, @Level int, @Position int
SET @Sponsor2ID = 39032
SET @Level = 0
SET @Position = 0
EXEC pts_Member_PlaceSponsor2 -2, @Sponsor2ID OUTPUT, @Level OUTPUT, @Position OUTPUT
PRINT CAST(@Level AS VARCHAR(10)) + ' : ' + CAST(@Position AS VARCHAR(10)) + ' : ' + CAST(@Sponsor2ID AS VARCHAR(10))

CREATE PROCEDURE [dbo].pts_Member_PlaceSponsor2
   @Width int,
   @Sponsor2ID int OUTPUT,
   @Level int OUTPUT,
   @Position int OUTPUT
AS

SET NOCOUNT ON
DECLARE @cnt int, @MemberID int, @tmpSponsor2ID int, @tmpLevel int, @bestLevel int, @tmpPosition int, @bestPosition int

--PRINT 'TOP: ' + CAST(@Level AS VARCHAR(10)) + ' : ' + CAST(@Position AS VARCHAR(10)) + ' : ' + CAST(@Sponsor2ID AS VARCHAR(10))

-- Get the number of children for the current Sponsor2
SELECT @cnt = COUNT(*) FROM Member WHERE Sponsor2ID = @Sponsor2ID AND Status >= 1 AND Status <= 5 

-- If the current Sponsor2 has an open spot, return back the current Sponsor2ID and Level
-- Otherwise check his children by recursing this function
-- SQL Server has a recursion limit of 32 nested calls.
IF @cnt < @Width
BEGIN
	SET @Position = @cnt + 1
--PRINT 'OPEN: ' + CAST(@Level AS VARCHAR(10)) + ' : ' + CAST(@Position AS VARCHAR(10)) + ' : ' + CAST(@Sponsor2ID AS VARCHAR(10))
END
IF @cnt >= @Width AND @Level < 28
BEGIN
	SET @bestLevel = 99
	SET @bestPosition = 99
	SET @tmpPosition = 0

	DECLARE Member_cursor CURSOR LOCAL FOR 
	SELECT MemberID FROM Member
	WHERE Sponsor2ID = @Sponsor2ID AND Status >= 1 AND Status <= 5 
	ORDER BY EnrollDate

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @tmpLevel = @Level + 1
		SET @tmpSponsor2ID = @MemberID
		
--		-- Ask each child to find its next available spot
		EXEC pts_Member_PlaceSponsor2 @Width, @tmpSponsor2ID OUTPUT, @tmpLevel OUTPUT, @tmpPosition OUTPUT

--PRINT CAST(@tmpLevel AS VARCHAR(10)) + ' : ' + CAST(@x AS VARCHAR(10)) + ' : ' + CAST(@MemberID AS VARCHAR(10))

--		-- If the returned level is lower that the best level found so far
--		-- OR it is the same AND the returned position is lower than the best position found so far
		IF ( @tmpLevel < @bestLevel ) OR ( @tmpLevel = @bestLevel AND @tmpPosition < @bestPosition )
		BEGIN
			SET @bestLevel = @tmpLevel
			SET @bestPosition = @tmpPosition
			SET @Sponsor2ID = @tmpSponsor2ID
--PRINT 'BEST: ' + CAST(@tmpLevel AS VARCHAR(10)) + ' : ' + CAST(@tmpPosition AS VARCHAR(10)) + ' : ' + CAST(@MemberID AS VARCHAR(10))
		END

		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	SET @Level = @bestLevel
	SET @Position = @bestPosition

	CLOSE Member_cursor
	DEALLOCATE Member_cursor
--PRINT 'BOTTOM: ' + CAST(@Level AS VARCHAR(10)) + ' : ' + CAST(@Position AS VARCHAR(10)) + ' : ' + CAST(@Sponsor2ID AS VARCHAR(10))
END 

GO