EXEC [dbo].pts_CheckProc 'pts_Company_BillingPayments'
GO

--DECLARE @Count int
--EXEC pts_Company_BillingPayments 1, 0, @Count OUTPUT
--print @Count

CREATE PROCEDURE [dbo].pts_Company_BillingPayments
   @CompanyID int,
   @BillDate datetime,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @MemberID int, @Price money, @Retail money, @IsMaster bit, @IsDiscount bit, @Discount int
DECLARE @EnrollDate datetime, @TrialDays int, @BillingID int, @InitPrice money, @PaidDate datetime
DECLARE @Total money, @Credit money, @MasterPrice money, @MasterRetail money, @Commission money
DECLARE @Cnt int, @Notes nvarchar(500), @tmpNotes nvarchar(500), @tmpDescription varchar(100)
DECLARE @PayType int, @BillingInfo nvarchar(200)
DECLARE @Now datetime, @PaymentID int, @CreditAmt money, @Status int 

SET @Now = GETDATE()
IF @BillDate = 0 SET @BillDate = @Now
SET @Count = 0

--**********************************************************************************************************
--Process - Bill Members (Billing = 3)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Price, Retail, IsMaster, IsDiscount, Discount, EnrollDate, TrialDays, BillingID, InitPrice, PaidDate
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing = 3 AND BillingID > 0 AND dbo.wtfn_DateOnly(PaidDate) <= dbo.wtfn_DateOnly(@BillDate)
-- TESTING
-- AND MemberID = 17

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @Retail, @IsMaster, @IsDiscount, @Discount, 
				   @EnrollDate, @TrialDays, @BillingID, @InitPrice, @PaidDate
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- If first payment
	IF @PaidDate = 0
	BEGIN
--		-- add initial price to monthly price 
		SET @Price = @InitPrice + @Price
--		-- Set paid date
		SET @PaidDate = DATEADD(day,@TrialDays,@EnrollDate)
	END
	
	SET @Total = @Price
	SET @Credit = 0
	SET @MasterPrice = 0
	SET @MasterRetail = 0
	SET @Cnt = 0
	SET @Notes = ''
	SET @tmpNotes = ''
	SET @tmpDescription = ''

--	Calculate any Master member payments
--	IF @IsMaster > 0 
--	BEGIN
--		EXEC pts_Company_BillingMaster @MemberID, @Cnt OUTPUT, @MasterPrice OUTPUT, @MasterRetail OUTPUT, @tmpNotes OUTPUT
--		SET @Price = @Price + @MasterPrice
--		SET @Retail = @Retail + @MasterRetail
--		SET @Total = @Price
--		SET @Notes = @Notes + @tmpNotes
--		IF @Cnt > 0 SET @tmpDescription = @tmpDescription + 'Billed:[' + CAST(@Cnt AS varchar(10)) + '~' + CAST(@MasterPrice AS varchar(20)) + '] '
--	END

--	Calculate any referral credits
	IF @IsDiscount > 0 AND @Discount > 0
	BEGIN
		EXEC pts_Company_BillingReferral @MemberID, @Cnt OUTPUT, @tmpNotes OUTPUT
		SET @Credit = @Cnt * @Discount
--		Cap the referral credit at the price
		IF @Credit > @Price SET @Credit = @Price
		SET @Price = @Price - @Credit
		SET @Notes = @Notes + @tmpNotes
		IF @Cnt > 0 SET @tmpDescription = @tmpDescription + 'Credit:[' + CAST(@Cnt AS varchar(10)) + '*' + CAST(@Discount AS varchar(10)) + '] '
	END

--	Get Billing Information
	SET @PayType = 0
	SET @BillingInfo = ''
	SELECT @PayType = 
		CASE PayType
		WHEN 1 THEN CardType 
		WHEN 2 THEN 5
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

	SET @tmpDescription = @tmpDescription + 'Charged:[' + @BillingInfo + ']'
	SET @Commission = @Total - @Retail
	SET @Notes = CAST(MONTH(@Now) AS VARCHAR(10)) + '/' + CAST(DAY(@Now) AS VARCHAR(10)) + '/' + CAST(YEAR(@Now) AS VARCHAR(10)) + ' ' + @Notes

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
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID, 0, 4, @MemberID, 0, 0, 0, @PaidDate, 0, @PayType, 
			     @Price, @Total, @Credit, @Retail, @Commission, @tmpDescription, '', @Status, '', @Notes, 1, 0, 0, 0, 0, 1
	SET @Count = @Count + 1

--	Advance paid date to next month
	SET @PaidDate = DATEADD(month,1,@PaidDate)
--	Update member paid date
	UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @Retail, @IsMaster, @IsDiscount, @Discount,
					   @EnrollDate, @TrialDays, @BillingID, @InitPrice, @PaidDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

--**********************************************************************************************************
--Process Bill Company (Billing = 2)
DECLARE @TotalCount int, @MasterCount int, @CreditCount int
DECLARE @TotalPrice money, @TotalMaster money, @TotalCredit money, @TotalRetail money

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Price, Retail, IsMaster, IsDiscount, Discount, EnrollDate, TrialDays, InitPrice, PaidDate
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing = 2 AND dbo.wtfn_DateOnly(PaidDate) <= dbo.wtfn_DateOnly(@BillDate)
-- TESTING
-- AND MemberID = 17

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @Retail, @IsMaster, @IsDiscount, @Discount, 
				   @EnrollDate, @TrialDays, @InitPrice, @PaidDate
SET @TotalCount = 0
SET @TotalPrice = 0
SET @MasterCount = 0
SET @TotalMaster = 0
SET @CreditCount = 0
SET @TotalCredit = 0
SET @TotalRetail = 0
SET @tmpDescription = ''
SET @BillingInfo = ''
SET @PayType = 0
SET @Notes = ''

WHILE @@FETCH_STATUS = 0
BEGIN
--	-- If first payment, add initial price to monthly price 
	IF @PaidDate = 0 SET @Price = @InitPrice + @Price

	SET @TotalCount = @TotalCount + 1
	SET @TotalPrice = @TotalPrice + @Price
	SET @TotalRetail = @TotalRetail + @Retail
	SET @Cnt = 0
	SET @MasterPrice = 0
	SET @MasterRetail = 0

--	Calculate any Master member payments
--	IF @IsMaster > 0 
--	BEGIN
--		EXEC pts_Company_BillingMaster @MemberID, @Cnt OUTPUT, @MasterPrice OUTPUT, @MasterRetail OUTPUT, @tmpNotes OUTPUT
--		SET @MasterCount = @MasterCount + @Cnt
--		SET @TotalMaster = @TotalMaster + @MasterPrice
--		SET @TotalRetail = @TotalRetail + @MasterRetail
--	END

--	Calculate any referral credits
	IF @IsDiscount > 0 AND @Discount > 0
	BEGIN
		EXEC pts_Company_BillingReferral @MemberID, @Cnt OUTPUT, @tmpNotes OUTPUT
		SET @CreditCount = @CreditCount + @Cnt
		SET @TotalCredit = @TotalCredit + (@Cnt * @Discount)
	END

--	Calculate and Update the new paid date, Add one month to PaidDate (OR EnrollDate + TrialDays, if PaidDate = 0)
	UPDATE Member SET PaidDate = 
	CASE WHEN PaidDate = 0 THEN DATEADD(month,1,DATEADD(day,TrialDays,EnrollDate)) ELSE DATEADD(month, 1, PaidDate) END
	WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @Retail, @IsMaster, @IsDiscount, @Discount,
					   @EnrollDate, @TrialDays, @InitPrice, @PaidDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

IF @TotalCount > 0 SET @tmpDescription = 'Billed:[' + CAST(@TotalCount AS varchar(10)) + '~' + CAST(@TotalPrice AS varchar(20)) + '] '
IF @MasterCount > 0 SET @tmpDescription = @tmpDescription + 'Master:[' + CAST(@MasterCount AS varchar(10)) + '~' + CAST(@TotalMaster AS varchar(20)) + '] '
IF @CreditCount > 0 SET @tmpDescription = @tmpDescription + 'Credit:[' + CAST(@CreditCount AS varchar(10)) + '~' + CAST(@TotalCredit AS varchar(20)) + '] '
SET @Total = @TotalPrice
SET @Price = @TotalPrice - @TotalCredit
SET @Credit = @TotalCredit
SET @Retail = @TotalRetail
SET @Commission = @Total - @Retail

SELECT @BillingID = ISNULL(BillingID,0) FROM Company WHERE CompanyID = @CompanyID
IF @BillingID > 0
BEGIN
--	Get Billing Information
	SELECT @PayType = 
		CASE PayType
		WHEN 1 THEN CardType 
		WHEN 2 THEN 5
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

	SET @tmpDescription = @tmpDescription + 'Charged:[' + @BillingInfo + ']'
END

IF @TotalCount > 0 AND ( @Price != 0 OR @Total != 0 OR @Credit != 0 )
BEGIN
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID, 0, 38, @CompanyID, 0, 0, 0, @Now, 0, @PayType, 
			     @Price, @Total, @Credit, @Retail, @Commission, @tmpDescription, '', 1, '', @Notes, 1, 0, 0, 0, 0, 1
	SET @Count = @Count + 1
END
-- TESTING
-- PRINT 'Add Company Payment: ' + CAST(@CompanyID AS varchar(10)) + ', ' +  CAST(@PayType AS varchar(10)) + ', ' +
--	CAST(@Price AS varchar(10)) + ', '  +  CAST(@Total AS varchar(10)) + ', '  +  
--	CAST(@Credit AS varchar(10)) + ', (' + @tmpDescription + '), (' + @Notes + ')'

--**********************************************************************************************************
--Process Bill Company for all other members not yet billed (skip no billing(1) and manual billing(5))
-- e.g. Bill Member (3) with No BillingID
-- e.g. Bill Master (4) with No MasterID
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Price, Retail, IsMaster, IsDiscount, Discount, EnrollDate, TrialDays, InitPrice, PaidDate
FROM Member WHERE CompanyID = @CompanyID AND Price > 0 AND Status = 1 AND Billing != 1 AND Billing != 5 AND dbo.wtfn_DateOnly(PaidDate) <= dbo.wtfn_DateOnly(@BillDate)
-- TESTING
-- AND MemberID = 17

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @Retail, @IsMaster, @IsDiscount, @Discount, 
				   @EnrollDate, @TrialDays, @InitPrice, @PaidDate
SET @TotalCount = 0
SET @TotalPrice = 0
SET @MasterCount = 0
SET @TotalMaster = 0
SET @CreditCount = 0
SET @TotalCredit = 0
SET @TotalRetail = 0
SET @Notes = ''
SET @tmpDescription = ''

WHILE @@FETCH_STATUS = 0
BEGIN
--	-- If first payment, add initial price to monthly price 
	IF @PaidDate = 0 SET @Price = @InitPrice + @Price

	SET @TotalCount = @TotalCount + 1
	SET @TotalPrice = @TotalPrice + @Price
	SET @TotalRetail = @TotalRetail + @Retail
	SET @Notes = @Notes + CAST(@MemberID AS varchar(10)) + ' '
	SET @Cnt = 0
	SET @MasterPrice = 0
	SET @MasterRetail = 0

--	Calculate any Master member payments
--	IF @IsMaster > 0 
--	BEGIN
--		EXEC pts_Company_BillingMaster @MemberID, @Cnt OUTPUT, @MasterPrice OUTPUT, @MasterRetail OUTPUT, @tmpNotes OUTPUT
--		SET @MasterCount = @MasterCount + @Cnt
--		SET @TotalMaster = @TotalMaster + @MasterPrice
--		SET @TotalRetail = @TotalRetail + @MasterRetail
--	END

--	Calculate any referral credits
	IF @IsDiscount > 0 AND @Discount > 0
	BEGIN
		EXEC pts_Company_BillingReferral @MemberID, @Cnt OUTPUT, @tmpNotes OUTPUT
		SET @CreditCount = @CreditCount + @Cnt
		SET @TotalCredit = @TotalCredit + (@Cnt * @Discount)
	END

--	Calculate and Update the new paid date, Add one month to PaidDate (OR EnrollDate + TrialDays, if PaidDate = 0)
	UPDATE Member SET PaidDate = 
	CASE WHEN PaidDate = 0 THEN DATEADD(month,1,DATEADD(day,TrialDays,EnrollDate)) ELSE DATEADD(month, 1, PaidDate) END
	WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @Retail, @IsMaster, @IsDiscount, @Discount,
					   @EnrollDate, @TrialDays, @InitPrice, @PaidDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @tmpDescription = 'UNBILLED MEMBERS: '
IF @TotalCount > 0 SET @Notes = 'Members:[' + @Notes + ']'
IF @TotalCount > 0 SET @tmpDescription = @tmpDescription + 'Billed:[' + CAST(@TotalCount AS varchar(10)) + '~' + CAST(@TotalPrice AS varchar(20)) + '] '
IF @MasterCount > 0 SET @tmpDescription = @tmpDescription + 'Business:[' + CAST(@MasterCount AS varchar(10)) + '~' + CAST(@TotalMaster AS varchar(20)) + '] '
IF @CreditCount > 0 SET @tmpDescription = @tmpDescription + 'Credit:[' + CAST(@CreditCount AS varchar(10)) + '~' + CAST(@TotalCredit AS varchar(20)) + '] '
SET @Total = @TotalPrice + @TotalMaster
SET @Credit = @TotalCredit
SET @Price = @Total - @Credit
SET @Retail = @TotalRetail
SET @Commission = @Total - @Retail

IF @BillingID > 0
	SET @tmpDescription = @tmpDescription + 'Charged:[' + @BillingInfo + ']'

IF @TotalCount > 0 AND ( @Price != 0 OR @Total != 0 OR @Credit != 0 )
BEGIN
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
	EXEC pts_Payment_Add @PaymentID, 0, 38, @CompanyID, 0, 0, 0, @Now, 0, @PayType, 
		     @Price, @Total, @Credit, @Retail, @Commission, @tmpDescription, '', 1, '', @Notes, 1, 0, 0, 0, 0, 1
	SET @Count = @Count + 1
END
-- TESTING
-- PRINT 'Add Company Payment: ' + CAST(@CompanyID AS varchar(10)) + ', ' +  CAST(@PayType AS varchar(10)) + ', ' +
--	CAST(@Price AS varchar(10)) + ', '  +  CAST(@Total AS varchar(10)) + ', '  +  
--	CAST(@Credit AS varchar(10)) + ', (' + @tmpDescription + '), (' + @Notes + ')'

GO
