EXEC [dbo].pts_CheckProc 'pts_Product_ListProductPriceHigh'
GO

CREATE PROCEDURE [dbo].pts_Product_ListProductPriceHigh
   @ProductTypeID int ,
   @Levels nvarchar (5)
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
 AND (pd.IsPrivate = 0)
 AND ((pd.Levels = '')
 OR (pd.Levels LIKE '%'  + @Levels + '%'))

ORDER BY   pd.Price DESC

GO