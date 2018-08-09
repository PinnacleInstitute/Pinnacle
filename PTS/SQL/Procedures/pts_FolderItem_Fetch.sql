EXEC [dbo].pts_CheckProc 'pts_FolderItem_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_FolderItem_Fetch ( 
   @FolderItemID int,
   @FolderID int OUTPUT,
   @MemberID int OUTPUT,
   @FolderName nvarchar (60) OUTPUT,
   @MemberName nvarchar (60) OUTPUT,
   @Entity int OUTPUT,
   @ItemID int OUTPUT,
   @ItemDate datetime OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @FolderID = foi.FolderID ,
   @MemberID = foi.MemberID ,
   @FolderName = fo.FolderName ,
   @MemberName = me.CompanyName ,
   @Entity = foi.Entity ,
   @ItemID = foi.ItemID ,
   @ItemDate = foi.ItemDate ,
   @Status = foi.Status
FROM FolderItem AS foi (NOLOCK)
LEFT OUTER JOIN Folder AS fo (NOLOCK) ON (foi.FolderID = fo.FolderID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (foi.MemberID = me.MemberID)
WHERE foi.FolderItemID = @FolderItemID

GO