EXEC [dbo].pts_CheckProc 'pts_GFTG_SponsorLegs'
GO

--declare @Result varchar(1000) EXEC pts_GFTG_SponsorLegs @Result output print @Result
-- *******************************************************************
-- Recalculate all group sales volumes and promotions
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_GFTG_SponsorLegs
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @Legs int
SET @CompanyID = 13

--	Process all affiliates with a potential of a completed leg
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT SponsorID
FROM Member WHERE CompanyID = @CompanyID AND BV2 >= 3 AND QV2 >= 15

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_GFTG_SetLegs @MemberID, @Legs
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = '1'

GO