EXEC [dbo].pts_CheckProc 'pts_FriendGroup_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_FriendGroup_Fetch ( 
   @FriendGroupID int,
   @MemberID int OUTPUT,
   @FriendGroupName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = frg.MemberID ,
   @FriendGroupName = frg.FriendGroupName ,
   @Seq = frg.Seq
FROM FriendGroup AS frg (NOLOCK)
WHERE frg.FriendGroupID = @FriendGroupID

GO