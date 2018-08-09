EXEC [dbo].pts_CheckProc 'pts_ForumModerator_Update'
 GO

CREATE PROCEDURE [dbo].pts_ForumModerator_Update ( 
   @ForumModeratorID int,
   @ForumID int,
   @BoardUserID int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE fmod
SET fmod.ForumID = @ForumID ,
   fmod.BoardUserID = @BoardUserID
FROM ForumModerator AS fmod
WHERE fmod.ForumModeratorID = @ForumModeratorID

GO