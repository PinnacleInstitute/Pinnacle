EXEC [dbo].pts_CheckProc 'pts_Nexxus_Sales'
GO

-- EXEC pts_Nexxus_Sales
--select bv, bv2 from Member where MemberID = 38388

-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_Nexxus_Sales
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @MemberID int, @cnt int, @SalesDate datetime, @BV2 money, @Result varchar(100)

SET @CompanyID = 21

--	Clear personal volume(BV), group volume(QV), personal sales (BV2), group sales (QV2)
UPDATE Member SET BV = 0, QV = 0, BV2 = 0, QV2 = 0 
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4

-- Set the Personal Referrals (active affiliates) (store in BV) 
-- Set the Personal Sales (personal and customer purchases) (store in BV2) 
SET @SalesDate = DATEADD( day, -31, GETDATE())
UPDATE me 
SET BV = (SELECT COUNT(MemberID) FROM Member WHERE ReferralID = me.MemberID AND Status = 1),
BV2 = ( SELECT ISNULL(SUM(Amount),0) FROM Payment WHERE OwnerType = 4 AND OwnerID = me.MemberID AND Status = 3 AND PaidDate > @SalesDate ) +
(	
SELECT ISNULL(SUM(
CASE 
WHEN Amount <=  5.50 THEN 2
WHEN Amount <= 16.00 THEN 10
WHEN Amount <= 42.00 THEN 25
WHEN Amount <= 78.00 THEN 50
ELSE 0
END
),0) FROM Payment AS pa JOIN Member AS m2 ON pa.OwnerType = 4 AND pa.OwnerID = m2.MemberID
	WHERE m2.ReferralID = me.MemberID AND m2.Title = 1 AND m2.Status = 3 AND pa.Status = 3 AND pa.PaidDate > @SalesDate
)
FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Status <= 4

--	Process all affiliates at the bottom of the enroller hierarchy (BV=0)
--	Walk up the referral line and store the Group Totals for each member in QV and the highest title in MaxMembers
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT ReferralID, BV2
FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @BV2
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Nexxus_SetTotalCount @MemberID, 1, 1, @Result output
	EXEC pts_Nexxus_SetTotalSales @MemberID, @BV2, 1, @Result output
	FETCH NEXT FROM Member_cursor INTO @MemberID, @BV2
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO