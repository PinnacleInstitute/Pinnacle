EXEC [dbo].pts_CheckProc 'pts_Message_GetForumPages'
GO

CREATE PROCEDURE [dbo].pts_Message_GetForumPages
   @ForumID int ,
   @UserID int ,
   @PageSize int OUTPUT
AS

SET NOCOUNT ON

SELECT      @PageSize = COUNT(MessageID)
FROM Message AS mbm (NOLOCK)
WHERE (mbm.ForumID = @ForumID)
 AND (mbm.ParentID = 0)


GO