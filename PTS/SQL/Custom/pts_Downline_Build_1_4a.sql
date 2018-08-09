EXEC [dbo].pts_CheckProc 'pts_Downline_Build_1_4a'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build_1_4a
   @ParentID int OUTPUT , 
   @Level int OUTPUT , 
   @Children int OUTPUT , 
   @Position int OUTPUT , 
   @Levels int OUTPUT
AS

-- Recursive Function to Walk Down Matrix Downline #4 looking for a parent with < 3 children
SET NOCOUNT ON
DECLARE @Line int
SET @Line = 4

--print 'Build 4a: ' + cast(@ParentID as varchar(10))

-- Get the number of Children for the current Parent
SELECT @Children = COUNT(*) FROM Downline WHERE Line = @Line AND ParentID = @ParentID
-- If the current parent has < 3 children, we found a candidate parent, no need to look any further

-- If the current parent has 3+ children and we've reached the max level, return level 1000 so it does not get processed
IF @Children >= 3 AND @Level >= @Levels
BEGIN
	SET @Level = 1000
END

-- If the current parent has 3+ children and we haven't reached the max level, we need to look at each of his children
IF @Children >= 3 AND @Level < @Levels
BEGIN
	DECLARE @ChildID int, @ChildPosition int, @tmpLevel int, @tmpChildren int, @tmpPosition int, @LowLeg int
--	Setup temp variables for the selected parent 
	SELECT @tmpLevel = @Level+1, @tmpChildren = 0, @tmpPosition = @Position
--  Initialize return variables for the best match tests
	SELECT @Level = 1000, @Children = 1000, @Position = 1000, @LowLeg = 1000 

--	Look at each child under the current parent
	DECLARE Downline_cursor CURSOR STATIC LOCAL FOR 
	SELECT ChildID, Position FROM Downline WHERE Line = @Line AND ParentID = @ParentID
	OPEN Downline_cursor
	FETCH NEXT FROM Downline_cursor INTO @ChildID, @ChildPosition
	WHILE @@FETCH_STATUS = 0
	BEGIN

		EXEC pts_Downline_Build_1_4a @ChildID OUTPUT, @tmpLevel OUTPUT, @tmpChildren OUTPUT, @tmpPosition OUTPUT, @Levels OUTPUT

--		If we found a candidate at a higher level, set the new highest level to look
		IF @tmpLevel < @Levels SET @Levels = @tmpLevel 

--		If the returned level < lowest level, save the returned values
		IF @tmpLevel < @Level SELECT @ParentID = @ChildID, @Level = @tmpLevel, @Children = @tmpChildren, @Position = @tmpPosition, @LowLeg = @ChildPosition

--		If the returned level = lowest level, compare the position
		IF @tmpLevel = @Level 
		BEGIN
--			If the returned children < lowest children, save the returned values
			If @tmpChildren < @Children SELECT @ParentID = @ChildID, @Level = @tmpLevel, @Children = @tmpChildren, @Position = @tmpPosition, @LowLeg = @ChildPosition

--			If the returned children = lowest children, compare the children
			IF @tmpChildren = @Children
			BEGIN
--				If the returned position < lowest position, save the returned values
				IF @tmpPosition < @Position SELECT @ParentID = @ChildID, @Level = @tmpLevel, @Children = @tmpChildren, @Position = @tmpPosition, @LowLeg = @ChildPosition

--				If the returned position = lowest position AND we have a lower position, save the returned values
				IF @tmpPosition = @Position AND @ChildPosition < @LowLeg SELECT @ParentID = @ChildID, @Level = @tmpLevel, @Children = @tmpChildren, @Position = @tmpPosition, @LowLeg = @ChildPosition
			END
		END
		FETCH NEXT FROM Downline_cursor INTO @ChildID, @ChildPosition
	END
	CLOSE Downline_cursor
	DEALLOCATE Downline_cursor

END

GO