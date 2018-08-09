EXEC [dbo].pts_CheckProc 'pts_NewsLetter_Delete'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_Delete
   @NewsLetterID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Email_DeleteNewsLetter
   @NewsLetterID

DELETE nl
FROM NewsLetter AS nl
WHERE (nl.NewsLetterID = @NewsLetterID)


GO