EXEC [dbo].pts_CheckProc 'pts_Billing_CommeCheck'
GO

--EXEC pts_Billing_CommeCheck 5, '7/30/12', 10

CREATE PROCEDURE [dbo].pts_Billing_CommeCheck
   @CompanyID int ,
   @CommDate datetime ,
   @Amount money
AS
-- **************************************************************************************************
-- Get All Payouts WHERE Payout Total > Min. Amount AND
-- ( Don't Hold AutoShip OR Not Bill Member OR Next BillDate > month OR Payout Total > AutoShip )
-- **************************************************************************************************
SET NOCOUNT ON

DECLARE @HoldAutoShip int, @BillDate datetime
IF @Amount >= 0 SET @HoldAutoShip = 1 ELSE SET @HoldAutoShip = 0 
IF @Amount < 0 SET @Amount = ABS(@Amount)
SET @BillDate = DATEADD(m,1,@CommDate)

DECLARE @Payout TABLE(
   BillingID int ,
   BillingName nvarchar (60),
   CheckBank nvarchar (50),
   CheckRoute nvarchar (9),
   CheckAccount nvarchar (20),
   CheckAcctType int,
   Amount money,
   Memo nvarchar (100)
)

-- Get all Members with Payouts with status of submitted or forced
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.CheckBank, bi.CheckRoute, bi.CheckAccount, bi.CheckAcctType, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
FROM (
	SELECT p2.OwnerID 'OwnerID', me.Billing, me.PaidDate, me.Price, SUM(p2.Amount)'Amount', COUNT(p2.PayoutID)'Count', MAX(p2.PayoutID) 'Max'  
	FROM Payout as p2
	JOIN Member AS me ON p2.OwnerID = me.MemberID
	WHERE p2.CompanyID = @CompanyID AND p2.OwnerType = 4 AND (p2.Status=1 OR p2.Status=3) AND p2.PayDate <= @CommDate
 	GROUP BY p2.OwnerID, me.Billing, me.PaidDate, me.Price 
	Having SUM(p2.Amount) > @Amount AND
	(@HoldAutoShip = 0 OR me.Billing <> 3 OR me.PaidDate > @BillDate OR SUM(p2.Amount) > me.Price)
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
WHERE bi.CommType = 2 AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0

-- Get all Members with forced Payouts that weren't in the first list
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.CheckBank, bi.CheckRoute, bi.CheckAccount, bi.CheckAcctType, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND Status=3 AND PayDate <= @CommDate 
	AND OwnerID NOT IN ( SELECT BillingID FROM @Payout )
	GROUP BY OwnerID
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
WHERE bi.CommType = 2 AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0

SELECT BillingID, BillingName, CheckBank, CheckRoute, CheckAccount, CheckAcctType, @CommDate 'CommDate', Amount, Memo FROM @Payout ORDER BY Amount DESC

-- GET The Amounts to pay adjusted for OverDraft Protection holdbacks
--SELECT pa.BillingID, pa.BillingName, pa.CheckBank, pa.CheckRoute, pa.CheckAccount, pa.CheckAcctType, @CommDate 'CommDate', 
--	pa.Amount - CASE me.PromoID WHEN 1 THEN me.Price ELSE 0 END, Memo 
--FROM @Payout AS pa
--JOIN Member AS me ON pa.BillingID = me.MemberID
--WHERE (pa.Amount - CASE me.PromoID WHEN 1 THEN me.Price ELSE 0 END) >= @Amount
--ORDER BY Amount DESC

GO