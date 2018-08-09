EXEC [dbo].pts_CheckProc 'pts_Message_GetLastPost'
GO

CREATE PROCEDURE [dbo].pts_Message_GetLastPost
   @ThreadID int ,
   @UserID int ,
   @MessageID int OUTPUT
AS

SET         NOCOUNT ON

SELECT      @MessageID = mbm.MessageID
FROM      Message AS mbm (NOLOCK)
WHERE      mbm.ThreadOrder IN (SELECT MAX(ThreadOrder)
				FROM Message
				WHERE (ThreadID = @ThreadID)
	) AND mbm.ThreadID = @ThreadID

GO
