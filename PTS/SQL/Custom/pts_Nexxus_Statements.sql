EXEC [dbo].pts_CheckProc 'pts_Nexxus_Statements'
GO
--select * from statement
--select * from payment2
--select * from merchant
--update merchant set billdate = '9/11/16' 
--update payment2 set statementid = 0
--delete statement

--declare @Result varchar(1000) EXEC pts_Nexxus_Statements @Result output print @Result

CREATE PROCEDURE [dbo].pts_Nexxus_Statements
   @Result varchar(100) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @cnt int, @amt money, @now datetime, @cash money, @credit money, @bonus money, @Test int 
DECLARE @MerchantID int, @BillDate datetime, @BillDays int, @StatementID int, @Processor int, @Payment VARCHAR(1000), @Amount money
SET @CompanyID = 21
SET @cnt = 0
SET @amt = 0
SET @now = GETDATE()
SET @Test = 0

DECLARE Merchant_Cursor CURSOR LOCAL STATIC FOR 
SELECT MerchantID, BillDate, BillDays, Processor, Payment FROM Merchant WHERE Status = 3 AND BillDate < @now

OPEN Merchant_Cursor
FETCH NEXT FROM Merchant_Cursor INTO @MerchantID, @BillDate, @BillDays, @Processor, @Payment
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Create Statement  *********************************************************
	-- Get total amount for statement
	SELECT @cash = ISNULL(SUM(Cashback+Fee),0) FROM Payment2 WHERE MerchantID = @MerchantID AND StatementID = 0 AND PayType = 1 AND Status = 2
	SELECT @credit = ISNULL(SUM(Merchant),0) FROM Payment2 WHERE MerchantID = @MerchantID AND StatementID = 0 AND PayType = 2 AND Status = 2
	SELECT @bonus = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerType=150 AND OwnerID = @MerchantID AND Status = 1 AND PayoutID = 0

	IF @cash > 0.00 OR @credit > 0.00 OR @bonus > 0.00
	BEGIN
		SET @Amount = @cash - ( @credit + @bonus )
		SET @amt = @amt + @Amount
		SET @cnt = @cnt + 1
		SET @Payment = LEFT(@Payment,500)
		IF @Test <> 0
		BEGIN
			PRINT 'Merchant: ' + CAST(@MerchantID AS VARCHAR(10)) + ' Amount: '  + CAST(@Amount AS VARCHAR(20))
		END
		ELSE
		BEGIN
			-- @StatementID,CompanyID,MerchantID,StatementDate,PaidDate,Amount,Status,PayType,Reference,Notes,UserID
			EXEC pts_Statement_Add @StatementID OUTPUT, @CompanyID, @MerchantID, @now, 0, @Amount, 1, @Processor, '', @Payment, 1

			-- Udpate Payments with Statement #
			UPDATE Payment2 SET StatementID = @StatementID WHERE MerchantID = @MerchantID AND StatementID = 0 AND PayType IN (1,2) AND Status = 2

			-- Udpate Commissions with Statement # (negative to distinquish from Payout)
			UPDATE Commission SET PayoutID = @StatementID * -1 WHERE OwnerType=150 AND OwnerID = @MerchantID AND Status = 1 AND PayoutID = 0

			-- Double-check for possible new created payments during this process
			SELECT @cash = ISNULL(SUM(Cashback+Fee),0) FROM Payment2 WHERE StatementID = @StatementID AND PayType = 1 AND Status = 2
			SELECT @credit = ISNULL(SUM(Merchant),0) FROM Payment2 WHERE StatementID = @StatementID AND PayType = 2 AND Status = 2
			SELECT @bonus = ISNULL(SUM(Total),0) FROM Commission WHERE OwnerType=150 AND OwnerID = @MerchantID AND Status = 1 AND PayoutID = 0
			IF @Amount <> @cash - ( @credit + @bonus )
			BEGIN
				SET @Amount = @cash - ( @credit + @bonus )
				UPDATE Statement SET Amount = @Amount WHERE StatementID = @StatementID
			END
		END
	END

	IF @Test = 0
	BEGIN
		-- UPDATE Next Billing Date **************************************************
		-- Validate Bill Days
		IF @BillDays < 1 OR @BillDays > 7
		BEGIN
			SET @BillDays = 7
			UPDATE Merchant SET BillDays = @BillDays WHERE MerchantID = @MerchantID
		END
		-- Check for old BillDate older than 14 days
		IF @BillDate = 0 OR @BillDate < DATEADD(d,-14,@now)
		BEGIN
			SET @BillDate = dbo.wtfn_DateOnly(@now)
			UPDATE Merchant SET BillDate = @BillDate WHERE MerchantID = @MerchantID
		END

		-- Set new billing date
		SET @BillDate = DATEADD(d, @BillDays, @BillDate)

		-- Save new Bill Date
		UPDATE Merchant SET BillDate = @BillDate WHERE MerchantID = @MerchantID
	END

	FETCH NEXT FROM Merchant_Cursor INTO @MerchantID, @BillDate, @BillDays, @Processor, @Payment
END
CLOSE Merchant_Cursor
DEALLOCATE Merchant_Cursor

SET @Result = CAST( @cnt AS VARCHAR(10)) + '|' + CAST( @amt AS VARCHAR(10))

GO

