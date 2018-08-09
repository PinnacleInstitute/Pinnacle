EXEC [dbo].pts_CheckProc 'pts_Payment_CreditPayment'
GO

CREATE PROCEDURE [dbo].pts_Payment_CreditPayment
   @CompanyID int ,
   @MemberID int 
AS

SET NOCOUNT ON

DECLARE @Now datetime, @PaymentID int, @PayoutID int, @Reference varchar(10), @Notes varchar(10) , @Purpose varchar(100) 
DECLARE @Price money, @InitPrice money, @PaidDate datetime, @TrialDays int, @EnrollDate datetime, @Result int
SET @Now = GETDATE()

SELECT @Price = Price, @InitPrice = InitPrice, @PaidDate = PaidDate, @TrialDays = TrialDays, @EnrollDate = EnrollDate, @Purpose = 'AUTO:' + Options2 
FROM Member WHERE MemberID = @MemberID

--	-- If first payment
IF @PaidDate = 0
BEGIN
--	-- add initial price to monthly price 
	SET @Price = @InitPrice + @Price
--	-- Set paid date
	SET @PaidDate = DATEADD(day,@TrialDays,@EnrollDate)
END

SET @Reference = CAST(MONTH(@PaidDate) AS VARCHAR(10)) + '/' + CAST(DAY(@PaidDate) AS VARCHAR(10)) + '/' + CAST(YEAR(@PaidDate) AS VARCHAR(10))
SET @Notes = CAST(MONTH(@Now) AS VARCHAR(10)) + '/' + CAST(DAY(@Now) AS VARCHAR(10)) + '/' + CAST(YEAR(@Now) AS VARCHAR(10))

-- Create a payment record with payment type "Commission" #90
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate,PayType,
--		Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus, CommDate, TokenType, TokenOwner, Token, UserID
EXEC pts_Payment_Add @PaymentID OUTPUT, 0, 4, @MemberID, 0, 0, 0, @PaidDate, @PaidDate, 90, 
			    @Price, @Price, 0, 0, 0, '', @Purpose, 3, '', @Notes, 1, 0, 0, 0, 0, 1

--	Do Payment post processing
EXEC pts_Company_Custom @CompanyID, 99, 0, @PaymentID, 0, @Result OUTPUT

--	Advance paid date to next month
SET @PaidDate = DATEADD(month,1,@PaidDate)
--	Update member paid date
UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID

SET @Price = @Price * -1
SET @Now = dbo.wtfn_DateOnly(@Now)

--	Create new payout for payment amount debit - status = paid, type = credit, reference = payment #
--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, Show, UserID
EXEC pts_Payout_Add @PayoutID, @CompanyID, 4, @MemberID, @Now, 0, @Price, 1, '', 4, @Reference, 1, 1

GO
