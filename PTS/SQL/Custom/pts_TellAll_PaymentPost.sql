EXEC [dbo].pts_CheckProc 'pts_TellAll_PaymentPost'
GO
--select * from payment where paymentid = 21937
--select * from SalesOrder where salesorderid = 15631
--declare @Result varchar(1000) EXEC pts_TellAll_PaymentPost 23381, @Result output print @Result
--SELECT OwnerType, OwnerID, Status FROM Payment WHERE PaymentID = 19698

CREATE PROCEDURE [dbo].pts_TellAll_PaymentPost
   @PaymentID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @OwnerType int, @OwnerID int, @Status int, @CommStatus int, @Count int, @MemberID int, @SalesOrderID int, @Options2 varchar(40)
DECLARE @Sponsor3ID int, @Today datetime, @PayDate datetime, @Notes varchar(500), @ReferralID int, @Purpose nvarchar (100), @Title int, @newTitle int, @cnt int

SET @Today = dbo.wtfn_DateOnly( GETDATE() )
SET @Count = 0

SELECT @OwnerType = OwnerType, @OwnerID = OwnerID, @Status = [Status], @CommStatus = CommStatus, @PayDate = PayDate, @Notes = Notes, @Purpose = Purpose 
FROM Payment WHERE PaymentID = @PaymentID

-- Process Submitted, Pending, Approved and Declined Payments
IF @Status >= 1 AND @Status <= 4 
BEGIN
--	If the payment is Approved AND not a future payment
	IF @Status = 3 AND @PayDate <= @Today
	BEGIN
--		If the payment is not bonused yet - calc bonuses
		IF @CommStatus = 1 EXEC pts_Commission_Company_17a @PaymentID, @Count OUTPUT
	END
	SET @Result = @Count
END

GO 
