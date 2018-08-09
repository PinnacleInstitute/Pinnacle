EXEC [dbo].pts_CheckProc 'pts_BarterCategory_List'
GO

CREATE PROCEDURE [dbo].pts_BarterCategory_List
   @ParentID int
AS

SET NOCOUNT ON

SELECT      bca.BarterCategoryID, 
         bca.ParentID, 
         bca.BarterCategoryName, 
         bca.Status, 
         bca.Children, 
         bca.Seq, 
         bca.Options, 
         bca.CustomFields
FROM BarterCategory AS bca (NOLOCK)
WHERE (bca.ParentID = @ParentID)

ORDER BY   bca.ParentID , bca.Seq , bca.BarterCategoryName

GO