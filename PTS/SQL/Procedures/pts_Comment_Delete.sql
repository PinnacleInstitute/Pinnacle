EXEC [dbo].pts_CheckProc 'pts_Comment_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Comment_Delete ( 
   @CommentID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cmt
FROM Comment AS cmt
WHERE cmt.CommentID = @CommentID

GO