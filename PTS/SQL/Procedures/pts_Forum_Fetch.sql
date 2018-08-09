EXEC [dbo].pts_CheckProc 'pts_Forum_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Forum_Fetch ( 
   @ForumID int,
   @ParentID int OUTPUT,
   @ParentName nvarchar (60) OUTPUT,
   @ForumName nvarchar (60) OUTPUT,
   @Seq int OUTPUT,
   @Description nvarchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ParentID = mbf.ParentID ,
   @ParentName = mbfp.ForumName ,
   @ForumName = mbf.ForumName ,
   @Seq = mbf.Seq ,
   @Description = mbf.Description
FROM Forum AS mbf (NOLOCK)
LEFT OUTER JOIN Forum AS mbfp (NOLOCK) ON (mbf.ParentID = mbfp.ForumID)
WHERE mbf.ForumID = @ForumID

GO