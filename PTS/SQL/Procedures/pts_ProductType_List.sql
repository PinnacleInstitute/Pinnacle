EXEC [dbo].pts_CheckProc 'pts_ProductType_List'
GO

CREATE PROCEDURE [dbo].pts_ProductType_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      pdt.ProductTypeID, 
         pdt.ProductTypeName, 
         pdt.Seq, 
         pdt.IsPrivate, 
         pdt.IsPublic, 
         pdt.Levels, 
         pdt.Description
FROM ProductType AS pdt (NOLOCK)
WHERE (pdt.CompanyID = @CompanyID)

ORDER BY   pdt.Seq

GO