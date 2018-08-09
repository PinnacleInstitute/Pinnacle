EXEC [dbo].pts_CheckProc 'pts_Downline_ListChild'
GO

CREATE PROCEDURE [dbo].pts_Downline_ListChild
   @ChildID int
AS

SET NOCOUNT ON

SELECT   dl.DownlineID, 
         dl.Line, 
         dl.ParentID,
         me.NameLast + ', ' + me.NameFirst 'ChildName'
FROM Downline AS dl (NOLOCK)
JOIN Member AS me ON dl.ParentID = me.MemberID
WHERE (dl.ChildID = @ChildID)

ORDER BY   dl.Line

GO