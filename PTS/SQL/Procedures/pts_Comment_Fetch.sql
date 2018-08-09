EXEC [dbo].pts_CheckProc 'pts_Comment_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Comment_Fetch ( 
   @CommentID int,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @MemberID int OUTPUT,
   @ReplyID int OUTPUT,
   @CommentDate datetime OUTPUT,
   @Msg nvarchar (2000) OUTPUT,
   @Status int OUTPUT,
   @Likes int OUTPUT,
   @Dislikes int OUTPUT,
   @Bads int OUTPUT,
   @Favorites int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OwnerType = cmt.OwnerType ,
   @OwnerID = cmt.OwnerID ,
   @MemberID = cmt.MemberID ,
   @ReplyID = cmt.ReplyID ,
   @CommentDate = cmt.CommentDate ,
   @Msg = cmt.Msg ,
   @Status = cmt.Status ,
   @Likes = cmt.Likes ,
   @Dislikes = cmt.Dislikes ,
   @Bads = cmt.Bads ,
   @Favorites = cmt.Favorites
FROM Comment AS cmt (NOLOCK)
WHERE cmt.CommentID = @CommentID

GO