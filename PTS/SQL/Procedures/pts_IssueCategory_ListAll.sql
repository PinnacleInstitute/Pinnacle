EXEC [dbo].pts_CheckProc 'pts_IssueCategory_ListAll'
GO

CREATE PROCEDURE [dbo].pts_IssueCategory_ListAll
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      ic.IssueCategoryID, 
         ic.IssueCategoryName, 
         ic.Seq, 
         ic.UserType, 
         ic.AssignedTo, 
         ic.Email
FROM IssueCategory AS ic (NOLOCK)
WHERE (ic.CompanyID = @CompanyID)

ORDER BY   ic.UserType , ic.Seq

GO