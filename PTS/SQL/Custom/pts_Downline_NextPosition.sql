EXEC [dbo].pts_CheckProc 'pts_Downline_NextPosition'
GO

CREATE PROCEDURE [dbo].pts_Downline_NextPosition
   @Line int ,
   @ParentID int ,
   @Result int OUTPUT
AS
-- Get the next position number under this parent in this line
SET NOCOUNT ON

DECLARE @Pos int, @Last int

-- Get the total number of children and the highest position
SELECT @Pos = COUNT(*), @Last = ISNULL(MAX(Position),0) FROM Downline WHERE Line = @Line AND ParentID = @ParentID

-- If they are the same, there are no open positions, Return the next position in the sequence
IF @Pos = @Last SET @Result = @Pos + 1

-- There is an open position somewhere, We need to loop through all the children looking for the open position
IF @Pos < @Last
BEGIN
	DECLARE Downline_cursor CURSOR LOCAL FOR 
	SELECT Position FROM Downline WHERE Line = @Line AND ParentID = @ParentID ORDER BY Position

	OPEN Downline_cursor
	FETCH NEXT FROM Downline_cursor INTO @Pos

--	The first child should be in position 1
	SET @Last = 1
	SET @Result = 0
	WHILE @@FETCH_STATUS = 0 AND @Result = 0
	BEGIN
--	     	If the current child's position is greater than the last known position, we have an open position 
		IF @Last < @Pos SET @Result = @Last

--		Increment the last known position
		SET @Last = @Last + 1

		FETCH NEXT FROM Downline_cursor INTO @Pos
	END

	CLOSE Downline_cursor
	DEALLOCATE Downline_cursor
END

GO