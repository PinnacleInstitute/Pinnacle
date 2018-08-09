EXEC [dbo].pts_CheckProc 'pts_Downline_Reposition'
GO

CREATE PROCEDURE [dbo].pts_Downline_Reposition
   @Line int , 
   @ParentID int  
AS

SET NOCOUNT ON

DECLARE @ID int, @Position int, @Pos int
SET @Pos = 1

DECLARE Downline_cursor CURSOR STATIC LOCAL FOR 
SELECT DownlineID, Position FROM Downline WHERE Line = @Line AND ParentID = @ParentID ORDER BY Position
OPEN Downline_cursor
FETCH NEXT FROM Downline_cursor INTO @ID, @Position
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Position <> @Pos 
		UPDATE Downline SET Position = @Pos WHERE DownlineID = @ID
	
	SET @Pos = @Pos + 1

	FETCH NEXT FROM Downline_cursor INTO @ID, @Position
END
CLOSE Downline_cursor
DEALLOCATE Downline_cursor

GO