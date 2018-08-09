EXEC [dbo].pts_CheckProc 'pts_PB_Payments'
GO

--DECLARE @Count varchar(1000) EXEC pts_PB_Payments 0, @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_PB_Payments
   @BillDate datetime,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 11

DECLARE @Count int
DECLARE @MemberID int, @Price money, @InitPrice money, @Token int, @TokenType int, @TokenOwner int
DECLARE @EnrollDate datetime, @BillingID int, @PaidDate datetime, @Options2 varchar(40)
DECLARE @Total money, @Credit money
DECLARE @cnt int, @Notes nvarchar(500), @tmpNotes nvarchar(500), @tmpDescription varchar(200), @tmpPurpose varchar(100)
DECLARE @PayType int, @BillingInfo nvarchar(200)
DECLARE @Now datetime, @PaymentID int, @CreditAmt money, @Status int, @ProductID int, @Binary int, @tmpCount int 

SET @Now = GETDATE()
IF @BillDate = 0 SET @BillDate = @Now
SET @Count = 0

--**********************************************************************************************************
--Process - Bill Members (Billing = 3)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Price, InitPrice, EnrollDate, BillingID, PaidDate, Options2
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status IN (1,3) AND Billing = 3 AND BillingID > 0 
AND dbo.wtfn_DateOnly(PaidDate) <= dbo.wtfn_DateOnly(@BillDate)
-- TESTING
-- AND MemberID = 7238

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
WHILE @@FETCH_STATUS = 0
BEGIN

--	Only process Autoships
	EXEC pts_PB_ValidAutoShip @Options2, @tmpPurpose OUTPUT

	IF @tmpPurpose <> ''
	BEGIN
--		If first payment, Set paid date
		IF @PaidDate = 0 SET @PaidDate = @EnrollDate

--		SET @Total = @Price + @InitPrice
		SET @Total = @Price
		SET @Price = @Total
		SET @Credit = 0
		SET @Cnt = 0
		SET @Notes = ''
		SET @tmpNotes = ''
		SET @tmpDescription = ''
		SET @tmpPurpose = ''
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

		SET @tmpPurpose = @Options2
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
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType, TokenOwner,Token,UserID
		EXEC pts_Payment_Add @PaymentID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
					 @Total, @Total, @Credit, 0, 0, @tmpDescription, @tmpPurpose, @Status, '', @Notes, 1, 0, @TokenType, @TokenOwner, @Token, 1
		SET @Count = @Count + 1

--		Do Payment post processing
		EXEC pts_PB_PaymentPost @PaymentID, @tmpCount OUTPUT

--		Advance paid date to next month
		SET @PaidDate = DATEADD(month,1,@PaidDate)
--		Update member paid date
		UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID
	END
	
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))
GO
