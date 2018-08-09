EXEC [dbo].pts_CheckProc 'pts_Legacy_BinaryBonuses'
GO

--declare @Result varchar(1000) EXEC pts_Legacy_BinaryBonuses @Result output print @Result

-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_Legacy_BinaryBonuses
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @Count int
SET @CompanyID = 14

--	Process all affiliates at the bottom of the sponsor3id hierarchy (BV=0)
--	Walk up the binary line and check for binary bonuses
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT Sponsor3ID
FROM Member WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Sponsor3ID > 0 AND BV4 = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Commission_Company_14b @MemberID, 0, '', @Count OUTPUT
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO