EXEC [dbo].pts_CheckProc 'pts_IssueCategory_EnumUserPrivateList'
GO

CREATE PROCEDURE [dbo].pts_IssueCategory_EnumUserPrivateList
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ic.IssueCategoryID AS 'ID', 
         ic.IssueCategoryName AS 'Name'
FROM IssueCategory AS ic (NOLOCK)
WHERE (ic.CompanyID = @CompanyID)

ORDER BY   ic.Seq

GO