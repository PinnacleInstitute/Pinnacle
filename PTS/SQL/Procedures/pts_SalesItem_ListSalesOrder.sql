EXEC [dbo].pts_CheckProc 'pts_SalesItem_ListSalesOrder'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_ListSalesOrder
   @SalesOrderID int
AS

SET NOCOUNT ON

SELECT      si.SalesItemID, 
         pd.ProductID, 
         pd.ProductName AS 'ProductName', 
         pd.Image AS 'Image', 
         si.Quantity, 
         si.Price, 
         si.OptionPrice, 
         si.Tax, 
         si.Status, 
         pd.InputOptions AS 'InputOptions', 
         si.InputValues, 
         si.BillDate, 
         si.Locks, 
         si.Valid
FROM SalesItem AS si (NOLOCK)
LEFT OUTER JOIN Product AS pd (NOLOCK) ON (si.ProductID = pd.ProductID)
WHERE (si.SalesOrderID = @SalesOrderID)
 AND (si.Status <= 3)

ORDER BY   si.SalesItemID

GO