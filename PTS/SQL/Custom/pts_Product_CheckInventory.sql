EXEC [dbo].pts_CheckProc 'pts_Product_CheckInventory'
GO

--DECLARE @Result int EXEC pts_Product_CheckInventory 54, 4858, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Product_CheckInventory
   @ProductID int ,
   @CompanyID int ,
   @Result int OUTPUT
AS
-- *********************************************
-- Return x = number In Stock
--       -x = Instock, but not enough for order
--  -999999 = no inventory found
-- *********************************************

SET NOCOUNT ON

DECLARE @SalesItemID int, @Inventory int, @Instock int, @ReOrder int, @Qty int, @InventoryID int
DECLARE @Attribute1 varchar(15), @Attribute2 varchar(15), @Attribute3 varchar(15), @InputValues varchar(500)
DECLARE @Value1 varchar(15), @Value2 varchar(15), @Value3 varchar(15)

SET @SalesItemID = @CompanyID
IF @SalesItemID = -1 SET @Qty = 1 ELSE SET @Qty = 0
SET @Result = -999999
SET @InputValues = ''

SELECT @Inventory = Inventory, @Instock = InStock, @Attribute1 = Attribute1, @Attribute2 = Attribute2, @Attribute3 = Attribute3 
FROM Product WHERE ProductID = @ProductID

IF @Inventory > 1
BEGIN
	IF @SalesItemID > 0 SELECT @Qty = Quantity, @InputValues = InputValues FROM SalesItem WHERE SalesItemID = @SalesItemID 
 
--	-- Check Basic Inventory
	IF @Inventory = 2
	BEGIN
--		-- If we have enough for the order, return back how many, otherwise negate what we have	
		IF ( @InStock - @Qty ) >= 0
			SET @Result = @InStock
		ELSE
		BEGIN	
			IF @InStock < 0 
				SET @Result = @InStock 
			ELSE 
				SET @Result = @InStock * -1 
		END	
	END
--	-- Check Advanced Inventory
	IF @Inventory = 3 AND @InputValues != ''
	BEGIN
--		-- Get selected Product Attributes from Sales Item
		IF @Attribute1 = '' SET @Value1 = '' ELSE SET @Value1 = dbo.wtfn_InputValue( @Attribute1, @InputValues )
		IF @Attribute2 = '' SET @Value2 = '' ELSE SET @Value2 = dbo.wtfn_InputValue( @Attribute2, @InputValues )		
		IF @Attribute3 = '' SET @Value3 = '' ELSE SET @Value3 = dbo.wtfn_InputValue( @Attribute3, @InputValues )		
		
		SET @InventoryID = 0
		SELECT @InventoryID = InventoryID, @Instock = InStock FROM Inventory
		WHERE ProductID = @ProductID 
		AND Attribute1 = @Value1 AND (@Value2 = '' OR Attribute2 = @Value2) AND (@Value3 = '' OR Attribute3 = @Value3)
		IF @InventoryID > 0
		BEGIN
--			-- If we have enough for the order, return back how many, otherwise negate what we have	
			IF ( @InStock - @Qty ) >= 0
				SET @Result = @InStock
			ELSE
			BEGIN
				IF @InStock < 0
					SET @Result = @InStock
				ELSE
					SET @Result = @InStock * -1
			END
		END
		ELSE
			SET @Result = 0
	END
END

GO
