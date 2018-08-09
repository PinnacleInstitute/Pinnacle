EXEC [dbo].pts_CheckProc 'pts_Prospect_ListEmail'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ListEmail
   @EmailID int
AS

SET NOCOUNT ON

DECLARE @Now datetime

SET @Now = GETDATE()

SELECT   pr.ProspectID, 
         pr.MemberID, 
         pr.Email, 
         pr.NameFirst, 
         pr.NameLast, 
         me.Signature AS 'Description', 
         me.Email AS 'Street', 
         me.NameFirst AS 'Phone1', 
         me.NameLast AS 'Phone2' 
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN Email AS em (NOLOCK) ON (pr.EmailID = em.EmailID)
WHERE (pr.EmailID = @EmailID)
AND pr.EmailDate <= @Now AND pr.EmailDate > 0
AND (em.NewsletterID = 0 OR ( em.NewsletterID > 0 AND pr.EmailStatus = 2 ))

GO