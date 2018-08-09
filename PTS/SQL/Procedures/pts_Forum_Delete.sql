EXEC [dbo].pts_CheckProc 'pts_Forum_Delete'
GO

CREATE PROCEDURE [dbo].pts_Forum_Delete
   @ForumID int ,
   @UserID int
AS

SET NOCOUNT ON

DELETE mbf
FROM Forum AS mbf
WHERE (mbf.ForumID = @ForumID)


GO