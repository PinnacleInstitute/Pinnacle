EXEC [dbo].pts_CheckProc 'pts_BarterCategory_ListAll'
GO

CREATE PROCEDURE [dbo].pts_BarterCategory_ListAll
   @UserID int
AS

SET NOCOUNT ON

SELECT      bca.BarterCategoryID, 
         bca.ParentID, 
         bca.BarterCategoryName, 
         bca.Children
FROM BarterCategory AS bca (NOLOCK)
WHERE (bca.Status = 1)

ORDER BY   bca.ParentID , bca.Seq , bca.BarterCategoryName

GO