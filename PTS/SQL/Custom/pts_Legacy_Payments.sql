EXEC [dbo].pts_CheckProc 'pts_Legacy_Payments'
GO

--DECLARE @Count varchar(1000) EXEC pts_Legacy_Payments 0, @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_Legacy_Payments
   @BillDate datetime,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 14

DECLARE @Count int
DECLARE @MemberID int, @Price money, @InitPrice money, @Token int, @TokenType int, @TokenOwner int
DECLARE @EnrollDate datetime, @BillingID int, @PaidDate datetime, @Options2 varchar(40)
DECLARE @Total money, @Credit money
DECLARE @cnt int, @Notes nvarchar(500), @tmpNotes nvarchar(500), @tmpDescription varchar(200), @tmpPurpose varchar(100)
DECLARE @PayType int, @BillingInfo nvarchar(200), @tmpCode varchar(10), @months int
DECLARE @Now datetime, @PaymentID int, @CreditAmt money, @Status int, @ProductID int, @Binary int, @tmpCount int 
DECLARE @SalesOrderID int, @SalesTotal money

SET @Now = GETDATE()
IF @BillDate = 0 SET @BillDate = @Now
SET @Count = 0

--**********************************************************************************************************
--Process - Bill Members (Billing = 3)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Price, InitPrice, EnrollDate, BillingID, PaidDate, Options2
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing = 3 AND BillingID > 0 
AND dbo.wtfn_DateOnly(PaidDate) <= dbo.wtfn_DateOnly(@BillDate)
-- TESTING
-- AND MemberID = 7238

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @tmpPurpose = ''
--	If we have an old autoship date, set it current
	IF @PaidDate < DATEADD(day,-90,@Now) SET @PaidDate = @Now

--	Only process Autoships
	EXEC pts_Legacy_ValidAutoShip @Options2, @tmpPurpose OUTPUT

--	Set # of months for autoship payment
	SET @months = 1
	IF CHARINDEX(@tmpPurpose, '114,116,118,120,121') > 0  SET @months = 3
		 
	IF @tmpPurpose <> ''
	BEGIN
--		--Apend Business Builder Codes to purpose		
		IF CHARINDEX('122', @Options2) > 0 SET @tmpPurpose = @tmpPurpose + ',122'
		IF CHARINDEX('123', @Options2) > 0 SET @tmpPurpose = @tmpPurpose + ',123'
	
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
--		SET @CreditAmt = 0
--		EXEC pts_Payment_Credit @CompanyID, @MemberID, @Price, @CreditAmt OUTPUT 
--		IF @CreditAmt > 0
--		BEGIN
--			SET @Credit = @Credit + @CreditAmt
--			SET @Price = @Price - @CreditAmt	
--		END

		SET @Status = 1
--		If there is no price to bill for this payment, mark it approved.
		IF @Price = 0 SET @Status = 3

--		Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--		Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType, TokenOwner,Token,UserID
		EXEC pts_Payment_Add @PaymentID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
					 @Total, @Total, @Credit, 0, 0, @tmpDescription, @tmpPurpose, @Status, '', @Notes, 1, 0, @TokenType, @TokenOwner, @Token, 1
		SET @Count = @Count + 1

--		Do Payment post processing
		EXEC pts_Legacy_PaymentPost @PaymentID, @tmpCount OUTPUT

--		Double Check Member Autoship Price with Sales Order Total
		SET @SalesOrderID = 0
		SELECT @SalesOrderID = OwnerID FROM Payment WHERE PaymentID = @PaymentID
		IF @SalesOrderID > 0
		BEGIN
			SELECT @SalesTotal = Total FROM SalesOrder WHERE SalesOrderID = @SalesOrderID
			IF @SalesTotal <> @Price
			BEGIN
				UPDATE Payment SET Amount = @SalesTotal, Total = @SalesTotal WHERE PaymentID = @PaymentID 
				UPDATE Member SET Price = @SalesTotal WHERE MemberID = @MemberID
			END
		END
		
--		Advance paid date to next bill date
		SET @PaidDate = DATEADD(month,@months,@PaidDate)
--		Update member paid date
		UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID
	END

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))

GO
