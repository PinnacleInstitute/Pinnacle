EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom_13'
GO

--UPDATE SalesOrder SET shipping = 0, total =  WHERE SalesOrderID = 1302

--EXEC pts_SalesOrder_Custom_13 0, 13834
--select * from SalesOrder where SalesOrderID = 13834
--select * from SalesItem where SalesOrderID = 13834
--select * from Product where ProductID = 75

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom_13
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Ship int, @Amt money, @TaxAmt money, @Shipping money, @Tax money, @Total money, @MemberID int, @Level int, @State varchar(30)
DECLARE @PromotionID int, @Discount money, @tmpAmount money, @PaymentID int, @Notes nvarchar(1000), @DiscountText nvarchar(100)
DECLARE @MemberStatus int, @Title int, @cnt int, @pak int, @CountryID int, @tmpShip int, @Code varchar(10)
DECLARE @Ship1 money, @Ship1a money, @Ship2 money, @Ship2a money, @Ship3 money, @Ship3a money, @Ship4 money, @Ship4a money  

SET @CompanyID = 13

-- Compute Total Prices for Sales Order
IF @Status = 0
BEGIN
	SET @Shipping = 0
	SET @Tax = 0
	SET @CountryID = 0

	SELECT @Ship = so.Ship, @Amt = so.Amount, @Shipping = Shipping, @MemberID = ISNULL(me.MemberID,0), @Level = ISNULL(me.Level,0), 
		@PromotionID = PromotionID, @Discount = so.Discount, @Notes = so.Notes
	FROM SalesOrder AS so
	LEFT OUTER JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE SalesOrderID = @SalesOrderID

--	Check for valid Shipping option based on Member's address
	If @Ship > 0
	BEGIN
		SELECT @CountryID = CountryID FROM ADdress WHERE OwnerType = 4 AND OwnerID = @MemberID AND AddressType = 2 AND IsActive != 0
		IF @CountryID > 0
		BEGIN
			SET @tmpShip = @Ship
			IF @Ship = 1 AND @CountryID != 224 SET @tmpShip = 3
			IF @Ship = 3 AND @CountryID = 224 SET @tmpShip = 1
			IF @Ship != @tmpShip
			BEGIN
				SET @Ship = @tmpShip
				UPDATE SalesOrder SET Ship = @Ship WHERE SalesOrderID = @SalesOrderID
			END
		END
	END

--	If order has Green Fuel Tabs (QV = #items per product pak)
	SELECT @cnt = SUM(pr.QV * si.Quantity), @Code = MIN(pr.Code)
	FROM SalesItem AS si
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	WHERE si.SalesOrderID = @SalesOrderID AND pr.ProductTypeID = 12

--	Get Shipping Charges for first GFT product
	SELECT TOP 1 @Ship1 = pr.Ship1, @Ship1a = pr.Ship1a, @Ship2 = pr.Ship2, @Ship2a = pr.Ship2a, 
	       @Ship3 = pr.Ship3, @Ship3a = pr.Ship3a, @Ship4 = pr.Ship4, @Ship4a = pr.Ship4a 
	FROM SalesItem AS si
	JOIN Product AS pr ON si.ProductID = pr.ProductID
	WHERE si.SalesOrderID = @SalesOrderID AND pr.ProductTypeID = 12
	ORDER BY si.SalesItemID

	If @Ship1 = 0 SET @Ship1 = 6.95
	If @Ship1a = 0 SET @Ship1a = 3.00
	If @Ship3 = 0 SET @Ship3 = 15.95
	If @Ship3a = 0 SET @Ship3a = 6.00

--	First 4 units shipped for Ship1/Ship3, each additional 4 shipped for Ship1a/Ship3a
	IF @cnt > 0
	BEGIN	
		SET @pak = (@cnt / 4) 
		IF (@cnt % 4) > 0 SET @pak = @pak + 1
		IF @Ship = 1 SET @Shipping = @Shipping + @Ship1 + (@Ship1a * (@pak-1))
		IF @Ship = 3 SET @Shipping = @Shipping + @Ship3 + (@Ship3a * (@pak-1))
	END

	SET @Total = ( @Amt + @Shipping + @Tax )

	UPDATE SalesOrder SET Shipping = @Shipping, Tax = @Tax, Discount = @Discount, Total = @Total, Notes = @Notes WHERE SalesOrderID = @SalesOrderID  
END

-- Finalize Purchase of Sales Order
IF @Status = 1
BEGIN
	print 'NA'
END

GO