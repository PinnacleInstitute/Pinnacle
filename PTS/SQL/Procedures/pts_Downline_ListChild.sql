EXEC [dbo].pts_CheckProc 'pts_Downline_ListChild'
GO

CREATE PROCEDURE [dbo].pts_Downline_ListChild
   @ChildID int
AS

SET NOCOUNT ON

SELECT      dl.DownlineID, 
         dl.Line, 
         dl.ParentID, 
         dl.ChildName
FROM Downline AS dl (NOLOCK)
WHERE (dl.ChildID = @ChildID)

ORDER BY   dl.Line

GO