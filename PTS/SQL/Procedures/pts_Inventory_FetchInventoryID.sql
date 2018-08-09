EXEC [dbo].pts_CheckProc 'pts_Inventory_FetchInventoryID'
GO

CREATE PROCEDURE [dbo].pts_Inventory_FetchInventoryID
   @MemberID int ,
   @ProductID int ,
   @InventoryID int OUTPUT
AS

DECLARE @mInventoryID int

SET NOCOUNT ON

SELECT      @mInventoryID = in.InventoryID
FROM Inventory AS in (NOLOCK)
WHERE (in.MemberID = @MemberID)
(in.ProductID = @ProductID)


SET @InventoryID = ISNULL(@mInventoryID, 0)
GO