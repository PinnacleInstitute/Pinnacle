EXEC [dbo].pts_CheckProc 'pts_Downline_Rollup'
GO

CREATE PROCEDURE [dbo].pts_Downline_Rollup
   @Line int ,
   @ChildID int 
AS

SET NOCOUNT ON

DECLARE @NewParentID int

-- get the downline parent of the child to be deleted  
SELECT @NewParentID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @ChildID

-- link all the deleted childs children to the new parent
UPDATE Downline SET ParentID = @NewParentID WHERE Line = @Line AND ParentID = @ChildID

-- delete downline parent records for the deleted child
DELETE Downline WHERE Line = @Line AND ChildID = @ChildID

-- recalculate the position of all children of the new parent
EXEC pts_Downline_Reposition @Line, @NewParentID

GO