EXEC [dbo].pts_CheckProc 'pts_Payment_CompanyPayments'
GO

CREATE PROCEDURE [dbo].pts_Payment_CompanyPayments
   @CompanyID int,
   @PayDate datetime,
   @Count int OUTPUT
AS

SET NOCOUNT ON
SET @Count = 0

DECLARE @PaymentID int, @PayType int, @Description varchar(200), @CommStatus int, @BillDate datetime, @EndDate datetime
DECLARE @SalesOrderID int, @SalesItemID int, @MemberID int, @ProductID int, @BillingID int, @Qty int
DECLARE @Price money, @OptionPrice money, @BV money, @Total money, @Recur int, @CommPlan int 

IF @PayDate = 0 SET @PayDate = dbo.wtfn_DateOnly(GETDATE())

-- Get all sales items with recurring payments
DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT si.SalesItemID, si.SalesOrderID, me.MemberID, si.ProductID, me.BillingID, 
       si.BillDate, si.EndDate, si.Quantity, si.Price, si.OptionPrice, pr.BV, pr.Recur, pr.CommPlan 
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON so.SalesOrderID = si.SalesOrderID
JOIN   Member AS me ON so.MemberID = me.MemberID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
WHERE  me.CompanyID = @CompanyID AND me.Status < 6 
AND    si.BillDate <= @PayDate 
AND    (si.EndDate > @PayDate OR si.EndDate = 0 )

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @SalesItemID, @SalesOrderID, @MemberID, @ProductID, @BillingID, 
					@BillDate, @EndDate, @Qty, @Price, @OptionPrice, @BV, @Recur, @CommPlan 
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @PayType = 0
	SET @Description = ''
	
	IF @BillingID > 0
	BEGIN
--		Get the billing info from the member
		SELECT @PayType = 
			CASE PayType
			WHEN 1 THEN CardType 
			WHEN 2 THEN 5
			ELSE 0
			END, 
			@Description = 
			CASE PayType
			WHEN 1 THEN CAST(CardType AS varchar(10)) + '; ' + CardNumber + '; ' + CAST(CardMo AS varchar(10)) + '/' + CAST(CardYr AS varchar(10)) + '; ' + CardCode + '; ' + CardName + '; ' + Street1 + '; ' + Street2 + '; ' + City + '; ' + State + '; ' + Zip + '; ' + co.Code + '; ' + Token
			WHEN 2 THEN CheckBank + '; ' + CheckRoute + '; ' + CheckAccount + '; ' + CheckNumber + '; ' + CheckName + '; ' + CAST(CheckAcctType AS varchar(2))
			WHEN 4 THEN CAST(CardType AS varchar(10)) + '; ' + CardName
			ELSE ''
			END
		FROM Billing AS bi
		LEFT OUTER JOIN Country AS co ON bi.CountryID = co.CountryID
		WHERE BillingID = @BillingID
	END
	ELSE
	BEGIN
--		Get the latest payment for the member
		SELECT TOP 1 @PayType = PayType, @Description = Description
		FROM   Payment AS pa
		JOIN   SalesOrder AS so ON pa.OwnerType = 52 AND pa.OwnerID = so.SalesOrderID
		WHERE  so.MemberID = @MemberID 
		ORDER BY pa.PayDate DESC
	END

	SET @Description = 'Charged:[' + @Description + ']'
	SET @BV = @Qty * @BV
	SET @Total = (@Price + @OptionPrice) * @Qty
--	If the product is commissionable, set the commission status
	IF @CommPlan > 0 SET @CommStatus = 1 ELSE SET @CommStatus = 3

--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID, @CompanyID, 52, @SalesOrderID, 0, @ProductID, 0, @PayDate, 0, @PayType, 
			    @Total, @Total, 0, 0, @BV, @Description, '', 1, '', '', @CommStatus, 0, 0, 0, 0, 1

--	Update SalesItem Next Bill Date
	IF @Recur > 0
	BEGIN
		IF @Recur = 1 SET @BillDate = DATEADD(month,1,@BillDate)
		IF @Recur = 2 SET @BillDate = DATEADD(week,1,@BillDate)
		IF @EndDate > 0 AND @BillDate > @EndDate SET @BillDate = 0
		UPDATE SalesItem SET BillDate = @BillDate WHERE SalesItemID = @SalesItemID
	END

	SET @Count = @Count + 1
	FETCH NEXT FROM SalesItem_cursor INTO @SalesItemID, @SalesOrderID, @MemberID, @ProductID, @BillingID, 
						@BillDate, @EndDate, @Qty, @Price, @OptionPrice, @BV, @Recur, @CommPlan 
END

CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor

GO