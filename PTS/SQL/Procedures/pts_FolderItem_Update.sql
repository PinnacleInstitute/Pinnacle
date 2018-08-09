EXEC [dbo].pts_CheckProc 'pts_FolderItem_Update'
 GO

CREATE PROCEDURE [dbo].pts_FolderItem_Update ( 
   @FolderItemID int,
   @FolderID int,
   @MemberID int,
   @Entity int,
   @ItemID int,
   @ItemDate datetime,
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE foi
SET foi.FolderID = @FolderID ,
   foi.MemberID = @MemberID ,
   foi.Entity = @Entity ,
   foi.ItemID = @ItemID ,
   foi.ItemDate = @ItemDate ,
   foi.Status = @Status
FROM FolderItem AS foi
WHERE foi.FolderItemID = @FolderItemID

GO