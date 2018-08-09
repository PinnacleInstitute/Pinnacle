EXEC [dbo].pts_CheckProc 'pts_Billing_CommpCheck'
GO

--EXEC pts_Billing_CommpCheck 5, '5/8/12', 40

CREATE PROCEDURE [dbo].pts_Billing_CommpCheck
   @CompanyID int ,
   @CommDate datetime ,
   @Amount money
AS

SET NOCOUNT ON

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

-- Get all Members with Payouts totaling >= $40 (with status of submitted or forced)
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.Street1, bi.Street2, bi.City, bi.State, bi.Zip, cou.CountryName, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND (Status=1 OR Status=3) AND PayDate <= @CommDate 
	GROUP BY OwnerID Having SUM(Amount) >= @Amount
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bi.CountryID = cou.CountryID)
WHERE bi.CommType = 3 AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2

-- Get all Members with forced Payouts that weren't in the first list
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.Street1, bi.Street2, bi.City, bi.State, bi.Zip, cou.CountryName, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
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
WHERE bi.CommType = 3 AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2

-- Get all Members with Payouts totaling < $40 that are paid over 1 month in advance
DECLARE @PaidAheadDate datetime
SET @PaidAheadDate = DATEADD(M,1,@CommDate)
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.Street1, bi.Street2, bi.City, bi.State, bi.Zip, cou.CountryName, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND Status=1 AND PayDate <= @CommDate 
	AND OwnerID NOT IN ( SELECT BillingID FROM @Payout )
	GROUP BY OwnerID
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bi.CountryID = cou.CountryID)
WHERE bi.CommType = 3 AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2
AND me.PaidDate > @PaidAheadDate


SELECT BillingID, BillingName, Street1, Street2, City, State, Zip, CountryName, @CommDate 'CommDate', Amount, Memo FROM @Payout ORDER BY Amount DESC

GO