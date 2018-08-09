EXEC [dbo].pts_CheckProc 'pts_Mail_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Mail_Delete ( 
   @MailID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ml
FROM Mail AS ml
WHERE ml.MailID = @MailID

GO