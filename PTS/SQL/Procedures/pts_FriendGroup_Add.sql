EXEC [dbo].pts_CheckProc 'pts_FriendGroup_Add'
 GO

CREATE PROCEDURE [dbo].pts_FriendGroup_Add ( 
   @FriendGroupID int OUTPUT,
   @MemberID int,
   @FriendGroupName nvarchar (40),
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM FriendGroup (NOLOCK)
   SET @Seq = @Seq + 3
END

INSERT INTO FriendGroup (
            MemberID , 
            FriendGroupName , 
            Seq
            )
VALUES (
            @MemberID ,
            @FriendGroupName ,
            @Seq            )

SET @mNewID = @@IDENTITY

SET @FriendGroupID = @mNewID

GO