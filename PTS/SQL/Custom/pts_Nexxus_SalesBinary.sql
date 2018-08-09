EXEC [dbo].pts_CheckProc 'pts_Nexxus_SalesBinary'
GO

--declare @Result varchar(1000) EXEC pts_Nexxus_SalesBinary @Result output print @Result
--select memberid, namefirst, namelast, pos, sponsor3id from Member where sponsor3ID in( 14694,14700 )

-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_Nexxus_SalesBinary
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int
SET @CompanyID = 21

--	Clear binary downline count
UPDATE Member SET BV3=0, BV4=0 
WHERE CompanyID = @CompanyID AND Sponsor3ID > 0
--AND Status >= 1 AND Status <= 4
 
--	Set the Placed members (active affiliates) (store in BV4) 
UPDATE me 
--SET BV4 = (SELECT COUNT(MemberID) FROM Member WHERE Sponsor3ID = me.MemberID AND Status >= 1 AND Status <= 4)
SET BV4 = (SELECT COUNT(MemberID) FROM Member WHERE Sponsor3ID = me.MemberID AND Status > 0)
FROM Member AS me WHERE me.CompanyID = @CompanyID AND Sponsor3ID > 0 AND Status > 0
--AND Status >= 1 AND me.Status <= 4

--	Process all affiliates at the bottom of the sponsor3id hierarchy (BV=0)
--	Walk up the binary line and store the Group Totals for each member in BV4
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT Sponsor3ID
FROM Member WHERE CompanyID = @CompanyID AND Sponsor3ID > 0 AND BV4 = 0
--AND Status >= 1 AND Status <= 4 

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Nexxus_SetTotalBinary @MemberID, 0, @Result output
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO