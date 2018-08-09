EXEC [dbo].pts_CheckProc 'pts_ZaZZed_BinaryBonuses'
GO

--declare @Result varchar(1000) EXEC pts_ZaZZed_BinaryBonuses @Result output print @Result

-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_ZaZZed_BinaryBonuses
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @Count int
SET @CompanyID = 9

--	Process all affiliates at the bottom of the sponsor3id hierarchy (BV=0)
--	Walk up the binary line and check for binary bonuses
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT Sponsor3ID
FROM Member WHERE CompanyID = 9 AND Status >= 1 AND Status <= 4 AND Sponsor3ID > 0 AND BV4 = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Commission_Company_9b @MemberID, 0, '', @Count OUTPUT
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO