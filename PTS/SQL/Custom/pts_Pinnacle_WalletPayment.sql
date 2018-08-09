EXEC [dbo].pts_CheckProc 'pts_Pinnacle_WalletPayment'
GO

--declare @Result int EXEC pts_Pinnacle_WalletPayment 59540, 12357, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Pinnacle_WalletPayment
   @Quantity int ,
   @Amount int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @MemberID int, @PaymentID int, @Available money, @PaymentAmount money, @PayoutID int, @CompanyID int, @Today datetime, @Reference varchar (30)
DECLARE @OwnerType int, @OwnerID int

SET @PaymentID = @Quantity
SET @MemberID = @Amount
SET @PayoutID = 0
SET @Available = 0
SET @PaymentAmount = 0
SET @Today = dbo.wtfn_DateOnly(GETDATE())

IF @PaymentID != 0
BEGIN
--	Get Payment Amount
	SELECT @PaymentAmount = Amount, @CompanyID = CompanyID, @OwnerType = OwnerType, @OwnerID = OwnerID FROM Payment WHERE PaymentID = @PaymentID

	IF @MemberID = 0 
	BEGIN
		IF @OwnerType = 4 SET @MemberID = @OwnerID
		IF @OwnerType = 52 SELECT @MemberID = MemberID FROM SalesOrder Where SalesOrderID = @OwnerID
	END

	IF @MemberID > 0 
	BEGIN
--		Get Available Funds from the Member's Wallet	
		SELECT @Available = ISNULL(SUM(Amount),0) FROM Payout WHERE OwnerType = 4 AND OwnerID = @MemberID AND Status IN (1,4,5,7)

		IF @PaymentAmount <= @Available
		BEGIN
			SET @PaymentAmount = @PaymentAmount * -1
			SET @Reference = CAST(@PaymentID AS VARCHAR(10))
--			PayoutID,CompanyID,OwnerType,OwnerID,PayDate,PaidDate,Amount,Status,Notes,PayType,Reference,Show,UserID
			EXEC pts_Payout_Add @PayoutID OUTPUT, @CompanyID, 4, @MemberID, @Today, @Today, @PaymentAmount, 1, '', 90, @Reference, 0, 1
			SET @Result = @PayoutID
		END
	END

END

Go