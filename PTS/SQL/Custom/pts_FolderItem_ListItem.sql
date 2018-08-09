EXEC [dbo].pts_CheckProc 'pts_FolderItem_ListItem'
GO
--exec pts_FolderItem_ListItem 33122, 22
CREATE PROCEDURE [dbo].pts_FolderItem_ListItem
   @ItemID int ,
   @Entity int
AS

SET NOCOUNT ON

SELECT   foi.FolderItemID, 
         fo.MemberID, 
         foi.FolderID, 
         fo.FolderName 'ItemName', 
         foi.ItemDate,
         foi.Status,
         fo.IsShare, 
         fo.CompanyID 
FROM FolderItem AS foi (NOLOCK)
JOIN Folder AS fo ON foi.FolderID = fo.FolderID
WHERE (foi.Entity = @Entity)
 AND (foi.ItemID = @ItemID)

ORDER BY   foi.ItemDate DESC

GO