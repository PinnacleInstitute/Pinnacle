EXEC [dbo].pts_CheckProc 'pts_Forum_Update'
GO

CREATE PROCEDURE [dbo].pts_Forum_Update
   @ForumID int,
   @ParentID int,
   @ForumName nvarchar (60),
   @Seq int,
   @Description nvarchar (500),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE mbf
SET mbf.ParentID = @ParentID ,
   mbf.ForumName = @ForumName ,
   mbf.Seq = @Seq ,
   mbf.Description = @Description
FROM Forum AS mbf
WHERE (mbf.ForumID = @ForumID)


GO