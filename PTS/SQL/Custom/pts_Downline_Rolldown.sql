EXEC [dbo].pts_CheckProc 'pts_Downline_Rolldown'
GO

CREATE PROCEDURE [dbo].pts_Downline_Rolldown
   @Line int ,
   @ParentID int ,
   @ChildID int 
AS

SET NOCOUNT ON

-- link all the parent's children to the new child
UPDATE Downline SET ParentID = @ChildID WHERE Line = @Line AND ParentID = @ParentID

-- Add the new child in the downline
INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( @Line, @ParentID, @ChildID, 0 )

-- recalculate the position of all children of the parent
EXEC pts_Downline_Reposition @Line, @ParentID

-- recalculate the position of all children of the child
EXEC pts_Downline_Reposition @Line, @ChildID

GO
