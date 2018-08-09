EXEC [dbo].pts_CheckProc 'pts_ForumModerator_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ForumModerator_Fetch ( 
   @ForumModeratorID int,
   @ForumID int OUTPUT,
   @BoardUserID int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ForumID = fmod.ForumID ,
   @BoardUserID = fmod.BoardUserID
FROM ForumModerator AS fmod (NOLOCK)
LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (fmod.BoardUserID = mbu.BoardUserID)
LEFT OUTER JOIN Forum AS mbf (NOLOCK) ON (fmod.ForumID = mbf.ForumID)
WHERE fmod.ForumModeratorID = @ForumModeratorID

GO