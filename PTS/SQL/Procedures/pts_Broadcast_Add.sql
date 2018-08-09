EXEC [dbo].pts_CheckProc 'pts_Broadcast_Add'
 GO

CREATE PROCEDURE [dbo].pts_Broadcast_Add ( 
   @BroadcastID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Broadcast (
            MemberID , 
            FriendGroupID , 
            BroadcastDate , 
            Status , 
            Stories , 
            Friends
            )
VALUES (
            @MemberID ,
            @FriendGroupID ,
            @BroadcastDate ,
            @Status ,
            @Stories ,
            @Friends            )

SET @mNewID = @@IDENTITY

SET @BroadcastID = @mNewID

GO