EXEC [dbo].pts_CheckProc 'pts_Payment_CompanyDebit'
GO

CREATE PROCEDURE [dbo].pts_Payment_CompanyDebit
   @CompanyID int ,
   @PayDate datetime ,
   @MemberID int ,
   @PayoutID int ,
   @Total money ,
   @Cnt int OUTPUT
AS

SET NOCOUNT ON
SET @Cnt = 0

DECLARE @SalesItemID int, @SalesOrderID int, @ProductID int, @BillDate datetime, @EndDate datetime, @Qty int
DECLARE @Price money, @OptionPrice money, @BV money, @Recur int, @CommPlan int, @ProductName varchar(100) 
DECLARE @Amount money, @CommAmount money, @CommissionID int, @PaymentID int, @CommType int, @PayType int, @Description varchar(200), @CommStatus int

DECLARE @DueDate datetime
SET @DueDate = DATEADD(month, 1, dbo.wtfn_DateOnly(@PayDate))

-- Get all recurring sales items for this member that are coming due within the next month
DECLARE SalesItem_cursor CURSOR LOCAL STATIC FOR 
SELECT si.SalesItemID, si.SalesOrderID, si.ProductID, si.BillDate, si.EndDate, si.Quantity, 
	si.Price, si.OptionPrice, pr.BV, pr.Recur, pr.CommPlan, pr.ProductName 
FROM   SalesItem AS si
JOIN   SalesOrder AS so ON so.SalesOrderID = si.SalesOrderID
JOIN   Member AS me ON so.MemberID = me.MemberID
JOIN   Product AS pr ON si.ProductID = pr.ProductID
WHERE  so.MemberID = @MemberID AND me.Status < 6 
AND    si.BillDate <= @DueDate 
AND    (si.EndDate > @DueDate OR si.EndDate = 0 )

OPEN SalesItem_cursor
FETCH NEXT FROM SalesItem_cursor INTO @SalesItemID, @SalesOrderID, @ProductID, @BillDate, @EndDate, @Qty, 
					@Price, @OptionPrice, @BV, @Recur, @CommPlan, @ProductName 
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Amount = (@Price + @OptionPrice) * @Qty

--	If the price of the sales item is less than or equal to the total earnings, then create the debit
	IF @Amount <= @Total 
	BEGIN
--		Adjust the total earning by this debit, for possible other recurring payments for this member
		SET @Total = @Total - @Amount

--		Set CommType to Debit
		SET @CommType = -1
		SET @Description = 'Debit: ' + @ProductName
		SET @CommAmount = @Amount * -1
--		CommissionID OUTPUT, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, UserID
		EXEC pts_Commission_Add @CommissionID OUTPUT, @CompanyID, 4, @MemberID, @PayoutID, 0, @PayDate, 1, @CommType, @CommAmount, @CommAmount, 0, @Description, '', 1

--		Update Payout Amount
		UPDATE Payout SET Amount = Amount + @CommAmount WHERE PayoutID = @PayoutID

		SET @Description = 'Charged:[Commission:' + CAST(@CommissionID AS VARCHAR(10)) + ']'
		SET @BV = @Qty * @BV
--		If the product is commissionable, set the commission status
		IF @CommPlan > 0 SET @CommStatus = 1 ELSE SET @CommStatus = 3
	
--		Set PayType so that the Payment is made from earned commissions
		SET @PayType = 90
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
		EXEC pts_Payment_Add @PaymentID, @CompanyID, 52, @SalesOrderID, 0, @ProductID, 0, @DueDate, 0, @PayType, 
				    @Amount, @Amount, 0, 0, @BV, @Description, '', 3, '', '', @CommStatus, 0, 0, 0, 0, 1
	
--		Update SalesItem Next Bill Date
		IF @Recur > 0
		BEGIN
			IF @Recur = 1 SET @BillDate = DATEADD(month,1,@BillDate)
			IF @Recur = 2 SET @BillDate = DATEADD(week,1,@BillDate)
			IF @EndDate > 0 AND @BillDate > @EndDate SET @BillDate = 0
			UPDATE SalesItem SET BillDate = @BillDate WHERE SalesItemID = @SalesItemID
		END
	
		SET @Cnt = @Cnt + 1
	END

	FETCH NEXT FROM SalesItem_cursor INTO @SalesItemID, @SalesOrderID, @ProductID, @BillDate, @EndDate, @Qty, 
						@Price, @OptionPrice, @BV, @Recur, @CommPlan, @ProductName 
END

CLOSE SalesItem_cursor
DEALLOCATE SalesItem_cursor

GO
