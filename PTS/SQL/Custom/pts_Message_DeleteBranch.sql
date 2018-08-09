EXEC [dbo].pts_CheckProc 'pts_Message_DeleteBranch'
GO

CREATE PROCEDURE [dbo].pts_Message_DeleteBranch
   @MessageID int , 
   @UserID int

AS

SET         NOCOUNT ON

DECLARE @ThreadID int

SET @ThreadID = (
	SELECT ThreadID
	FROM Message
	WHERE MessageID = @MessageID
	)

IF @ThreadID = @MessageID
BEGIN
--Delete the entire thread
	DELETE FROM Message
	WHERE ThreadID = @ThreadID
END
ELSE
BEGIN
--Delete the branch
	DELETE FROM Message
	WHERE MessageID IN (SELECT MessageID FROM dbo.wtfn_GetMessageBranch(@MessageID))

END

GO
