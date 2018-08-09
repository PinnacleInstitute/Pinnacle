EXEC [dbo].pts_CheckProc 'pts_EmailList_EnumUserList'
GO

CREATE PROCEDURE [dbo].pts_EmailList_EnumUserList
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      eml.EmailListID AS 'ID', 
         eml.EmailListName AS 'Name'
FROM EmailList AS eml (NOLOCK)
WHERE (eml.CompanyID = @CompanyID)

ORDER BY   eml.EmailListName

GO