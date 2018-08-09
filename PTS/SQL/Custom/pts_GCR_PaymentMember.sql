EXEC [dbo].pts_CheckProc 'pts_GCR_PaymentMember'
GO

--DECLARE @Count int EXEC pts_GCR_PaymentMember 28995, 0,0,0,0,0,'',@Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_GCR_PaymentMember
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
SET @CompanyID = 17

DECLARE @Token int, @TokenType int, @TokenOwner int
DECLARE @Total money, @Credit money
DECLARE @cnt int, @Notes nvarchar(500), @tmpNotes nvarchar(500), @tmpDescription varchar(200), @tmpPurpose varchar(100)
DECLARE @PayType int, @BillingInfo nvarchar(200), @tmpCode varchar(10), @months int
DECLARE @Now datetime, @PaymentID int, @CreditAmt money, @Status int, @ProductID int, @Binary int, @tmpCount int 

SET @Now = GETDATE()
IF @Price = 0 
BEGIN
	SELECT @Price = Price, @InitPrice = InitPrice, @EnrollDate = EnrollDate, @BillingID = BillingID, @PaidDate = PaidDate, @Options2 = Options2
	FROM Member WHERE MemberID = @MemberID
END

SET @Count = 0
SET @tmpPurpose = ''

--	Only process Autoships
EXEC pts_GCR_ValidAutoShip @Options2, @tmpPurpose OUTPUT

--	Set # of months for autoship payment
SET @months = 1
	 
IF @tmpPurpose <> ''
BEGIN
	SET @Total = @Price
	SET @Price = @Total
	SET @Credit = 0
	SET @Cnt = 0
	SET @Notes = ''
	SET @tmpNotes = ''
	SET @tmpDescription = ''
	SET @Token = 0
	SET @TokenType = 0
	SET @TokenOwner = 0

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
		WHEN 1 THEN CAST(CardType AS varchar(10)) + '; ' + CardNumber + '; ' + CAST(CardMo AS varchar(10)) + '/' + CAST(CardYr AS varchar(10)) + '; ' + CardCode + '; ' + CardName + '; ' + Street1 + '; ' + Street2 + '; ' + City + '; ' + State + '; ' + Zip + '; ' + co.Code
		WHEN 2 THEN CheckBank + '; ' + CheckRoute + '; ' + CheckAccount + '; ' + CheckNumber + '; ' + CheckName + '; ' + CAST(CheckAcctType AS varchar(2))
		WHEN 4 THEN CAST(CardType AS varchar(10)) + '; ' + CardName
		ELSE ''
		END
	FROM Billing AS bi
	LEFT OUTER JOIN Country AS co ON bi.CountryID = co.CountryID
	WHERE BillingID = @BillingID

	SET @tmpDescription = @tmpDescription + 'Charged:[' + @BillingInfo + ']'
	SET @Notes = CAST(MONTH(@Now) AS VARCHAR(10)) + '/' + CAST(DAY(@Now) AS VARCHAR(10)) + '/' + CAST(YEAR(@Now) AS VARCHAR(10))

--		Check for other credits to be applied to this payment
	SET @CreditAmt = 0
	EXEC pts_Payment_Credit @CompanyID, @MemberID, @Price, @CreditAmt OUTPUT 
	IF @CreditAmt > 0
	BEGIN
		SET @Credit = @Credit + @CreditAmt
		SET @Price = @Price - @CreditAmt	
	END

	SET @Status = 1
--		If there is no price to bill for this payment, mark it approved.
	IF @Price = 0 SET @Status = 3

--		Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--		Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType, TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
		 @Total, @Total, @Credit, 0, 0, @tmpDescription, @tmpPurpose, @Status, '', @Notes, 1, 0, @TokenType, @TokenOwner, @Token, 1

	SET @Count = 1

--		Do Payment post processing
	EXEC pts_GCR_PaymentPost @PaymentID, @tmpCount OUTPUT

--		Advance paid date to next bill date
	SET @PaidDate = DATEADD(month,@months,@PaidDate)
--		Update member paid date
	UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID
END

GO
