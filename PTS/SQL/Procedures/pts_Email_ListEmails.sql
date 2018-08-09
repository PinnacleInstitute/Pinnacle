EXEC [dbo].pts_CheckProc 'pts_Email_ListEmails'
GO

CREATE PROCEDURE [dbo].pts_Email_ListEmails
   @UserID int
AS

SET NOCOUNT ON

SELECT      ema.EmailID
FROM Email AS ema (NOLOCK)
WHERE (ema.Status = 2)
 AND (ema.SendDate <= dbo.wtfn_DateOnly(GETDATE()))
 AND (ema.EmailType = 1)


GO