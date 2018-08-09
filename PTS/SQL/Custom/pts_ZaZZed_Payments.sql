EXEC [dbo].pts_CheckProc 'pts_ZaZZed_Payments'
GO

--DECLARE @Count varchar(1000) EXEC pts_ZaZZed_Payments 0, @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_ZaZZed_Payments
   @BillDate datetime,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 9

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
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing = 3 AND BillingID > 0 
AND dbo.wtfn_DateOnly(PaidDate) <= dbo.wtfn_DateOnly(@BillDate)
-- TESTING
-- AND MemberID = 7238

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
WHILE @@FETCH_STATUS = 0
BEGIN

--	Check for valid Autoship products (code=101,102,116,303,213)	
	IF CHARINDEX('101', @Options2) = 0 AND CHARINDEX('102', @Options2) = 0 AND CHARINDEX('116', @Options2) = 0 AND CHARINDEX('303', @Options2) = 0 AND CHARINDEX('213', @Options2) = 0 Set @Price = 0

--  If Diamond Pak
	IF CHARINDEX('115', @Options2) > 0
	BEGIN
--		If first time Diamond don't charge monthly price otherwise remove one-time Diamond Pack from processing
		IF @PaidDate = 0 
		BEGIN
			SET @Price = 0
		END	
		ELSE
		BEGIN
			SET @Options2 = REPLACE(@Options2, '115', '')
			SET @InitPrice = 0
		END	
	END	
	
--	Check if Wealth Builder needs to be re-purchased (6 months)
	IF CHARINDEX('201', @Options2) > 0 
	BEGIN
		-- Look back 6 months for a wealth bulder order
		SET @ProductID = 59
		SELECT @cnt = COUNT(SalesItemID) FROM SalesItem AS si JOIN SalesOrder AS so ON si.SalesOrderID = so.SalesOrderID 
		WHERE so.MemberID = @MemberID AND si.ProductID = @ProductID AND so.OrderDate >= DATEADD(wk,-25,@Now)
		-- If found an order, don't charge for wealth bulder 
		IF @cnt > 0
		BEGIN
			SET @Options2 = REPLACE(@Options2, '201', '')
			SET @InitPrice = 0
		END	
	END
	
--	-- If first payment, Set paid date
	IF @PaidDate = 0 SET @PaidDate = @EnrollDate

	SET @Total = @Price + @InitPrice
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

--	Get Billing Information
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

--  Check for other credits to be applied to this payment
	SET @CreditAmt = 0
	EXEC pts_Payment_Credit @CompanyID, @MemberID, @Price, @CreditAmt OUTPUT 
	IF @CreditAmt > 0
	BEGIN
		SET @Credit = @Credit + @CreditAmt
		SET @Price = @Price - @CreditAmt	
	END

	SET @Status = 1
--  If there is no price to bill for this payment, mark it approved.
	IF @Price = 0 SET @Status = 3

--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType, TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID OUTPUT, @CompanyID, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
			     @Total, @Total, @Credit, 0, 0, @tmpDescription, @tmpPurpose, @Status, '', @Notes, 1, 0, @TokenType, @TokenOwner, @Token, 1
	SET @Count = @Count + 1

--	Do Payment post processing
	EXEC pts_ZaZZed_PaymentPost @PaymentID, @tmpCount OUTPUT

--	Advance paid date to next month
	SET @PaidDate = DATEADD(month,1,@PaidDate)
--	Update member paid date
	UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))
GO
