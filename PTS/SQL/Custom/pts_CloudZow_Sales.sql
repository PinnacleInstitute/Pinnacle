EXEC [dbo].pts_CheckProc 'pts_CloudZow_Sales'
GO

--declare @Result varchar(1000) EXEC pts_CloudZow_Sales @Result output print @Result
-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_CloudZow_Sales
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @SponsorID int, @Title int, @cnt int, @Count int
DECLARE @Total int, @MaxTitle int, @BV money, @QV money, @BV4 money 
SET @Count = 0
SET @CompanyID = 5

--	Clear personal volume(BV), group volume(QV) and max title for all active affiliates
UPDATE Member SET BV = 0, QV = 0, BV2 = 0, QV2 = 0, BV3 = 0, BV4 = 0, MaxMembers = Title 
WHERE CompanyID = @CompanyID AND [Level] = 1 
--AND Status >= 1 AND Status <= 4

--	Set the Personal Sales Volume (personal use + retail sales) (store in BV) 
--	and the number of 1st level affiliates for each member (store in BV3)
UPDATE me 
	SET BV = Price + (SELECT ISNULL(SUM(Price),0) FROM Member WHERE ReferralID = me.MemberID AND [Level] = 0 AND Status = 1),
		BV2 = Price + (SELECT ISNULL(SUM(Price),0) FROM Member WHERE ReferralID = me.MemberID AND [Level] = 0 AND Status = 1),
		BV3 = (SELECT COUNT(*)   FROM Member WHERE SponsorID = me.MemberID AND [Level] = 1 AND Status >= 1 AND Status <= 4)
FROM Member AS me WHERE me.CompanyID = @CompanyID AND [Level] = 1 AND me.Status >= 1 AND me.Status <= 4

--	Process all affiliates at the bottom of the enroller hierarchy (BV3=0 they have no recruits)
--	Walk up the sponsor line and store the Group Sales Volume for each member in QV and the highest title in MaxMembers
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT SponsorID, BV, Title
FROM Member WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 4 AND BV3 = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Total, @MaxTitle
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @cnt = 1
--	SET @MaxTitle = 1
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = -1
--		--Get the current Affiliate's sponsor, personal volume, group volume, downline count, title
		SELECT @SponsorID = SponsorID, @BV = BV, @QV = QV, @BV4 = BV4, @Title = MaxMembers FROM Member WHERE MemberID = @MemberID
--		--TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			--Check for highest title
			IF @Title > @MaxTitle SET @MaxTitle = @Title

--			--Update the group volume, highest title for the current affiliate, and number of downline members(BV4)
			UPDATE Member SET QV = QV + @Total, QV2 = QV + @Total, BV2 = BV, BV4 = BV4 + @cnt, MaxMembers = @MaxTitle WHERE MemberID = @MemberID

			IF @BV4 = 0
			BEGIN
				SET @Total = @Total + @BV
				SET @cnt = @cnt + 1
			END	
			
--			-- check for advancement for this affiliate
			EXEC pts_Commission_CalcAdvancement_5 @MemberID, 0, @Count OUTPUT

			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Total, @MaxTitle
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO