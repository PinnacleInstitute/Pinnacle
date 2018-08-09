EXEC [dbo].pts_CheckProc 'pts_Comment_Add'
 GO

CREATE PROCEDURE [dbo].pts_Comment_Add ( 
   @CommentID int OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @MemberID int,
   @ReplyID int,
   @CommentDate datetime,
   @Msg nvarchar (2000),
   @Status int,
   @Likes int,
   @Dislikes int,
   @Bads int,
   @Favorites int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Comment (
            OwnerType , 
            OwnerID , 
            MemberID , 
            ReplyID , 
            CommentDate , 
            Msg , 
            Status , 
            Likes , 
            Dislikes , 
            Bads , 
            Favorites
            )
VALUES (
            @OwnerType ,
            @OwnerID ,
            @MemberID ,
            @ReplyID ,
            @CommentDate ,
            @Msg ,
            @Status ,
            @Likes ,
            @Dislikes ,
            @Bads ,
            @Favorites            )

SET @mNewID = @@IDENTITY

SET @CommentID = @mNewID

GO