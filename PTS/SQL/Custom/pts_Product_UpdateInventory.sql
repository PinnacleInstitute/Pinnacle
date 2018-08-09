EXEC [dbo].pts_CheckProc 'pts_Product_UpdateInventory'
GO

--DECLARE @Result int EXEC pts_Product_UpdateInventory 1, 9, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Product_UpdateInventory
   @ProductID int ,
   @CompanyID int ,
   @Result int OUTPUT
AS
-- *********************************************
-- Return -999999 = successful
--        x = current InStock, need to ReOrder
-- *********************************************

SET NOCOUNT ON

DECLARE @SalesItemID int, @Inventory int, @Instock int, @ReOrder int, @Qty int, @InventoryID int
DECLARE @Attribute1 varchar(15), @Attribute2 varchar(15), @Attribute3 varchar(15), @InputValues varchar(500)
DECLARE @Value1 varchar(15), @Value2 varchar(15), @Value3 varchar(15)

SET @SalesItemID = @CompanyID
SET @Qty = 1
SET @Result = -999999
SET @InputValues = ''

SELECT @Inventory = Inventory, @Instock = InStock, @ReOrder = Reorder, @Attribute1 = Attribute1, @Attribute2 = Attribute2, @Attribute3 = Attribute3 
FROM Product WHERE ProductID = @ProductID

IF @Inventory > 1
BEGIN
	IF @SalesItemID > 0 SELECT @Qty = Quantity, @InputValues = InputValues FROM SalesItem WHERE SalesItemID = @SalesItemID 

--	-- Check Basic Inventory
	IF @Inventory = 2
	BEGIN
		SET @InStock = @InStock - @Qty
--		-- If we need to reorder, return back updated stock
		IF @InStock <= @ReOrder SET @Result = @InStock
		UPDATE Product SET InStock = @InStock WHERE ProductID = @ProductID
	END
--	-- Check Advanced Inventory
	IF @Inventory = 3 AND @InputValues != ''
	BEGIN
--		-- Get selected Product Attributes from Sales Item
		IF @Attribute1 = '' SET @Value1 = '' ELSE SET @Value1 = dbo.wtfn_InputValue( @Attribute1, @InputValues )		
		IF @Attribute2 = '' SET @Value2 = '' ELSE SET @Value2 = dbo.wtfn_InputValue( @Attribute2, @InputValues )		
		IF @Attribute3 = '' SET @Value3 = '' ELSE SET @Value3 = dbo.wtfn_InputValue( @Attribute3, @InputValues )		
		
		SET @InventoryID = 0
		SELECT @InventoryID = InventoryID, @Instock = InStock, @ReOrder = Reorder FROM Inventory
		WHERE ProductID = @ProductID 
		AND Attribute1 = @Value1 AND (@Value2 = '' OR Attribute2 = @Value2) AND (@Value3 = '' OR Attribute3 = @Value3)

		IF @InventoryID > 0
		BEGIN
			SET @InStock = @InStock - @Qty
--			-- If we need to reorder, return back updated stock
			IF @InStock <= @ReOrder SET @Result = @InStock
			UPDATE Inventory SET InStock = @InStock WHERE InventoryID = @InventoryID
		END
	END
END

GO