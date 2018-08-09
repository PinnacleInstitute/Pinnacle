EXEC [dbo].pts_CheckProc 'pts_Prospect_ListNewsLetter'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ListNewsLetter
   @NewsLetterID int
AS

SET NOCOUNT ON

SELECT   pr.ProspectID, 
         pr.MemberID, 
         pr.Email, 
         pr.NameFirst, 
         pr.NameLast, 
         me.Signature AS 'Description', 
         me.Email AS 'Street' 
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
WHERE pr.NewsLetterID = @NewsLetterID
AND pr.EmailStatus = 2

GO