EXEC [dbo].pts_CheckProc 'pts_NewsLetter_ListActive'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_ListActive
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      nl.NewsLetterID, 
         nl.NewsLetterName, 
         co.CompanyName AS 'CompanyName', 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         nl.Description, 
         nl.IsFeatured, 
         nl.MemberCnt, 
         nl.ProspectCnt
FROM NewsLetter AS nl (NOLOCK)
LEFT OUTER JOIN Company AS co (NOLOCK) ON (nl.CompanyID = co.CompanyID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (nl.MemberID = me.MemberID)
WHERE (nl.CompanyID = @CompanyID)
 AND (nl.Status = 2)

ORDER BY   nl.NewsLetterName

GO