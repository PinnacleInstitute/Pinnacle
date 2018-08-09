EXEC [dbo].pts_CheckProc 'pts_NewsLetter_List'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      nl.NewsLetterID, 
         nl.NewsLetterName, 
         nl.Status, 
         nl.MemberCnt, 
         nl.ProspectCnt
FROM NewsLetter AS nl (NOLOCK)
WHERE (nl.CompanyID = @CompanyID)

ORDER BY   nl.NewsLetterName

GO