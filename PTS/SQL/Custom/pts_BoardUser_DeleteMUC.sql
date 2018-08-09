EXEC [dbo].pts_CheckProc 'pts_BoardUser_DeleteMUC'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_DeleteMUC
   @BoardUserID int

AS

SET         NOCOUNT ON

DECLARE @jid int

SET @jid = (
	SELECT userID 
	FROM jiveUser 
	WHERE BoardUserID = @BoardUserID
	)

DELETE FROM jiveUserID
WHERE objectID = @jid

DELETE FROM jiveUser 
WHERE userID = @jid

GO