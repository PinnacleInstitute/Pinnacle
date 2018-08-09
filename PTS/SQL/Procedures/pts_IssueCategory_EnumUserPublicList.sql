EXEC [dbo].pts_CheckProc 'pts_IssueCategory_EnumUserPublicList'
GO

CREATE PROCEDURE [dbo].pts_IssueCategory_EnumUserPublicList
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ic.IssueCategoryID AS 'ID', 
         ic.IssueCategoryName AS 'Name'
FROM IssueCategory AS ic (NOLOCK)
WHERE (ic.CompanyID = @CompanyID)
 AND (ic.IsPrivate = 0)

ORDER BY   ic.Seq

GO