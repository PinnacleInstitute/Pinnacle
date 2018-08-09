EXEC [dbo].pts_CheckProc 'pts_CloudZow_PayPal'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_PayPal 521, @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_PayPal
   @Quantity int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @MemberID int, @ID int, @Now datetime, @Price money, @PayType int
DECLARE @Reference varchar(10), @cnt int, @PaidDate datetime
SET @MemberID = @Quantity
SET @Now = GETDATE()

SELECT @cnt = COUNT(*) FROM Payment WHERE OwnerID = @MemberID AND Reference = 'GCC'

IF @cnt = 0
BEGIN
	SET @Price = 10
	SET @PayType = 6 
	SET @Reference = 'GCC'
--	Create a payment record with payment type "Commission" #90
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate,PayType,
--		Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus, CommDate, TokenType, TokenOwner, Token, UserID
	EXEC pts_Payment_Add @ID OUTPUT, 0, 4, @MemberID, 0, 0, 0, @Now, @Now, @PayType, 
			    @Price, @Price, 0, 0, 0, '', '', 1, @Reference, '', 3, 0, 0, 0, 0, 1

	SET @Price = 40
--	Create an approved PayPal payment
--	Create Payment Record - PaymentID OUTPUT,CompanyID,OwnerType,OwnerID,BillingID,@ProductID,@PaidID,PayDate,PaidDate, PayType,
--				Amount,Total,Credit,Retail,Commission,Description,Purpose,Status,Reference,Notes,CommStatus,CommDate,TokenType,TokenOwner,Token,UserID
	EXEC pts_Payment_Add @ID, 0, 4, @MemberID, 0, 0, 0, @Now, @Now, @PayType, 
				 @Price, @Price, 0, 0, 0, '', '', 3, '', '', 1, 0, 0, 0, 0, 1

--	Update Billing Date
	SELECT @PaidDate= PaidDate FROM Member WHERE MemberID = @MemberID
	IF @PaidDate = 0 SET @PaidDate = @Now
	SET @PaidDate = DATEADD(m,1,@PaidDate)
	UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @MemberID

	SET @Result = '1'
END

GO