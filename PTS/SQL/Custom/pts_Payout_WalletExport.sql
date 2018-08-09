EXEC [dbo].pts_CheckProc 'pts_Payout_WalletExport'
GO

--EXEC pts_Payout_WalletExport 21, 0, '10/2/16', 0 

CREATE PROCEDURE [dbo].pts_Payout_WalletExport
   @CompanyID int ,
   @PayoutID int ,
   @PayDate datetime ,
   @PayType int
AS

SET NOCOUNT ON

-- Wallet Payouts
IF @PayType IN (0,11,12,13,14)
BEGIN
	SELECT po.PayoutID, ABS(po.Amount) 'Amount', po.PayType, po.Notes + '|' + 
	CAST(me.MemberID AS VARCHAR(10)) + '|' + bi.BillingName + '|' + ISNULL(cou.CountryName,'') + ' - ' + ISNULL(cou.Code,'') + ' ' + bi.State 'Notes'
	FROM Payout AS po
	LEFT OUTER JOIN Member  AS me ON po.OwnerID = me.MemberID
	LEFT OUTER JOIN Billing AS bi ON me.PayID = bi.BillingID
	LEFT OUTER JOIN Country AS cou (NOLOCK) ON (bi.CountryID = cou.CountryID)
	WHERE po.CompanyID = @CompanyID AND po.PayDate <= @PayDate AND po.Status = 4
	AND me.Status >= 1 AND me.Status <= 3 -- AND me.IsIncluded != 0
	AND ( @PayType = 0 OR po.PayType = @PayType)
	AND ( @PayoutID = 0 OR po.PayoutID = @PayoutID)
	ORDER BY po.PayType,  po.Amount DESC
END

-- eCheck Payouts (ACH)
IF @PayType = 2
BEGIN
	SELECT po.PayoutID, po.Amount, po.PayType, po.Notes 
	FROM Payout AS po (NOLOCK)
	WHERE (po.CompanyID = @CompanyID) AND (po.PayType = @PayType) AND (po.PayDate <= @PayDate) AND (po.Status = 4)
	ORDER BY   po.Amount DESC
END

-- Paper Check Payouts
IF @PayType = 3
BEGIN
	SELECT po.PayoutID, po.Amount, po.PayType, po.Notes 
	FROM Payout AS po (NOLOCK)
	WHERE (po.CompanyID = @CompanyID) AND (po.PayType = @PayType) AND (po.PayDate <= @PayDate) AND (po.Status = 4)
	ORDER BY   po.Amount DESC
END

GO
