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
   @Reference varchar(30) ,
   @Count int OUTPUT
AS
-- **************************************************************************************************
-- Mark Paid All Payouts WHERE Payout Total > Min. Amount AND
-- ( Don't Hold AutoShip OR Not Bill Member OR Next BillDate > month OR Payout Total > AutoShip )
-- **************************************************************************************************
SET NOCOUNT ON

DECLARE @HoldAutoShip int, @BillDate datetime
IF @Amount >= 0 SET @HoldAutoShip = 1 ELSE SET @HoldAutoShip = 0 
IF @Amount < 0 SET @Amount = ABS(@Amount)
SET @BillDate = DATEADD(m,1,@PayDate)

SET @Count = 0

-- Process all payouts that total over the amount specific for each member
-- or are forced payments

-- Mark all eChecks Payouts Paid ********************************************
IF CHARINDEX('1', @Reference) > 0
BEGIN
	UPDATE pa SET Status = 2, PaidDate = @PaidDate, PayType = 2 
	FROM Payout AS pa
	JOIN Member AS me ON pa.OwnerID = me.MemberID
	JOIN Billing AS bi ON me.PayID = bi.BillingID 
	WHERE ( pa.OwnerID IN (
		SELECT p1.OwnerID FROM (
			SELECT p2.OwnerID, me.Billing, me.PaidDate, me.Price
			FROM Payout AS p2
			JOIN Member AS me ON p2.OwnerID = me.MemberID
			WHERE p2.CompanyID = @CompanyID AND p2.OwnerType = 4 AND (p2.Status=1 OR p2.Status=3) AND p2.PayDate <= @PayDate
			GROUP BY p2.OwnerID, me.Billing, me.PaidDate, me.Price 
			Having SUM(p2.Amount) > @Amount AND
			(@HoldAutoShip = 0 OR me.Billing <> 3 OR me.PaidDate > @BillDate OR SUM(p2.Amount) > me.Price)
		) AS p1
	) OR pa.Status = 3 )
	AND (pa.Status=1 OR pa.Status=3) AND pa.PayDate <= @PayDate
	AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0
	AND bi.CommType = 2 
END
-- Mark all pChecks Payouts Paid ********************************************
IF CHARINDEX('2', @Reference) > 0
BEGIN
	UPDATE pa SET Status = 2, PaidDate = @PaidDate, PayType = 3
	FROM Payout AS pa
	JOIN Member AS me ON pa.OwnerID = me.MemberID
	JOIN Billing AS bi ON me.PayID = bi.BillingID 
	WHERE ( pa.OwnerID IN (
		SELECT p1.OwnerID FROM (
			SELECT p2.OwnerID, me.Billing, me.PaidDate, me.Price
			FROM Payout AS p2
			JOIN Member AS me ON p2.OwnerID = me.MemberID
			WHERE p2.CompanyID = @CompanyID AND p2.OwnerType = 4 AND (p2.Status=1 OR p2.Status=3) AND p2.PayDate <= @PayDate
			GROUP BY p2.OwnerID, me.Billing, me.PaidDate, me.Price 
			Having SUM(p2.Amount) > @Amount AND
			(@HoldAutoShip = 0 OR me.Billing <> 3 OR me.PaidDate > @BillDate OR SUM(p2.Amount) > me.Price)
		) AS p1
	) OR pa.Status = 3 )
	AND (pa.Status=1 OR pa.Status=3) AND pa.PayDate <= @PayDate
	AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0
	AND bi.CommType = 3 
END

-- Mark all eWallet Payouts Paid ********************************************
IF CHARINDEX('3', @Reference) > 0
BEGIN
	UPDATE pa SET Status = 2, PaidDate = @PaidDate, PayType = 6
	FROM Payout AS pa
	JOIN Member AS me ON pa.OwnerID = me.MemberID
	JOIN Billing AS bi ON me.PayID = bi.BillingID 
	WHERE ( pa.OwnerID IN (
		SELECT p1.OwnerID FROM (
			SELECT p2.OwnerID, me.Billing, me.PaidDate, me.Price
			FROM Payout AS p2
			JOIN Member AS me ON p2.OwnerID = me.MemberID
			WHERE p2.CompanyID = @CompanyID AND p2.OwnerType = 4 AND (p2.Status=1 OR p2.Status=3) AND p2.PayDate <= @PayDate
			GROUP BY p2.OwnerID, me.Billing, me.PaidDate, me.Price 
			Having SUM(p2.Amount) > @Amount AND
			(@HoldAutoShip = 0 OR me.Billing <> 3 OR me.PaidDate > @BillDate OR SUM(p2.Amount) > me.Price)
		) AS p1
	) OR pa.Status = 3 )
	AND (pa.Status=1 OR pa.Status=3) AND pa.PayDate <= @PayDate
	AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0
	AND bi.CommType = 4 AND bi.CardName <> '' 
END

-- RETURN the number of marked payouts with the specified date
SELECT @Count = @Count + COUNT(PayoutID) FROM Payout WHERE CompanyID = @CompanyID AND PaidDate = @PaidDate

GO
