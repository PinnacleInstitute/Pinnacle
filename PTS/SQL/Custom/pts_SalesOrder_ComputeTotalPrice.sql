EXEC [dbo].pts_CheckProc 'pts_SalesOrder_ComputeTotalPrice'
 GO
--select * from SalesOrder where SalesOrderID = 13834
--exec pts_SalesOrder_ComputeTotalPrice 13834

CREATE PROCEDURE [dbo].pts_SalesOrder_ComputeTotalPrice ( 
      @SalesOrderID int 
      )
AS

DECLARE @BillDate datetime, @IsRecur bit, @Status int, @Discount money, @Ship int, @IsTaxable int, @PromotionID int, @Products nvarchar(50) 
DECLARE @Price money, @BV money, @Tax money, @Shipping money, @Amount money, @CreditAmount money, @CreditRate money, @ProductID int
DECLARE @StartDate datetime, @EndDate datetime, @CompanyID int, @CountryID int, @tmpShip int, @MemberID int 

-- Validate Sales Order
EXEC pts_SalesOrder_Validate @SalesOrderID

SET @BillDate = GETDATE()
SET @Discount = 0
SET @CreditAmount = 0
SET @CreditRate = 0
SET @CountryID = 0

-- Get Sales Order Info
SELECT  @Status = Status, @Ship = Ship, @IsTaxable = IsTaxable, @PromotionID = PromotionID, @IsRecur = IsRecur, @CompanyID = CompanyID, @MemberID = MemberID
FROM SalesOrder (NOLOCK)
WHERE SalesOrderID = @SalesOrderID

--	Only calculate totals if the order is not completed and its not a recurring order.
IF @Status < 3 AND @IsRecur = 0
BEGIN

--	Check for valid Shipping option based on Member's address
	If @Ship > 0
	BEGIN
		SELECT TOP 1 @CountryID = CountryID FROM Address WHERE OwnerType = 4 AND OwnerID = @MemberID ORDER BY IsActive DESC, AddressType
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

--	Check for Required Shipping
	IF @Ship = 0
	BEGIN
		DECLARE @ShipRequired int
		EXEC pts_SalesOrder_GetShipping @SalesOrderID, @ShipRequired OUTPUT
		IF @ShipRequired > 0
		BEGIN
--			If shipping is required and no shipping method is specified, use ship method 1
			SET @Ship = 1
			UPDATE SalesOrder SET Ship = @Ship WHERE SalesOrderID = @SalesOrderID
		END
	END

--	Get Promotion
	IF @PromotionID > 0
	BEGIN
		SELECT @ProductID = ProductID, @CreditAmount = Amount, @CreditRate = Rate, @Products = Products, @StartDate = StartDate, @EndDate = EndDate
		FROM Promotion WHERE PromotionID = @PromotionID

		IF (@StartDate = 0 OR @BillDate >= @Startdate) AND (@EndDate = 0 OR @BillDate <= @EndDate)
		BEGIN
			IF @ProductID > 0
			BEGIN
				SELECT  @Amount = SUM((Price+OptionPrice)*quantity)
				FROM    SalesItem (NOLOCK)
				WHERE   SalesOrderID = @SalesOrderID AND ProductID = @ProductID
--				-- No discounts or Free Products if they don't have the referenced ProductID  	
				IF @Amount IS NULL
				BEGIN
					SET @Amount = 0
					SET @Products = ''
					SET @CreditAmount = 0
					SET @CreditRate = 0
				END
				ELSE
				BEGIN
					IF @Amount < @CreditAmount SET @CreditAmount = @Amount
					IF @CreditRate > 0
					BEGIN
						SET @CreditAmount = @CreditAmount + ( @Amount * (@CreditRate / 100) )
						SET @CreditRate = 0
					END	
				END	
			END

--			-- Get additional Product discounts if specified
			IF @Products <> ''
			BEGIN
				EXEC pts_Promotion_ProductsPrice @SalesOrderID, @Products, @Amount OUTPUT
				IF @Amount > 0 SET @CreditAmount = @CreditAmount + @Amount
			END
		END
		ELSE
		BEGIN
			SET @CreditAmount = 0
			SET @CreditRate = 0
		END
	END

--	Get Price totals
	SELECT  @Price = SUM(isnull((Price+OptionPrice)*quantity,0)) ,
			@BV = SUM(isnull((BV)*quantity,0))
	FROM    SalesItem (NOLOCK)
	WHERE   SalesOrderID = @SalesOrderID
	AND     BillDate <= @BillDate
	
--	--************************************************************************************
--	-- Update Promotion Credits
	IF @CreditAmount > 0 SET @Discount = @CreditAmount
	IF @CreditRate > 0 SET @Discount = @Discount + (@Price * (@CreditRate / 100))

--	--************************************************************************************
--	Get Taxes
	SET @Tax = 0
	IF @IsTaxable = 0
	BEGIN
		SELECT  @Tax = SUM(isnull(si.Tax*si.Quantity,0))
		FROM    SalesOrder AS so (NOLOCK)
				JOIN SalesItem AS si (NOLOCK) ON (so.SalesOrderID = si.SalesOrderID)
		WHERE   so.SalesOrderID = @SalesOrderID
		AND     si.BillDate <= @BillDate
	END
	
--	--************************************************************************************
--	-- Calculate Shipping Costs
	SET @Shipping = 0
	IF @Ship > 0
	BEGIN
		SELECT  @Shipping = 
		CASE @Ship
			WHEN 1 THEN SUM(isnull(pr.Ship1,0))
			WHEN 2 THEN SUM(isnull(pr.Ship2,0))
			WHEN 3 THEN SUM(isnull(pr.Ship3,0))
			WHEN 4 THEN SUM(isnull(pr.Ship4,0))
		END +
		CASE @Ship
			WHEN 1 THEN SUM(isnull(pr.Ship1a*(si.quantity-1),0))
			WHEN 2 THEN SUM(isnull(pr.Ship2a*(si.quantity-1),0))
			WHEN 3 THEN SUM(isnull(pr.Ship3a*(si.quantity-1),0))
			WHEN 4 THEN SUM(isnull(pr.Ship4a*(si.quantity-1),0))
		END
		FROM    SalesOrder AS so (NOLOCK)
				JOIN SalesItem AS si (NOLOCK) ON (so.SalesOrderID = si.SalesOrderID)
				JOIN Product AS pr (NOLOCK) ON (si.ProductID = pr.ProductID)
		WHERE   so.SalesOrderID = @SalesOrderID
		AND     si.BillDate <= @BillDate
	END

--	--************************************************************************************
--	-- Update Sales Order
	UPDATE so
	SET    so.Amount = isnull(@Price,0), 
		   so.BV = isnull(@BV,0), 
		   so.Tax = isnull(@Tax,0),
		   so.Shipping = isnull(@Shipping,0),
		   so.Discount = @Discount,	
		   so.Total = (isnull(@Price,0)-@Discount) + isnull(@Tax,0) + isnull(@Shipping,0)
	FROM    SalesOrder AS so (NOLOCK)
	WHERE   so.SalesOrderID = @SalesOrderID

--	--************************************************************************************
--	-- Process Sales Order Custom calculations
	EXEC pts_SalesOrder_Custom @CompanyID, 0, @SalesOrderID
	
END

GO
