EXEC [dbo].pts_CheckProc 'pts_Email_ListSalesStep'
GO

CREATE PROCEDURE [dbo].pts_Email_ListSalesStep
   @NewsLetterID int
AS

SET NOCOUNT ON

SELECT      ema.EmailID, 
         ema.CompanyID, 
         ema.NewsLetterID, 
         ema.EmailName, 
         ema.FromEmail, 
         ema.Subject, 
         ema.FileName, 
         ema.Status, 
         ema.SendDate
FROM Email AS ema (NOLOCK)
WHERE (ema.NewsLetterID = @NewsLetterID)
 AND (ema.IsSalesStep <> 0)

ORDER BY   ema.SendDate

GO