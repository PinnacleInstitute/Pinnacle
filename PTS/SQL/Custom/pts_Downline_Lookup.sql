EXEC [dbo].pts_CheckProc 'pts_Downline_Lookup'
GO
-- Walk up a downline looking for a specific Child, stopping at TopID or very top
CREATE PROCEDURE [dbo].pts_Downline_Lookup
   @Line int ,
   @SearchID int ,
   @StartID int ,
   @StopID int ,
   @FoundID int OUTPUT 
AS

SET NOCOUNT ON

DECLARE @NextChildID int, @Done int, @NewParentID int

SET @NextChildID = @StartID
SET @FoundID = 0
SET @Done = 0
WHILE @Done <> 0 
BEGIN
	SET @NewParentID = 0
	SELECT @NewParentID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @NextChildID

--	If we found the search child, return the downlineID
	If @NewParentID = @SearchID SET @FoundID = @SearchID

--	If we fount the search parent, the top parent, or the very top, we're done				
	If @NewParentID = @SearchID OR @NewParentID = @TopID OR @NewParentID = 0 
		SET @Done = 1	
	Else
		SET @NextChildID = @NewParentID
END

GO