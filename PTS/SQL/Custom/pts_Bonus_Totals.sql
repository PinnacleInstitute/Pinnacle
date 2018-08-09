EXEC [dbo].pts_CheckProc 'pts_Bonus_Totals'
GO
-- EXEC pts_Bonus_Totals 582, '11/1/08'

-- Copy bonus totals to each member's bonus record
CREATE PROCEDURE [dbo].pts_Bonus_Totals
   @CompanyID int,
   @BonusDate datetime 
AS

SET NOCOUNT ON

DECLARE @ID int, @MemberID int, @BV money, @BonusID int

-- get the total of all bonus items amounts for each member
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SUM(Amount)
FROM BonusItem
WHERE CompanyID = @CompanyID AND MemberBonusID = 0
GROUP BY MemberID

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- Get the bonus record for this member and this bonus date
	SELECT @BonusID = BonusID FROM Bonus WHERE MemberID = @MemberID AND BonusDate = @BonusDate 
	IF @BonusID > 0
	BEGIN
--		-- Update the bonus total for this member
		UPDATE Bonus SET Total = @BV WHERE BonusID = @BonusID
--		-- Update the MemberBonusID for all bonus items belonging to this member
		UPDATE BonusItem SET MemberBonusID = @BonusID 
		WHERE CompanyID = @CompanyID AND MemberBonusID = 0 AND MemberID = @MemberID 
	END
	ELSE
		print 'BAD MemberID: ' + cast(@MemberID as varchar(10))

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO

