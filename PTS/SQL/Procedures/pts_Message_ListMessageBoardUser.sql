EXEC [dbo].pts_CheckProc 'pts_Message_ListMessageBoardUser'
GO

CREATE PROCEDURE [dbo].pts_Message_ListMessageBoardUser
   @BoardUserID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      mbm.MessageID, 
         mbm.ParentID, 
         mbm.ForumID, 
         mbm.MessageTitle, 
         mbm.CreateDate
FROM Message AS mbm (NOLOCK)
WHERE (mbm.BoardUserID = @BoardUserID)

ORDER BY   mbm.CreateDate

GO