EXEC [dbo].pts_CheckProc 'pts_Nexxus_MemberPayment'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_MemberPayment 37702, @Result output print @Result
--select * from Member where CompanyID = 21 order by MemberID desc

CREATE PROCEDURE [dbo].pts_Nexxus_MemberPayment
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = ''

DECLARE @cnt int, @PaymentID int, @Stat int, @Status int, @AuthUserID int, @Amount money
SET @Stat = 0
SET @PaymentID = 0
SET @Amount = 0.0

-- Stat:  0 = No payment due, 1 = 1st payment due, 2 = addt'l payment due

SELECT TOP 1 @PaymentID = PaymentID, @Status = Status, @Amount = Total FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID ORDER BY PayDate DESC

--Did we find a payment
IF @PaymentID > 0
BEGIN
	IF @Status = 1 
	BEGIN
		SELECT @cnt = COUNT(*) FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID
		IF @cnt = 1 SET @Stat = 1 ELSE SET @Stat = 2
    END    
END

SET @Result = CAST( @Stat AS VARCHAR(2)) + '|' + CAST( @PaymentID AS VARCHAR(10)) + '|' + CAST( @Amount AS VARCHAR(10))

GO

