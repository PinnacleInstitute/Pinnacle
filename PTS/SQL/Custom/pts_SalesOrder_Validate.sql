EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Validate'
 GO

-- 1  = Inactive Product
-- 2  = Too few items
-- 3  = Too many items
-- 4  = Not even multiple
-- 12  = Too few group items
-- 13  = Too many group items
-- 14  = Not even group multiple

--EXEC pts_SalesOrder_Validate 22196

CREATE PROCEDURE [dbo].pts_SalesOrder_Validate ( 
      @SalesOrderID int 
      )
AS

DECLARE @SalesItemID int, @Quantity int, @IsActive int, @OrderMin int, @OrderMax int, @OrderMul int, @OrderGrp varchar(10)
DECLARE @OrderValid int, @ItemValid int
SET @OrderValid = 0

-- Get all sales items for products needing validated for this Sales Order
DECLARE SalesItem_Cursor CURSOR LOCAL STATIC FOR 
SELECT si.SalesItemID, si.Quantity, pr.IsActive, pr.OrderMin, pr.OrderMax, pr.OrderMul, pr.OrderGrp
FROM SalesItem AS si
JOIN Product AS pr ON si.ProductID = pr.ProductID
WHERE si.SalesOrderID = @SalesOrderID
AND ( pr.IsActive = 0 OR pr.OrderMin > 0 OR pr.OrderMax > 0 OR pr.OrderMul > 0 )

OPEN SalesItem_Cursor
FETCH NEXT FROM SalesItem_Cursor INTO @SalesItemID, @Quantity, @IsActive, @OrderMin, @OrderMax, @OrderMul, @OrderGrp
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ItemValid = 0

--	-- If an order group is specified, get quantity of all sales items for this group of products in the order
	IF @OrderGrp <> ''
	BEGIN
		SELECT @Quantity = SUM(si.Quantity) 
		FROM SalesItem AS si
		JOIN Product AS pr ON si.ProductID = pr.ProductID
		WHERE si.SalesOrderID = @SalesOrderID
		AND pr.IsActive <> 0 AND pr.OrderGrp = @OrderGrp
	END

	IF @IsActive = 0
	BEGIN
		SET @ItemValid = 1
	END
	ELSE
	BEGIN
		IF @OrderMin > 0
		BEGIN
			IF @Quantity < @OrderMin 
				IF @OrderGrp = '' SET @ItemValid = 2 ELSE SET @ItemValid = 12
		END
		IF @OrderMax > 0
		BEGIN
			IF @Quantity > @OrderMax 
				IF @OrderGrp = '' SET @ItemValid = 3 ELSE SET @ItemValid = 13
		END
		IF @OrderMul > 0
		BEGIN
			IF (@Quantity % @OrderMul) > 0
				IF @OrderGrp = '' SET @ItemValid = 4 ELSE SET @ItemValid = 14
		END
	END

	IF @ItemValid > 0 SET @OrderValid = @ItemValid
--	-- Set Valid State for this sales item
	UPDATE SalesItem SET Valid = @ItemValid WHERE SalesItemID = @SalesItemID

	FETCH NEXT FROM SalesItem_Cursor INTO @SalesItemID, @Quantity, @IsActive, @OrderMin, @OrderMax, @OrderMul, @OrderGrp
END
CLOSE SalesItem_Cursor
DEALLOCATE SalesItem_Cursor

-- Set Valid State for this sales order
UPDATE SalesOrder SET Valid = @OrderValid WHERE SalesOrderID = @SalesOrderID

GO
