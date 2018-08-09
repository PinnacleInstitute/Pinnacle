EXEC [dbo].pts_CheckProc 'pts_Downline_GetParent'
GO

CREATE PROCEDURE [dbo].pts_Downline_GetParent
   @Line int ,
   @ChildID int ,
   @ParentID int OUTPUT
AS

SET NOCOUNT ON
SET @ParentID = 0

SELECT @ParentID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @ChildID

GO
