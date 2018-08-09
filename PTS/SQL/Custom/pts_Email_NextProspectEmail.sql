EXEC [dbo].pts_CheckProc 'pts_Email_NextProspectEmail'
 GO

CREATE PROCEDURE [dbo].pts_Email_NextProspectEmail (
	@EmailID int OUTPUT
	)
AS

SET NOCOUNT ON

DECLARE @Now datetime

SET @Now = GETDATE()
SET @EmailID = 0

SELECT TOP 1 @EmailID = pr.EmailID 
FROM Prospect as pr
LEFT OUTER JOIN Email AS em (NOLOCK) ON (pr.EmailID = em.EmailID)
WHERE pr.EmailDate <= @Now AND pr.EmailDate > 0 AND pr.EmailID > 0
AND (em.NewsletterID = 0 OR ( em.NewsletterID > 0 AND pr.NewsLetterStatus = 2 ))

GO

