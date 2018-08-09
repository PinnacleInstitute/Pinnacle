EXEC [dbo].pts_CheckProc 'pts_FolderItem_ListFolder'
GO

CREATE PROCEDURE [dbo].pts_FolderItem_ListFolder
   @FolderID int ,
   @MemberID int
AS

SET NOCOUNT ON

SELECT   foi.FolderItemID, 
         foi.Entity, 
         foi.ItemID, 
         pr.ProspectName 'ItemName', 
         foi.ItemDate,
         foi.Status
FROM FolderItem AS foi (NOLOCK)
JOIN Folder AS fo ON foi.FolderID = fo.FolderID
JOIN Prospect AS pr ON foi.Entity = fo.Entity AND foi.ItemID = pr.ProspectID
WHERE (foi.FolderID = @FolderID)
 AND (foi.MemberID = @MemberID)

ORDER BY   foi.ItemDate DESC

GO