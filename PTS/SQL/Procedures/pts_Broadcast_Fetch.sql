EXEC [dbo].pts_CheckProc 'pts_Broadcast_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Broadcast_Fetch ( 
   @BroadcastID int,
   @MemberID int OUTPUT,
   @FriendGroupID int OUTPUT,
   @FriendGroupName nvarchar (40) OUTPUT,
   @BroadcastDate datetime OUTPUT,
   @Status int OUTPUT,
   @Stories int OUTPUT,
   @Friends int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = bc.MemberID ,
   @FriendGroupID = bc.FriendGroupID ,
   @FriendGroupName = frg.FriendGroupName ,
   @BroadcastDate = bc.BroadcastDate ,
   @Status = bc.Status ,
   @Stories = bc.Stories ,
   @Friends = bc.Friends
FROM Broadcast AS bc (NOLOCK)
LEFT OUTER JOIN FriendGroup AS frg (NOLOCK) ON (bc.FriendGroupID = frg.FriendGroupID)
WHERE bc.BroadcastID = @BroadcastID

GO