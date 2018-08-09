EXEC [dbo].pts_CheckProc 'pts_Nexxus_PaymentMember'
GO

--DECLARE @Count int EXEC pts_Nexxus_PaymentMember 38700, 0,0,0,0,0,'',@Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_Nexxus_PaymentMember
   @MemberID int,
   @Price money, 
   @InitPrice money, 
   @EnrollDate datetime, 
   @BillingID int, 
   @PaidDate datetime, 
   @Options2 varchar(40),
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int
SET @CompanyID = 21

DECLARE @Token int, @TokenType int, @TokenOwner int
DECLARE @cnt int, @Notes nvarchar(500), @tmpDescription varchar(200), @tmpPurpose varchar(100)
DECLARE @PayType int, @BillingInfo nvarchar(200), @tmpCode varchar(10), @months int, @PaidDate2 datetime
DECLARE @Now datetime, @PaymentID int, @Status int, @PayoutID int, @tmpReference varchar(30)

IF @Price = 0 
BEGIN
	SELECT @Price = Price, @InitPrice = InitPrice, @EnrollDate = EnrollDate, @BillingID = BillingID, @PaidDate = PaidDate, @Options2 = Options2
	FROM Member WHERE MemberID = @MemberID
END

--	Only process Autoships
EXEC pts_Nexxus_ValidAutoShip @Options2, @tmpPurpose OUTPUT

IF @tmpPurpose <> ''
BEGIN
	SET @Count = 0
	SET @Now = GETDATE()
	SET @Notes = CAST(MONTH(@Now) AS VARCHAR(10)) + '/' + CAST(DAY(@Now) AS VARCHAR(10)) + '/' + CAST(YEAR(@Now) AS VARCHAR(10))
	--	Set # of months for autoship payment
	SET @months = 1
	SET @TokenType = 0
	SET @TokenOwner = 0
	SET @Token = 0
	SET @PaidDate2 = 0
	SET @tmpDescription = ''
	SET @tmpReference = ''

	SET @PayoutID = 0
	EXEC pts_Nexxus_PaymentWallet @MemberID, @Price, @PayoutID OUTPUT

	IF @PayoutID = 0
	BEGIN
--		Get Billing Information
		SET @PayType = 0
		SET @BillingInfo = ''
		SELECT @Token = Token, @TokenType = TokenType, @TokenOwner = TokenOwner,
			   @PayType = 
			CASE PayType
			WHEN 1 THEN CardType 
			WHEN 2 THEN 5
			WHEN 3 THEN 7
			WHEN 4 THEN CardType
			ELSE 0
			END, 
				@BillingInfo = 
			CASE PayType
			WHEN 1 THEN CAST(CardType AS varchar(10)) + '; ' + CardNumber + '; ' + CAST(CardMo AS varchar(10)) + '/' + CAST(CardYr AS varchar(10)) + '; ' + CardCode + '; ' + CardName + '; ' + Street1 + '; ' + Street2 + '; ' + City + '; ' + State + '; ' + Zip + '; ' + co.Code + '; ' + Token
			WHEN 2 THEN CheckBank + '; ' + CheckRoute + '; ' + CheckAccount + '; ' + CheckNumber + '; ' + CheckName + '; ' + CAST(CheckAcctType AS varchar(2))
			WHEN 4 THEN CAST(CardType AS varchar(10)) + '; ' + CardName
			ELSE ''
			END
		FROM Billing AS bi
		LEFT OUTER JOIN Country AS co ON bi.CountryID = co.CountryID
		WHERE BillingID = @BillingID

--		Adjust price for credit card processing
		IF @PayType IN ( 1, 2 )
		BEGIN
			IF @Price = 10 SET @Price = 11		
			IF @Price = 25 SET @Price = 27		
			IF @Price = 50 SET @Price = 53		
		END

		SET @tmpDescription = @tmpDescription + 'Charged:[' + @BillingInfo + ']'

		SET @Status = 1
--		If there is no price to bill for this payment, mark it approved.
		IF @Price = 0 SET @Status = 3
	END

	IF @PayoutID > 0
	BEGIN
		SET @Status = 3
		SET @PayType = 10
		SET @PaidDate2 = @PaidDate
		SET @tmpReference = CAST(@PayoutID AS VARCHAR(10))
	END

--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--	Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType, TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, 0, @PaidDate, @PaidDate2, @PayType, 
		 @Price, @Price, 0, 0, 0, @tmpDescription, @tmpPurpose, @Status, @tmpReference, @Notes, 1, 0, @TokenType, @TokenOwner, @Token, 1

	SET @Count = 1

	IF @PayoutID > 0
	BEGIN
		SET @tmpReference = CAST(@PaymentID AS VARCHAR(10))
		UPDATE Payout SET Reference = @tmpReference WHERE PayoutID = @PayoutID
	END

--	Do Payment post processing
	EXEC pts_Nexxus_PaymentPost @PaymentID, @cnt OUTPUT

--	Advance paid date to next bill date and save
	SET @PaidDate = DATEADD(month,@months,@PaidDate)
print @PaidDate	
	UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID
END

GO
