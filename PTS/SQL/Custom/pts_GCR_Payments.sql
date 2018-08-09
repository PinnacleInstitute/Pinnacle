EXEC [dbo].pts_CheckProc 'pts_GCR_Payments'
GO

--DECLARE @Count varchar(1000) EXEC pts_GCR_Payments 0, @Count OUTPUT print @Count

CREATE PROCEDURE [dbo].pts_GCR_Payments
   @BillDate datetime,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int
SET @CompanyID = 17

DECLARE @Count int, @Cnt int, @Now datetime 
DECLARE @MemberID int, @Price money, @InitPrice money, @EnrollDate datetime, @BillingID int, @PaidDate datetime, @Options2 varchar(40)

SET @Now = GETDATE()
--Bill 1 week in advance
SET @BillDate = DATEADD(d,3,@Now)
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
	EXEC pts_GCR_PaymentMember @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2, @Cnt OUTPUT
	IF @Cnt = 1 SET @Count = @Count + 1

	FETCH NEXT FROM Member_cursor INTO @MemberID, @Price, @InitPrice, @EnrollDate, @BillingID, @PaidDate, @Options2
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))

GO
