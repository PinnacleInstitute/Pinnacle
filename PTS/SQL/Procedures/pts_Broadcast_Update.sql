EXEC [dbo].pts_CheckProc 'pts_Broadcast_Update'
 GO

CREATE PROCEDURE [dbo].pts_Broadcast_Update ( 
   @BroadcastID int,
   @MemberID int,
   @FriendGroupID int,
   @BroadcastDate datetime,
   @Status int,
   @Stories int,
   @Friends int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE bc
SET bc.MemberID = @MemberID ,
   bc.FriendGroupID = @FriendGroupID ,
   bc.BroadcastDate = @BroadcastDate ,
   bc.Status = @Status ,
   bc.Stories = @Stories ,
   bc.Friends = @Friends
FROM Broadcast AS bc
WHERE bc.BroadcastID = @BroadcastID

GO