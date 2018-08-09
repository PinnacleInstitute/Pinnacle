EXEC [dbo].pts_CheckProc 'pts_IssueCategory_EnumUserList'
GO

CREATE PROCEDURE [dbo].pts_IssueCategory_EnumUserList
   @CompanyID int ,
   @UserType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ic.IssueCategoryID AS 'ID', 
         ic.IssueCategoryName AS 'Name'
FROM IssueCategory AS ic (NOLOCK)
WHERE (ic.CompanyID = @CompanyID)
 AND (ic.UserType <= @UserType)

ORDER BY   ic.Seq

GO