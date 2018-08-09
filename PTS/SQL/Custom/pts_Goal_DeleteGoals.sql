EXEC [dbo].pts_CheckProc 'pts_Goal_DeleteGoals'
GO
CREATE PROCEDURE [dbo].pts_Goal_DeleteGoals
   @ParentID int
AS

SET NOCOUNT ON

DECLARE @ID int

DECLARE Goal_cursor CURSOR LOCAL STATIC FOR 
SELECT GoalID FROM Goal WHERE ParentID = @ParentID

OPEN Goal_cursor
FETCH NEXT FROM Goal_cursor INTO @ID
WHILE @@FETCH_STATUS = 0
BEGIN
-- 	Delete all Sub-Goals for this Goal
	EXEC pts_Goal_DeleteGoals @ID

--	Delete Shortcuts
	EXEC pts_Shortcut_DeleteItem 70, @ID

--	Delete Goal
	DELETE Goal Where GoalID = @ID

--PRINT 'Goal: ' + CAST(@ID AS varchar(10))

	FETCH NEXT FROM Goal_cursor INTO @ID
END
CLOSE Goal_cursor
DEALLOCATE Goal_cursor

GO
