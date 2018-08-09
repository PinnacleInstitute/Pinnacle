EXEC [dbo].pts_CheckProc 'pts_PageSection_Delete'
GO

CREATE PROCEDURE [dbo].pts_PageSection_Delete
   @PageSectionID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   91 ,
   @PageSectionID

DELETE ps
FROM PageSection AS ps
WHERE (ps.PageSectionID = @PageSectionID)


GO