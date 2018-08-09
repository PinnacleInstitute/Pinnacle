EXEC [dbo].pts_CheckProc 'pts_Payment_Credit'
GO
-- *****************************************************
-- Check if this company member has any other credits (payouts)
-- to be deducted from the billable amount.
-- *****************************************************
--DECLARE @Amount money
--EXEC pts_Payment_Credit 2, 86186, 49.95, @Amount OUTPUT 
--PRINT CAST(@Amount AS varchar(10))

CREATE PROCEDURE [dbo].pts_Payment_Credit
   @CompanyID int, 
   @MemberID int,
   @Price money,
   @Credit money OUTPUT 
AS

SET NOCOUNT ON

--IF @CompanyID = 2 OR @CompanyID = 6 OR @CompanyID = 7
IF @CompanyID = 5
BEGIN
	DECLARE @Amount money, @Now datetime, @PayoutID int, @Reference varchar(10)
	SET @Now = dbo.wtfn_DateOnly(GETDATE())
	SET @Reference = CAST(MONTH(@Now) AS VARCHAR(10)) + '/' + CAST(DAY(@Now) AS VARCHAR(10)) + '/' + CAST(YEAR(@Now) AS VARCHAR(10))

--	Check if this member has any unpaid payouts
	SELECT @Amount = SUM(amount)
	FROM Payout WHERE OwnerID = @MemberID and Status = 1

--	If they have a credit, update the payout status
	IF @Amount > 0
	BEGIN
--		-- If Amount <= the specified price, set status of payouts to paid 
		IF @Amount <= @Price
		BEGIN
			SET @Credit = @Amount
			UPDATE Payout SET PaidDate = @Now, Status = 2, PayType = 4, Reference = @Reference
			WHERE OwnerID = @MemberID and Status = 1
		END
		ELSE
		BEGIN
			SET @Credit = @Price
--			-- Create a debit payout, if the credit is more than the price		
			SET @Amount = @Price * -1
--			PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, View, UserID
			EXEC pts_Payout_Add @PayoutID, @CompanyID, 4, @MemberID, @Now, 0, @Amount, 1, '', 4, @Reference, 0, 1
		END
	END
END

GO
