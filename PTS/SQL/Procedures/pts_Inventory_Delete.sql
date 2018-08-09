EXEC [dbo].pts_CheckProc 'pts_Inventory_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Inventory_Delete ( 
   @InventoryID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE iv
FROM Inventory AS iv
WHERE iv.InventoryID = @InventoryID

GO