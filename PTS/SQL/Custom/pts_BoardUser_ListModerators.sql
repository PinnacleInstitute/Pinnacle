EXEC [dbo].pts_CheckProc 'pts_BoardUser_ListModerators'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_ListModerators
   @ForumID int ,
   @UserID int
AS

SET         NOCOUNT ON

SELECT      mbu.BoardUserID, 
         mbu.BoardUserName, 
         mbu.BoardUserGroup
FROM      ForumModerator AS fmod (NOLOCK)
         LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbu.BoardUserID = fmod.BoardUserID)
WHERE      (fmod.ForumID = @ForumID)

ORDER BY   mbu.BoardUserName

GO