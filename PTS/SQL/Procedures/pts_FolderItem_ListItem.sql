EXEC [dbo].pts_CheckProc 'pts_FolderItem_ListItem'
GO

CREATE PROCEDURE [dbo].pts_FolderItem_ListItem
   @ItemID int ,
   @Entity int
AS

SET NOCOUNT ON

SELECT      foi.FolderItemID, 
         foi.FolderID, 
         foi.ItemName, 
         foi.ItemDate
FROM FolderItem AS foi (NOLOCK)
WHERE (foi.Entity = @Entity)
 AND (foi.ItemID = @ItemID)

ORDER BY   foi.ItemDate DESC

GO