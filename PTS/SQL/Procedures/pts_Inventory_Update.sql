EXEC [dbo].pts_CheckProc 'pts_Inventory_Update'
 GO

CREATE PROCEDURE [dbo].pts_Inventory_Update ( 
   @InventoryID int,
   @MemberID int,
   @ProductID int,
   @Attribute1 nvarchar (15),
   @Attribute2 nvarchar (15),
   @Attribute3 nvarchar (15),
   @InStock int,
   @ReOrder int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE iv
SET iv.MemberID = @MemberID ,
   iv.ProductID = @ProductID ,
   iv.Attribute1 = @Attribute1 ,
   iv.Attribute2 = @Attribute2 ,
   iv.Attribute3 = @Attribute3 ,
   iv.InStock = @InStock ,
   iv.ReOrder = @ReOrder
FROM Inventory AS iv
WHERE iv.InventoryID = @InventoryID

GO