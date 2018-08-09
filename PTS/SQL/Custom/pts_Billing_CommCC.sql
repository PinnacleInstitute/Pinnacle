EXEC [dbo].pts_CheckProc 'pts_Billing_CommCC'
GO

CREATE PROCEDURE [dbo].pts_Billing_CommCC
   @CompanyID int ,
   @CommDate datetime ,
   @Amount money
AS

SET NOCOUNT ON

DECLARE @Payout TABLE(
   BillingID int ,
   CardType int ,
   CardNumber nvarchar (30),
   CardMo int ,
   CardYr int ,
   CardName nvarchar (50),
   CardCode nvarchar (10),
   Amount money,
   Memo nvarchar (100)
)

INSERT INTO @Payout
SELECT me.MemberID, bi.CardType, bi.CardNumber, bi.CardMo, bi.CardYr, bi.CardName, bi.CardCode, pa.Amount, STR(pa.Max) + ' (' + STR(pa.Count) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND (Status=1 OR Status=3) AND PayDate <= @CommDate 
	GROUP BY OwnerID Having SUM(Amount) >= @Amount
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
WHERE bi.CommType = 1 AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0

INSERT INTO @Payout
SELECT me.MemberID, bi.CardType, bi.CardNumber, bi.CardMo, bi.CardYr, bi.CardName, bi.CardCode, pa.Amount, STR(pa.Max) + ' (' + STR(pa.Count) + ')'
FROM (
	SELECT OwnerID 'OwnerID', SUM(Amount)'Amount', COUNT(PayoutID)'Count', MAX(PayoutID) 'Max' 
	FROM Payout
	WHERE CompanyID = @CompanyID AND OwnerType = 4 AND Status=3 AND PayDate <= @CommDate 
	AND OwnerID NOT IN ( SELECT BillingID FROM @Payout )
	GROUP BY OwnerID
) AS pa
JOIN Member  AS me ON pa.OwnerID = me.MemberID
JOIN Billing AS bi ON me.PayID = bi.BillingID
WHERE bi.CommType = 1 AND me.Status >= 1 AND me.Status <= 3 AND me.IsIncluded != 0


SELECT BillingID, CardType, CardNumber, CardMo, CardYr, CardName, CardCode, @CommDate 'CommDate', Amount, Memo FROM @Payout ORDER BY Amount DESC

GO