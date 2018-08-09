EXEC [dbo].pts_CheckProc 'pts_CloudZow_GCCCredit'
GO

CREATE PROCEDURE [dbo].pts_CloudZow_GCCCredit
   @CompanyID int ,
   @MemberID int 
AS

SET NOCOUNT ON

DECLARE @Now datetime, @PaymentID int, @PayoutID int, @Reference varchar(10), @Notes varchar(10) 
DECLARE @Price money, @InitPrice money, @PaidDate datetime, @TrialDays int, @EnrollDate datetime
SET @Now = GETDATE()
SET @Price = 10
SET @Reference = 'GCC'
SET @Notes = ''

-- Create a payment record with payment type "Commission" #90
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate,PayType,
--		Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus, CommDate, TokenType, TokenOwner, Token, UserID
EXEC pts_Payment_Add @PaymentID OUTPUT, 0, 4, @MemberID, 0, 0, 0, @Now, @Now, 90, 
			    @Price, @Price, 0, 0, 0, '', '', 1, @Reference, '', 3, 0, 0, 0, 0, 1

SET @Price = -10
SET @Now = dbo.wtfn_DateOnly(@Now)

--	Create new payout for payment amount debit - status = paid, type = credit, reference = payment #
--	PayoutID OUTPUT, CompanyID, OwnerType, OwnerID, PayDate, PaidDate, Amount, Status, Notes, PayType, Reference, Show, UserID
EXEC pts_Payout_Add @PayoutID, @CompanyID, 4, @MemberID, @Now, 0, @Price, 1, '', 0, @Reference, 1, 1

GO
