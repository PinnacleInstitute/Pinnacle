EXEC [dbo].pts_CheckProc 'pts_MemberNews_ListMember'
GO

CREATE PROCEDURE [dbo].pts_MemberNews_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      mn.MemberNewsID, 
         mn.NewsLetterID, 
         nl.NewsLetterName AS 'NewsLetterName', 
         nl.Description AS 'Description', 
         co.CompanyName AS 'CompanyName', 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         mn.EnrollDate
FROM MemberNews AS mn (NOLOCK)
LEFT OUTER JOIN NewsLetter AS nl (NOLOCK) ON (mn.NewsLetterID = nl.NewsLetterID)
LEFT OUTER JOIN Company AS co (NOLOCK) ON (nl.CompanyID = co.CompanyID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mn.MemberID = me.MemberID)
WHERE (mn.MemberID = @MemberID)
 AND (nl.Status = 2)

ORDER BY   mn.EnrollDate , nl.NewsLetterName

GO