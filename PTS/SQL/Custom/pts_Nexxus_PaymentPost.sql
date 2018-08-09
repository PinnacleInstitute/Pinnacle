EXEC [dbo].pts_CheckProc 'pts_Nexxus_PaymentPost'
GO
--select * from payment where paymentid = 21937
--select * from SalesOrder where salesorderid = 15631
--declare @Result varchar(1000) EXEC pts_Nexxus_PaymentPost 90549, @Result output print @Result
--SELECT OwnerType, OwnerID, Status FROM Payment WHERE PaymentID = 19698

--DECLARE @Result int EXEC pts_Nexxus_PaymentPost 170233, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_Nexxus_PaymentPost
   @PaymentID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @MemberID int, @Status int, @CommStatus int, @Count int, @MemberStatus int, @ReferralID int, @ID int, @Result2  nvarchar (100), @BV money, @SV money
DECLARE @Now datetime, @Today datetime, @PaidDate datetime, @Notes varchar(500), @Purpose nvarchar (100), @cnt int

SET @Now = GETDATE()
SET @Today = dbo.wtfn_DateOnly( @Now )
SET @Count = 0

-- Get Payment Info
SELECT @MemberID = OwnerID, @Status = [Status], @CommStatus = CommStatus, @Purpose = Purpose FROM Payment WHERE PaymentID = @PaymentID

-- Get Member info
SELECT @MemberStatus = [Status], @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID

-- Get Bonus Volume for this payment
EXEC pts_Nexxus_PaymentBV @PaymentID, @BV OUTPUT

-- Process Approved Payment
IF @Status = 3
BEGIN
--	If Customer, process payment for their referring member
	IF @MemberStatus = 3
	BEGIN
		SET @MemberID = @ReferralID	
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
	END

--	Create Product Certificates for certificate purchase (100) and affiliate packages (101,102,103)
	IF @Purpose IN ('100','101','102','103')  EXEC pts_Nexxus_PaymentGift @PaymentID, @Result

--	Create Credits for ad pack purchases - affiliate packages (106,107,108) consumer packages (116,117,118)
	IF @Purpose IN ('106','107','108','116','117','118')  EXEC pts_Nexxus_PaymentAd @PaymentID, @Result

--	If we have a BV
	IF @BV > 0
	BEGIN
		SET @SV = @BV
--		IF Ad Pack, use 100% revenue for sales volume	
		IF @Purpose IN ('106','116') SET @SV = 10
		IF @Purpose IN ('107','117') SET @SV = 25
		IF @Purpose IN ('108','118') SET @SV = 50

--		Credit group sales volume for this member and his upline
		IF @CommStatus = 1 EXEC pts_Nexxus_SetTotalSales @MemberID, @SV, 0, @Result output

--		Credit Binary sales volume for this member and upline binary sales volume
		IF @CommStatus = 1 EXEC pts_Nexxus_PaymentBinary @MemberID, @PaymentID, @BV

--		Check for a possible change to the bonus qualified status for this member
		EXEC pts_Nexxus_QualifiedMember @MemberID, 1, 0, @Result2

--		If the payment is not bonused yet - calc bonuses
		IF @CommStatus = 1 EXEC pts_Commission_Company_21a @PaymentID, @Count OUTPUT

--		Check for possible advancement for this member's referrer
		IF @ReferralID > 0 EXEC pts_Commission_CalcAdvancement_21 @ReferralID, 0, @cnt OUTPUT

		SET @Result = @Count
	END
END

-- Process Cancelled and Returned Payments
IF @Status = 5 OR @Status = 6 
BEGIN
--	If we have a BV
	IF @BV > 0
	BEGIN
--		If Customer, process payment for their referring member
		IF @MemberStatus = 3 SET @MemberID = @ReferralID	

--		Debit Binary sales volume for this member and upline binary sales volume
		EXEC pts_Nexxus_PaymentBinaryDeduct @MemberID, @PaymentID, @BV, 3
		
		SET @Result = 3
	END
END

GO 
