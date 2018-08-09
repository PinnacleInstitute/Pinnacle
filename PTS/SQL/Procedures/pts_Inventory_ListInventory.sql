EXEC [dbo].pts_CheckProc 'pts_Inventory_ListInventory'
GO

CREATE PROCEDURE [dbo].pts_Inventory_ListInventory
   @MemberID int ,
   @ProductID int
AS

SET NOCOUNT ON

SELECT      iv.InventoryID, 
         pr.ProductName AS 'ProductName', 
         iv.Attribute1, 
         iv.Attribute2, 
         iv.Attribute3, 
         iv.InStock, 
         iv.ReOrder
FROM Inventory AS iv (NOLOCK)
LEFT OUTER JOIN Product AS pr (NOLOCK) ON (iv.ProductID = pr.ProductID)
WHERE (iv.MemberID = @MemberID)
 AND (iv.ProductID = @ProductID)

ORDER BY   iv.Attribute1 , iv.Attribute2 , iv.Attribute3

GO