EXEC [dbo].pts_CheckProc 'pts_EmailList_List'
GO

CREATE PROCEDURE [dbo].pts_EmailList_List
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      eml.EmailListID, 
         eml.EmailListName
FROM EmailList AS eml (NOLOCK)
WHERE (eml.CompanyID = @CompanyID)

ORDER BY   eml.EmailListName

GO