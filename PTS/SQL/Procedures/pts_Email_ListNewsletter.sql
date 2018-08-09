EXEC [dbo].pts_CheckProc 'pts_Email_ListNewsletter'
GO

CREATE PROCEDURE [dbo].pts_Email_ListNewsletter
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
 AND ((ema.Status = 2)
 OR (ema.Status = 3))

ORDER BY   ema.SendDate DESC

GO