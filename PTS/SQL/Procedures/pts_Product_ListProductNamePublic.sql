EXEC [dbo].pts_CheckProc 'pts_Product_ListProductNamePublic'
GO

CREATE PROCEDURE [dbo].pts_Product_ListProductNamePublic
   @ProductTypeID int
AS

SET NOCOUNT ON

SELECT      pd.ProductID, 
         pd.ProductName, 
         pd.Price, 
         pd.OriginalPrice, 
         pd.Description, 
         pd.Image, 
         pd.BV, 
         pd.QV, 
         pd.Data
FROM Product AS pd (NOLOCK)
WHERE (pd.ProductTypeID = @ProductTypeID)
 AND (pd.IsActive <> 0)
 AND (pd.IsPublic <> 0)

ORDER BY   pd.ProductName

GO