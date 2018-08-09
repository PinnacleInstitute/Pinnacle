EXEC [dbo].pts_CheckProc 'pts_ForumModerator_GetForumModerator'
GO

CREATE PROCEDURE [dbo].pts_ForumModerator_GetForumModerator
   @ForumID int ,
   @BoardUserID int ,
   @UserID int ,
   @ForumModeratorID int OUTPUT
AS

DECLARE @mForumModeratorID int

SET NOCOUNT ON

SELECT      @mForumModeratorID = fmod.ForumModeratorID
FROM ForumModerator AS fmod (NOLOCK)
WHERE (fmod.ForumID = @ForumID)
 AND (fmod.BoardUserID = @BoardUserID)


SET @ForumModeratorID = ISNULL(@mForumModeratorID, 0)
GO