EXEC [dbo].pts_CheckProc 'pts_Session_Delete'
GO

CREATE PROCEDURE [dbo].pts_Session_Delete
   @SessionID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   13 ,
   @SessionID

DELETE se
FROM Session AS se
WHERE (se.SessionID = @SessionID)


GO