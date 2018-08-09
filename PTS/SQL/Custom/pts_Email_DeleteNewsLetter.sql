EXEC [dbo].pts_CheckProc 'pts_Email_DeleteNewsLetter'
GO

CREATE PROCEDURE [dbo].pts_Email_DeleteNewsLetter
   @NewsLetterID int
AS

DELETE Email WHERE NewsLetterID = @NewsLetterID

GO