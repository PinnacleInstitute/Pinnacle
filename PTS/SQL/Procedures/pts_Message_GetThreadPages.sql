EXEC [dbo].pts_CheckProc 'pts_Message_GetThreadPages'
GO

CREATE PROCEDURE [dbo].pts_Message_GetThreadPages
   @ThreadID int ,
   @UserID int ,
   @PageSize int OUTPUT
AS

SET NOCOUNT ON

SELECT      @PageSize = COUNT(MessageID)
FROM Message AS mbm (NOLOCK)
WHERE (mbm.ThreadID = @ThreadID)


GO