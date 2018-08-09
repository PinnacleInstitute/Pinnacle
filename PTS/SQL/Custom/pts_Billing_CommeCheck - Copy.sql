EXEC [dbo].pts_CheckProc 'pts_Billing_CommeCheck'
GO

--EXEC pts_Billing_CommeCheck 5, '7/30/12', 10

CREATE PROCEDURE [dbo].pts_Billing_CommeCheck
   @CompanyID int ,
   @CommDate datetime ,
   @Amount money
AS

SET NOCOUNT ON

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

-- Get all Members with Payouts totaling >= $Min.Amount (with status of submitted or forced)
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.CheckBank, bi.CheckRoute, bi.CheckAccount, bi.CheckAcctType, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND (Status=1 OR Status=3) AND PayDate <= @CommDate 
	GROUP BY OwnerID Having SUM(Amount) >= @Amount
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
WHERE bi.CommType = 2 AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2

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
WHERE bi.CommType = 2 AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2

-- Get all Members with Payouts totaling < $Min.Amount that are paid over 1 month in advance
DECLARE @PaidAheadDate datetime
SET @PaidAheadDate = DATEADD(M,1,@CommDate)
INSERT INTO @Payout
SELECT me.MemberID, bi.BillingName, bi.CheckBank, bi.CheckRoute, bi.CheckAccount, bi.CheckAcctType, pa.Amount, LTRIM(STR(pa.Max)) + ' (' + LTRIM(STR(pa.Count)) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND Status=1 AND PayDate <= @CommDate 
	AND OwnerID NOT IN ( SELECT BillingID FROM @Payout )
	GROUP BY OwnerID
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
WHERE bi.CommType = 2 AND me.Status >= 1 AND me.Status <= 3 AND me.Qualify >= 2
AND me.PaidDate > @PaidAheadDate

SELECT BillingID, BillingName, CheckBank, CheckRoute, CheckAccount, CheckAcctType, @CommDate 'CommDate', Amount, Memo FROM @Payout ORDER BY Amount DESC

-- GET The Amounts to pay adjusted for OverDraft Protection holdbacks
--SELECT pa.BillingID, pa.BillingName, pa.CheckBank, pa.CheckRoute, pa.CheckAccount, pa.CheckAcctType, @CommDate 'CommDate', 
--	pa.Amount - CASE me.PromoID WHEN 1 THEN me.Price ELSE 0 END, Memo 
--FROM @Payout AS pa
--JOIN Member AS me ON pa.BillingID = me.MemberID
--WHERE (pa.Amount - CASE me.PromoID WHEN 1 THEN me.Price ELSE 0 END) >= @Amount
--ORDER BY Amount DESC

GO