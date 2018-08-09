EXEC [dbo].pts_CheckProc 'pts_Bonus_Missing'
GO
-- EXEC pts_Bonus_Missing 582, '12/1/08'

-- Create bonus records for missing members with bonus items
CREATE PROCEDURE [dbo].pts_Bonus_Missing
   @CompanyID int,
   @BonusDate datetime 
AS

SET NOCOUNT ON

DECLARE @ID int, @MemberID int, @Title int, @QV money

-- get all members that have Bonus Items but do not have a bonus record
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT DISTINCT bi.MemberID
FROM BonusItem AS bi
LEFT OUTER JOIN Bonus AS bo ON (bi.MemberID = bo.MemberID AND bo.CompanyID = @CompanyID AND bo.BonusDate = @BonusDate)
WHERE bi.CompanyID = @CompanyID AND bi.MemberBonusID = 0
AND bo.BonusID IS NULL

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- Get this member's title and QV
	SELECT @Title = Title, @QV = QV FROM Member WHERE MemberID = @MemberID
--	-- BonusID,CompanyID,MemberID,BonusDate,Title,BV,QV,Total,PaidDate, Reference, IsPrivate, UserID
	EXEC pts_Bonus_Add @ID, @CompanyID, @MemberID, @BonusDate, @Title, 0, @QV, 0, 0, '', 1, 1 

	FETCH NEXT FROM Member_Cursor INTO @MemberID
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO