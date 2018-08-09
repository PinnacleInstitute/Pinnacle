EXEC [dbo].pts_CheckProc 'pts_NewsLetter_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_NewsLetter_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      nl.NewsLetterID AS 'ID', 
         nl.NewsLetterName AS 'Name'
FROM NewsLetter AS nl (NOLOCK)
WHERE (nl.CompanyID = @CompanyID)
 AND (nl.Status = 2)

ORDER BY   nl.NewsLetterName

GO