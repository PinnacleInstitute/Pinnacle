EXEC [dbo].pts_CheckProc 'pts_Forum_ListModerator'
GO

CREATE PROCEDURE [dbo].pts_Forum_ListModerator
   @BoardUserID int ,
   @UserID int
AS

SET         NOCOUNT ON

SELECT      mbf.ForumID, 
         mbf.ParentID, 
         mbf.ForumName
FROM      ForumModerator AS fmod (NOLOCK)
         LEFT OUTER JOIN Forum AS mbf (NOLOCK) ON (mbf.ForumID = fmod.ForumID)
WHERE      (fmod.BoardUserID = @BoardUserID)

ORDER BY   mbf.Seq

GO