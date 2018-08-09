EXEC [dbo].pts_CheckProc 'pts_FriendGroup_Update'
 GO

CREATE PROCEDURE [dbo].pts_FriendGroup_Update ( 
   @FriendGroupID int,
   @MemberID int,
   @FriendGroupName nvarchar (40),
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE frg
SET frg.MemberID = @MemberID ,
   frg.FriendGroupName = @FriendGroupName ,
   frg.Seq = @Seq
FROM FriendGroup AS frg
WHERE frg.FriendGroupID = @FriendGroupID

GO