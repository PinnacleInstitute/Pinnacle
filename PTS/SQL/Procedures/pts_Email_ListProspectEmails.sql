EXEC [dbo].pts_CheckProc 'pts_Email_ListProspectEmails'
GO

CREATE PROCEDURE [dbo].pts_Email_ListProspectEmails
   @UserID int
AS

SET NOCOUNT ON

SELECT      em.EmailID
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Email AS em (NOLOCK) ON (pr.EmailID = em.EmailID)
WHERE (pr.EmailDate <= GETDATE())
 AND (pr.EmailDate > 0)
 AND (pr.EmailID > 0)
 AND (em.NewsLetterID = 0)
 OR ((em.NewsLetterID > 0)
 AND (pr.EmailStatus = 2))


GO