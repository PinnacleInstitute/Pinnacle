EXEC [dbo].pts_CheckProc 'pts_Billing_CommpCheck'
GO

--EXEC pts_Billing_CommpCheck 5, '6/4/12', 10

CREATE PROCEDURE [dbo].pts_Billing_CommpCheck
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
   Street1 nvarchar (60),
   Street2 nvarchar (60),
   City nvarchar (30),
   State nvarchar (30),
   Zip nvarchar (20),
   CountryName nvarchar (50),
   Amount money,
   Memo nvarchar (100)
)

-- Get all Members with Payouts with status of submitted or forced
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.Street1, bi.Street2, bi.City, bi.State, bi.Zip, cou.CountryName, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ') ' + me.Phone1
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
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bi.CountryID = cou.CountryID)
WHERE bi.CommType = 3 AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0

-- Get all Members with forced Payouts that weren't in the first list
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.Street1, bi.Street2, bi.City, bi.State, bi.Zip, cou.CountryName, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ') ' + me.Phone1
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND (Status=3) AND PayDate <= @CommDate 
	AND OwnerID NOT IN ( SELECT BillingID FROM @Payout )
	GROUP BY OwnerID
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bi.CountryID = cou.CountryID)
WHERE bi.CommType = 3 AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0

SELECT BillingID, BillingName, Street1, Street2, City, State, Zip, CountryName, @CommDate 'CommDate', Amount, Memo FROM @Payout ORDER BY Amount DESC

-- GET The Amounts to pay adjusted for OverDraft Protection holdbacks
--SELECT pa.BillingID, pa.BillingName, pa.Street1, pa.Street2, pa.City, pa.State, pa.Zip, pa.CountryName, @CommDate 'CommDate', 
--	pa.Amount - CASE me.PromoID WHEN 1 THEN me.Price ELSE 0 END, Memo 
--FROM @Payout AS pa
--JOIN Member AS me ON pa.BillingID = me.MemberID
--WHERE (pa.Amount - CASE me.PromoID WHEN 1 THEN me.Price ELSE 0 END) >= @Amount
--ORDER BY Amount DESC

GO