EXEC [dbo].pts_CheckProc 'pts_FolderItem_Delete'
 GO

CREATE PROCEDURE [dbo].pts_FolderItem_Delete ( 
   @FolderItemID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE foi
FROM FolderItem AS foi
WHERE foi.FolderItemID = @FolderItemID

GO