EXEC [dbo].pts_CheckProc 'pts_Forum_ListForum'
GO

CREATE PROCEDURE [dbo].pts_Forum_ListForum
   @ParentID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      mbf.ForumID, 
         mbf.ForumName, 
         mbf.Description
FROM Forum AS mbf (NOLOCK)
WHERE (mbf.ParentID = @ParentID)

ORDER BY   mbf.Seq

GO