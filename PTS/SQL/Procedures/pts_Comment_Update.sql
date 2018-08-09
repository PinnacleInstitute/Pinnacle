EXEC [dbo].pts_CheckProc 'pts_Comment_Update'
 GO

CREATE PROCEDURE [dbo].pts_Comment_Update ( 
   @CommentID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cmt
SET cmt.OwnerType = @OwnerType ,
   cmt.OwnerID = @OwnerID ,
   cmt.MemberID = @MemberID ,
   cmt.ReplyID = @ReplyID ,
   cmt.CommentDate = @CommentDate ,
   cmt.Msg = @Msg ,
   cmt.Status = @Status ,
   cmt.Likes = @Likes ,
   cmt.Dislikes = @Dislikes ,
   cmt.Bads = @Bads ,
   cmt.Favorites = @Favorites
FROM Comment AS cmt
WHERE cmt.CommentID = @CommentID

GO