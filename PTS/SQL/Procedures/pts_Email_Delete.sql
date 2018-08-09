EXEC [dbo].pts_CheckProc 'pts_Email_Delete'
GO

CREATE PROCEDURE [dbo].pts_Email_Delete
   @EmailID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   88 ,
   @EmailID

DELETE ema
FROM Email AS ema
WHERE (ema.EmailID = @EmailID)


GO