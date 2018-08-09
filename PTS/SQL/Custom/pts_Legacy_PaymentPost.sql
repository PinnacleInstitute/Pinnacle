EXEC [dbo].pts_CheckProc 'pts_Legacy_PaymentPost'
GO
--select * from payment where paymentid = 21937
--select * from SalesOrder where salesorderid = 15631
--declare @Result varchar(1000) EXEC pts_Legacy_PaymentPost 23381, @Result output print @Result
--SELECT OwnerType, OwnerID, Status FROM Payment WHERE PaymentID = 19698

CREATE PROCEDURE [dbo].pts_Legacy_PaymentPost
   @PaymentID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @OwnerType int, @OwnerID int, @Status int, @MemberStatus int, @CommStatus int, @Count int, @MemberID int, @SalesOrderID int, @Options2 varchar(40)
DECLARE @ID int, @Today datetime, @PayDate datetime, @Notes varchar(500), @ReferralID int, @Result2 int, @Binary int, @Purpose varchar(100), @tmpPurpose varchar(100)
SET @Today = dbo.wtfn_DateOnly( GETDATE() )
SET @Count = 0
select * from Payment where CompanyID = 14

SELECT @OwnerType = OwnerType, @OwnerID = OwnerID, @Status = [Status], @CommStatus = CommStatus, @PayDate = PayDate, @Notes = Notes, @Purpose = Purpose 
FROM Payment WHERE PaymentID = @PaymentID

-- Process Submitted, Pending, Approved and Declined Payments
IF @Status >= 1 AND @Status <= 4 
BEGIN
--	If this payment belongs to a member - convert it to a sales order
	IF @OwnerType = 4
	BEGIN
		EXEC pts_Legacy_ConvertPayment @PaymentID, @Result output
		SET @MemberID = @OwnerID
		SET @SalesOrderID = CAST(@Result AS int)
	END
--	If this payment belongs to a sales order - get the member of the sales order
	IF @OwnerType = 52 
	BEGIN
		SET @SalesOrderID = @OwnerID
		SELECT @MemberID = MemberID FROM SalesOrder WHERE SalesOrderID = @SalesOrderID
	END

--	If the payment is Approved
	IF @Status = 3
	BEGIN
--		Check for a possible change to the bonus qualified status for this member
		EXEC pts_Legacy_QualifiedMember @MemberID, 1, 0, @Result2

--		Only process binary sales volume for NON Autoships
		SET @Binary = 0
		EXEC pts_Legacy_ValidAutoShip @Purpose, @tmpPurpose OUTPUT
		IF @tmpPurpose = '' SET @Binary = 1

		IF @Binary = 1 AND CHARINDEX( 'B*', @Notes ) > 0  SET @Binary = 0 
--		IF CHARINDEX( 'B*', @Notes ) = 0  SET @Binary = 1 
		
--		Check if this payment has not already been binary processed (Notes = B*...)
		IF @Binary = 1
		BEGIN
--			-- Check if this is a free retail customer (Status = 3), if so get the referrer
			SELECT @MemberStatus = [Status], @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
			IF @MemberStatus = 3 AND @ReferralID > 0
			BEGIN
				SET @MemberID = @ReferralID
--				-- Get the referrer's weak leg, to put the binary sales volume
				SET @ID = 0
				SELECT TOP 1 @ID = MemberID FROM Member WHERE Sponsor3ID = @MemberID ORDER BY QV4
				IF @ID > 0 SET @MemberID = @ID 
			END
			EXEC pts_Legacy_PaymentBinary @MemberID, @SalesOrderID
		END
--		If the payment is not bonused yet - calc bonuses
		IF @CommStatus = 1 EXEC pts_Commission_Company_14a @PaymentID, @Count OUTPUT
	END
	SET @Result = @Count
END

-- Process Cancelled and Returned Payments
IF @Status = 5 OR @Status = 6 
BEGIN
--	Only process Sales Order Payments
	IF @OwnerType = 52
	BEGIN
		SET @Result = 1
		SET @SalesOrderID = @OwnerID

		SET @Result = 2
--		Check if we have already deducted this amount from the Binary Sales
		SELECT @Count = COUNT(*) FROM BinarySale WHERE RefID = @SalesOrderID AND SaleType = 3
		IF @Count = 0 
		BEGIN
			SELECT @MemberID = MemberID FROM SalesOrder WHERE SalesOrderID = @SalesOrderID

	--		-- Check if this is a free retail customer (Status = 3), if so get the referrer
			SELECT @MemberStatus = [Status], @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
			IF @MemberStatus = 3 AND @ReferralID > 0
			BEGIN
				SET @MemberID = @ReferralID
	--			-- Get the referrer's weak leg, to put the binary sales volume
				SET @ID = 0
				SELECT TOP 1 @ID = MemberID FROM Member WHERE Sponsor3ID = @MemberID ORDER BY QV4
				IF @ID > 0 SET @MemberID = @ID 
			END

			EXEC pts_Legacy_PaymentBinaryDeduct @MemberID, @SalesOrderID, 3
			SET @Result = 3
		END
	END
END

GO 
