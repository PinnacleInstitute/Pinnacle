EXEC [dbo].pts_CheckProc 'pts_FolderItem_FetchItemID'
GO

CREATE PROCEDURE [dbo].pts_FolderItem_FetchItemID
   @FolderID int ,
   @MemberID int ,
   @Entity int ,
   @ItemID int ,
   @FolderItemID int OUTPUT
AS

DECLARE @mFolderItemID int

SET NOCOUNT ON

SELECT      @mFolderItemID = foi.FolderItemID
FROM FolderItem AS foi (NOLOCK)
WHERE (foi.FolderID = @FolderID)
 AND (foi.MemberID = @MemberID)
 AND (foi.Entity = @Entity)
 AND (foi.ItemID = @ItemID)


SET @FolderItemID = ISNULL(@mFolderItemID, 0)
GO