EXEC [dbo].pts_CheckProc 'pts_Comment_Stats'
GO

CREATE PROCEDURE [dbo].pts_Comment_Stats
   @CommentID int ,
   @Stat int ,
   @Num int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

IF @Num = 0 SET @Num = 1

IF @Stat = 1 
BEGIN
	UPDATE Comment SET Likes = Likes + @Num WHERE CommentID = @CommentID
	SELECT @Result = Likes FROM Comment WHERE CommentID = @CommentID
END
IF @Stat = 2 
BEGIN
	UPDATE Comment SET Dislikes = Dislikes + @Num WHERE CommentID = @CommentID
	SELECT @Result = Dislikes FROM Comment WHERE CommentID = @CommentID
END
IF @Stat = 3 
BEGIN
	UPDATE Comment SET Bads = Bads + @Num WHERE CommentID = @CommentID
	SELECT @Result = Bads FROM Comment WHERE CommentID = @CommentID
END
IF @Stat = 4 
BEGIN
	UPDATE Comment SET Favorites = Favorites + @Num WHERE CommentID = @CommentID
	SELECT @Result = Favorites FROM Comment WHERE CommentID = @CommentID
END

GO