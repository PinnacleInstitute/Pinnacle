EXEC [dbo].pts_CheckProc 'pts_Inventory_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Inventory_Fetch ( 
   @InventoryID int,
   @MemberID int OUTPUT,
   @ProductID int OUTPUT,
   @ProductName nvarchar (40) OUTPUT,
   @ProductAttribute1 nvarchar (15) OUTPUT,
   @ProductAttribute2 nvarchar (15) OUTPUT,
   @ProductAttribute3 nvarchar (15) OUTPUT,
   @Attribute1 nvarchar (15) OUTPUT,
   @Attribute2 nvarchar (15) OUTPUT,
   @Attribute3 nvarchar (15) OUTPUT,
   @InStock int OUTPUT,
   @ReOrder int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = iv.MemberID ,
   @ProductID = iv.ProductID ,
   @ProductName = pr.ProductName ,
   @ProductAttribute1 = pr.Attribute1 ,
   @ProductAttribute2 = pr.Attribute2 ,
   @ProductAttribute3 = pr.Attribute3 ,
   @Attribute1 = iv.Attribute1 ,
   @Attribute2 = iv.Attribute2 ,
   @Attribute3 = iv.Attribute3 ,
   @InStock = iv.InStock ,
   @ReOrder = iv.ReOrder
FROM Inventory AS iv (NOLOCK)
LEFT OUTER JOIN Product AS pr (NOLOCK) ON (iv.ProductID = pr.ProductID)
WHERE iv.InventoryID = @InventoryID

GO