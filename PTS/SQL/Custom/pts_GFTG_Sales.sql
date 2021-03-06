EXEC [dbo].pts_CheckProc 'pts_GFTG_Sales'
GO

--declare @Result varchar(1000) EXEC pts_GFTG_Sales @Result output print @Result
-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_GFTG_Sales
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @MaxTitle int
SET @CompanyID = 13

--	Clear personal volume(BV), group volume(QV) and max title for all active affiliates
UPDATE Member SET BV = 0, QV = 0, MaxMembers = Title 
WHERE CompanyID = @CompanyID 
--AND Status >= 1 AND Status <= 4

--	Set the Personal Referrals (active affiliates) (store in BV) 
UPDATE me 
SET BV = (SELECT COUNT(MemberID) FROM Member WHERE ReferralID = me.MemberID AND Status >= 1 AND Status <= 4 AND Title >= 1)
FROM Member AS me WHERE me.CompanyID = @CompanyID AND Status >= 1 AND me.Status <= 4

--	Process all affiliates at the bottom of the enroller hierarchy (BV=0)
--	Walk up the referral line and store the Group Totals for each member in QV and the highest title in MaxMembers
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT ReferralID, Title
FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Title >= 1 AND BV = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @MaxTitle
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_GFTG_SetTotals @MemberID, 1, 1, @MaxTitle, @Result output
	FETCH NEXT FROM Member_cursor INTO @MemberID, @MaxTitle
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO