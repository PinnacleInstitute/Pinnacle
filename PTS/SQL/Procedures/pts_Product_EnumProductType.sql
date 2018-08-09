EXEC [dbo].pts_CheckProc 'pts_Product_EnumProductType'
GO

CREATE PROCEDURE [dbo].pts_Product_EnumProductType
   @ProductTypeID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pd.ProductID AS 'ID', 
         pd.ProductName AS 'Name'
FROM Product AS pd (NOLOCK)
WHERE (pd.ProductTypeID = @ProductTypeID)
 AND (pd.IsActive = 1)

ORDER BY   pd.ProductName

GO