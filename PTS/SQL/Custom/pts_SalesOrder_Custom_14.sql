EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom_14'
GO

--UPDATE SalesOrder SET shipping = 0, total =  WHERE SalesOrderID = 1302

--EXEC pts_SalesOrder_Custom_14 0, 13834
--select * from SalesOrder where SalesOrderID = 13834
--select * from SalesItem where SalesOrderID = 13834
--select * from Product where ProductID = 75

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom_14
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Ship int, @Amt money, @TaxAmt money, @Shipping money, @Tax money, @Total money, @MemberID int, @Level int, @State varchar(30)
DECLARE @PromotionID int, @Discount money, @tmpAmount money, @PaymentID int, @Notes nvarchar(1000), @DiscountText nvarchar(100)
DECLARE @MemberStatus int, @Title int, @cnt int, @pak int, @CountryID int, @tmpShip int, @Code varchar(10)

SET @CompanyID = 14

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
	WHERE si.SalesOrderID = @SalesOrderID AND pr.ProductTypeID = 3

--	Shipping is different for Diamond Pack (115)
	IF @Code = '115'
	BEGIN
		IF @CountryID = 224 SET @Shipping = 7 ELSE SET @Shipping = 14
	END
	ELSE
	BEGIN
		IF @cnt > 0
		BEGIN	
			SET @pak = (@cnt / 4) 
			IF (@cnt % 4) > 0 SET @pak = @pak + 1
			IF @Ship = 1 SET @Shipping = @Shipping + (7 * @pak)
			IF @Ship = 3 SET @Shipping = @Shipping + (11 * @pak)
		END
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