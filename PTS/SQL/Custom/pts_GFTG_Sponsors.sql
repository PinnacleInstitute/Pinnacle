EXEC [dbo].pts_CheckProc 'pts_GFTG_Sponsors'
GO

--declare @Result varchar(1000) EXEC pts_GFTG_Sponsors @Result output print @Result
-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_GFTG_Sponsors
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @MaxTitle int
SET @CompanyID = 13

--	Clear personal volume(BV), group volume(QV) and max title for all active affiliates
UPDATE Member SET BV2 = 0, QV2 = 0
WHERE CompanyID = @CompanyID 

--	Set the Personal Referrals (active affiliates) (store in BV) 
UPDATE me 
SET BV2 = (SELECT COUNT(MemberID) FROM Member WHERE SponsorID = me.MemberID AND Status >= 1 AND Status <= 4)
FROM Member AS me WHERE me.CompanyID = @CompanyID AND Status >= 1 AND me.Status <= 4

--	Process all affiliates at the bottom of the sponsor hierarchy (BV2=0)
--	Walk up the sponsor line and store the Group Totals for each member in QV2
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT SponsorID
FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV2 = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_GFTG_SetSponsorTotals @MemberID, 1, 1, @Result output
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO