EXEC [dbo].pts_CheckProc 'pts_CloudZow_PaymentCredit'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_PaymentCredit @Result output print @Result

CREATE PROCEDURE [dbo].pts_CloudZow_PaymentCredit
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @Count int, @OneMonth datetime, @OneWeek datetime
SET @CompanyID = 5
SET @OneMonth = DATEADD(month,1,GETDATE())
SET @OneWeek = DATEADD(week,1,GETDATE())

-- Check for any members with bill dates within next 30 days
-- AND they have payouts totaling more than payment amount
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID FROM Member AS me
WHERE CompanyID = @CompanyID AND Billing = 3 AND PaidDate <= @OneWeek
AND Status >= 1 AND Status <= 4 AND Level = 1 AND Price > 0
AND MemberID IN (
	SELECT OwnerID FROM Payout
	WHERE CompanyID = @CompanyID AND Status = 1
	GROUP BY OwnerID Having SUM(Amount) >= me.Price
)

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
SET @Count = 0
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Count = @Count + 1
--	Process Payment Credit
	EXEC pts_Payment_CreditPayment @CompanyID, @MemberID
	FETCH NEXT FROM Member_cursor INTO @MemberID
	SET @Result = @Result + 1
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Count AS VARCHAR(10))

GO