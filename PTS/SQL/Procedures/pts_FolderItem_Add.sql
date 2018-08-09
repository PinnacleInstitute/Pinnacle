EXEC [dbo].pts_CheckProc 'pts_FolderItem_Add'
 GO

CREATE PROCEDURE [dbo].pts_FolderItem_Add ( 
   @FolderItemID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO FolderItem (
            FolderID , 
            MemberID , 
            Entity , 
            ItemID , 
            ItemDate , 
            Status
            )
VALUES (
            @FolderID ,
            @MemberID ,
            @Entity ,
            @ItemID ,
            @ItemDate ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @FolderItemID = @mNewID

GO