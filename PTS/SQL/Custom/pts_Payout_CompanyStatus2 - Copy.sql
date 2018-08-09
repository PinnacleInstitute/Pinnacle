EXEC [dbo].pts_CheckProc 'pts_Payout_CompanyStatus2'
GO

--DECLARE @Count int
--EXEC pts_Payout_CompanyStatus2 2, '9/10/10', '9/1/10', @Count OUTPUT
--PRINT @Count
--
--select top 7 * from payout order by payoutid desc
--update payout set status = 1 where payoutid >= 940

CREATE PROCEDURE [dbo].pts_Payout_CompanyStatus2
   @CompanyID int ,
   @PayDate datetime ,
   @PaidDate datetime ,
   @Amount money ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SET @Count = 0

-- Process all payouts that total over the amount specific for each member
-- or are forced payments or are for members that are already paid in advance
DECLARE @PaidAheadDate datetime
SET @PaidAheadDate = DATEADD(M,1,@PayDate)

-- Mark all eChecks Payouts Paid ********************************************
UPDATE pa SET Status = 2, PaidDate = @PaidDate, PayType = 2 
FROM Payout AS pa
JOIN Member AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID 
WHERE ( pa.OwnerID IN (
	SELECT OwnerID FROM Payout
	WHERE CompanyID = @CompanyID AND (Status=1 OR Status=3) AND PayDate <= @PayDate
	GROUP BY OwnerID Having SUM(Amount) >= @Amount
) OR pa.Status = 3 OR me.PaidDate > @PaidAheadDate )
AND (pa.Status=1 OR pa.Status=3) AND PayDate <= @PayDate AND bi.CommType = 2 
AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2

-- Mark all pChecks Payouts Paid ********************************************
UPDATE pa SET Status = 2, PaidDate = @PaidDate, PayType = 3
FROM Payout AS pa
JOIN Member AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID 
WHERE ( pa.OwnerID IN (
	SELECT OwnerID FROM Payout
	WHERE CompanyID = @CompanyID AND (Status=1 OR Status=3) AND PayDate <= @PayDate
	GROUP BY OwnerID Having SUM(Amount) >= @Amount
) OR pa.Status = 3 OR me.PaidDate > @PaidAheadDate )
AND (pa.Status=1 OR pa.Status=3) AND PayDate <= @PayDate AND bi.CommType = 3 
AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2


-- RETURN the number of marked payouts with the specified date
SELECT @Count = @Count + COUNT(PayoutID) FROM Payout WHERE PaidDate = @PaidDate

GO
