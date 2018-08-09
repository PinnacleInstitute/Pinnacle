EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom_11'
GO

--UPDATE SalesOrder SET shipping = 0, total =  WHERE SalesOrderID = 1302

--EXEC pts_SalesOrder_Custom_11 0, 13834
--select * from SalesOrder where SalesOrderID = 13834
--select * from SalesItem where SalesOrderID = 13834
--select * from Product where ProductID = 75

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom_11
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Ship int, @Amt money, @TaxAmt money, @Shipping money, @Tax money, @Total money, @MemberID int, @Level int, @State varchar(30)
DECLARE @PromotionID int, @Discount money, @tmpAmount money, @PaymentID int, @Notes nvarchar(1000), @DiscountText nvarchar(100)
DECLARE @MemberStatus int, @Title int, @cnt int, @pak int, @CountryID int, @tmpShip int, @Code varchar(10)

SET @CompanyID = 11

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
			IF @Ship = 2 AND @CountryID != 224 SET @tmpShip = 4
			IF @Ship = 3 AND @CountryID = 224 SET @tmpShip = 1
			IF @Ship = 4 AND @CountryID = 224 SET @tmpShip = 2
			IF @Ship != @tmpShip
			BEGIN
				SET @Ship = @tmpShip
				UPDATE SalesOrder SET Ship = @Ship WHERE SalesOrderID = @SalesOrderID
			END
		END
	END

	IF @Ship = 1 SET @Shipping = 5.99
	IF @Ship = 2 SET @Shipping = 10.99
	IF @Ship = 3 SET @Shipping = 45.00
	IF @Ship = 4 SET @Shipping = 59.00

	SET @Total = ( @Amt + @Shipping + @Tax )

	UPDATE SalesOrder SET Shipping = @Shipping, Tax = @Tax, Discount = @Discount, Total = @Total, Notes = @Notes WHERE SalesOrderID = @SalesOrderID  
END

-- Finalize Purchase of Sales Order
IF @Status = 1
BEGIN
--	Default All Payments to non-commissionable	
--	Update Payment SET CommStatus = 3 WHERE OwnerType = 52 AND OwnerID = @SalesOrderID
print ''
END

GO