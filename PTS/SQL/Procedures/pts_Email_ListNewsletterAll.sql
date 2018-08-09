EXEC [dbo].pts_CheckProc 'pts_Email_ListNewsletterAll'
GO

CREATE PROCEDURE [dbo].pts_Email_ListNewsletterAll
   @NewsLetterID int
AS

SET NOCOUNT ON

SELECT      ema.EmailID, 
         ema.EmailName, 
         ema.SendDate, 
         ema.Status, 
         ema.Emails, 
         ema.Mailings, 
         ema.FileName
FROM Email AS ema (NOLOCK)
WHERE (ema.NewsLetterID = @NewsLetterID)

ORDER BY   ema.SendDate DESC

GO