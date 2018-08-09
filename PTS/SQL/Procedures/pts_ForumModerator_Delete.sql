EXEC [dbo].pts_CheckProc 'pts_ForumModerator_Delete'
 GO

CREATE PROCEDURE [dbo].pts_ForumModerator_Delete ( 
   @ForumModeratorID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE fmod
FROM ForumModerator AS fmod
WHERE fmod.ForumModeratorID = @ForumModeratorID

GO