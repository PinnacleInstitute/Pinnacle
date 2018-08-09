EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Custom_1'
GO

--UPDATE SalesOrder SET Discount = 0 WHERE SalesOrderID = 1302
--EXEC pts_SalesOrder_Custom_1 0, 1302

CREATE PROCEDURE [dbo].pts_SalesOrder_Custom_1
   @Status int ,
   @SalesOrderID int
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Ship int, @Amt money, @TaxAmt money, @Shipping money, @Tax money, @Total money, @MemberID int, @Level int, @State varchar(30)
DECLARE @PromotionID int, @Discount money, @tmpAmount money, @PaymentID int, @Notes nvarchar(1000), @DiscountText nvarchar(100)
DECLARE @MemberStatus int, @Title int

SET @CompanyID = 1

-- Compute Total Prices for Sales Order
IF @Status = 0
BEGIN
	SET @Shipping = 0
	SET @Tax = 0

	SELECT @Ship = so.Ship, @Amt = so.Amount, @MemberID = ISNULL(me.MemberID,0), @Level = ISNULL(me.Level,0), 
		@PromotionID = PromotionID, @Discount = so.Discount, @Notes = so.Notes
	FROM SalesOrder AS so
	LEFT OUTER JOIN Member AS me ON so.MemberID = me.MemberID
	WHERE SalesOrderID = @SalesOrderID

--	Consultants pay shipping, Customer get free shipping $60+
	IF @Level = 1
	BEGIN
		SET @Shipping = 7.99
	END
	ELSE
	BEGIN
		IF @Amt >=  0 AND @Amt <  60 SET @Shipping = 7.99
		IF @Amt >= 60 SET @Shipping = 0
	END

--	IF @Amt >=  50 AND @Amt <  75 SET @Shipping = 11.99
--	IF @Amt >=  75 AND @Amt < 100 SET @Shipping = 12.99
--	IF @Amt >= 100 AND @Amt < 150 SET @Shipping = 14.99
--	IF @Amt >= 150 SET @Shipping = 16.99

	IF @Ship = 2 SET @Shipping = @Shipping + 7 
	IF @Ship = 3 SET @Shipping = @Shipping + 10 
	IF @Ship = 4 SET @Shipping = @Shipping + 17 

--	-- Check for Customers in Texas for Sales Tax
	IF @Level <> 1
	BEGIN
		SET @State = ''
		SELECT @State = LOWER(State) FROM Address WHERE OwnerType = 4 AND OwnerID = @MemberID AND AddressType = 3 AND IsActive <> 0
		IF @State = 'tx' OR @State = 'texas'
		BEGIN
			SELECT @TaxAmt = SUM(isnull((si.Price+si.OptionPrice)*si.Quantity,0)) 
			FROM   SalesItem AS si (NOLOCK)
			JOIN   Product AS pr ON si.ProductID = pr.ProductID
			WHERE  si.SalesOrderID = @SalesOrderID AND pr.IsTaxable != 0

			IF @TaxAmt > 0 SET @Tax = ROUND((@TaxAmt * .0825),2)
		END
	END

--	-- Check for Consultant Discount
	SET @DiscountText = ''
	IF @MemberID > 0 AND @Amt > 0
	BEGIN
		SELECT @MemberStatus = Status, @Title = Title FROM Member WHERE MemberID = @MemberID
		IF @MemberStatus = 1
		BEGIN
			EXEC pts_SalesOrder_Custom_1_Credit @Title, @Amt, @tmpAmount OUTPUT
			IF @tmpAmount > 0
			BEGIN
				SET @Discount = @Discount + @tmpAmount
				SET @DiscountText = @DiscountText + 'Consultant:' + CAST(@tmpAmount AS VARCHAR(10))
			END
		END
	END

	SET @Total = ( @Amt + @Shipping + @Tax ) - @Discount

--	-- Check for Inventory Credit Promotion Code
	IF @MemberID > 0 AND @PromotionID = 1
	BEGIN
		SET @tmpAmount = 0
		SELECT @tmpAmount = Total FROM Payment
		WHERE OwnerType = 4 AND OwnerID = @MemberID AND PayType = 91 AND Total > 0
		
		IF @tmpAmount > 0 
		BEGIN
			IF @tmpAmount > @Total SET @tmpAmount = @Total
			SET @Discount = @Discount + @tmpAmount
			SET @Total = @Total - @tmpAmount		
			SET @DiscountText = @DiscountText + ' Credit:' + CAST(@tmpAmount AS VARCHAR(10))
		END
	END

--	-- Check for Discount Notes
	IF @DiscountText != ''
	BEGIN
--		-- Remove old Discount Notes
		DECLARE @pos int, @pos2 int
		SET @pos = CHARINDEX ( 'Discount[', @Notes ) 
		IF @pos > 0
		BEGIN
			SET @pos2 = CHARINDEX ( ']', @Notes, @pos ) 
			IF @pos2 > 0 SET @Notes = Left(@Notes,@pos-1) + SUBSTRING(@Notes,@pos2+1, 1000)
		END
	
--		-- Add new Discount Notes
		Set @Notes = RTRIM(@Notes) + ' Discount[' + @DiscountText + ']'
	END

	UPDATE SalesOrder SET Shipping = @Shipping, Tax = @Tax, Discount = @Discount, Total = @Total, Notes = @Notes WHERE SalesOrderID = @SalesOrderID  
END

-- Finalize Purchase of Sales Order
IF @Status = 1
BEGIN
	SELECT @MemberID = MemberID, @PromotionID = PromotionID, @Discount = Discount, @Amt = Amount, @Total = Total
	FROM SalesOrder WHERE SalesOrderID = @SalesOrderID

--	-- process inventory credit
	IF @MemberID > 0 AND @PromotionID = 1
	BEGIN
		SET @PaymentID = 0
		SELECT @PaymentID = PaymentID, @tmpAmount = Total FROM Payment
		WHERE OwnerType = 4 AND OwnerID = @MemberID AND PayType = 91 AND Total > 0

--		-- Back out consultant credit from Discount
		SELECT @MemberStatus = Status, @Title = Title FROM Member WHERE MemberID = @MemberID
		IF @MemberStatus = 1
		BEGIN
			DECLARE @Credit money
			EXEC pts_SalesOrder_Custom_1_Credit @Title, @Amt, @Credit OUTPUT
			IF @Credit > 0 SET @Discount = @Discount - @Credit
		END

		IF @PaymentID > 0 AND @tmpAmount >= @Discount
		BEGIN
			UPDATE Payment SET Credit = Credit + @Discount, Total = Total - @Discount, Notes = Notes + CAST(@Discount AS VARCHAR(10)) + ', ' WHERE PaymentID = @PaymentID
		END
	END 
END

-- Delete All abandoned Shopping Carts older than today
IF @Status = 100
BEGIN
	DECLARE @Today datetime 
	SET @Today = dbo.wtfn_DateOnly( GETDATE() )

	DELETE si FROM SalesItem AS si
	JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID 
	WHERE so.CompanyID = @CompanyID AND so.Status = 0 AND so.OrderDate < @Today

	DELETE SalesOrder WHERE CompanyID = @CompanyID AND Status = 0 AND OrderDate < @Today
END

GO