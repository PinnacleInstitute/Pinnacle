EXEC [dbo].pts_CheckProc 'pts_Pinnacle_PaymentCredit'
GO

--declare @Result varchar(1000) EXEC pts_Pinnacle_PaymentCredit 9, @Result output print @Result

CREATE PROCEDURE [dbo].pts_Pinnacle_PaymentCredit
   @CompanyID int ,
   @Days int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @MemberID int, @Count int, @ToDate datetime
If @Days = 0 SET @Days = 7
SET @ToDate = DATEADD(day,@Days,GETDATE())

-- Check for any members with bill dates within next week
-- AND they have payouts totaling more than payment amount
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID FROM Member AS me
WHERE CompanyID = @CompanyID AND Billing = 3 AND PaidDate <= @ToDate
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