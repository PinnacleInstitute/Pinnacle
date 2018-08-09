EXEC [dbo].pts_CheckProc 'pts_Billing_CommWallet'
GO

--EXEC pts_Billing_CommWallet 17, '12/12/14', -1

CREATE PROCEDURE [dbo].pts_Billing_CommWallet
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
   CardType int ,
   CardName nvarchar (50),
   CountryName nvarchar (100),
   Amount money
)

-- Get all Members with Payouts with status of submitted or forced
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.CardType, bi.CardName, cou.CountryName + ' - ' + cou.Code + ' ' + bi.State, pa.Amount
FROM (
	SELECT p2.OwnerID 'OwnerID', me.Billing, me.PaidDate, me.Price, SUM(p2.Amount)'Amount' 
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
WHERE me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0 AND bi.CommType = 4 AND bi.CardName <> ''

-- Get all Members with forced Payouts that weren't in the first list
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.CardType, bi.CardName, cou.CountryName + ' - ' + cou.Code + ' ' + bi.State, pa.Amount
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND Status=3 AND PayDate <= @CommDate 
	AND OwnerID NOT IN ( SELECT BillingID FROM @Payout )
	GROUP BY OwnerID
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bi.CountryID = cou.CountryID)
WHERE bi.CommType = 4 AND bi.CardName <> '' AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0

SELECT BillingID, BillingName, CardType, CardName, CountryName, Amount FROM @Payout ORDER BY Amount DESC

GO