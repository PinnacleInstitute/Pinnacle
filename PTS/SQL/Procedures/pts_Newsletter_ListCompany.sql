EXEC [dbo].pts_CheckProc 'pts_NewsLetter_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_ListCompany
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      nl.NewsLetterID, 
         nl.NewsLetterName, 
         nl.Description, 
         nl.Status, 
         nl.IsFeatured, 
         nl.MemberCnt, 
         nl.ProspectCnt
FROM NewsLetter AS nl (NOLOCK)
WHERE (nl.CompanyID = @CompanyID)

ORDER BY   nl.NewsLetterName

GO