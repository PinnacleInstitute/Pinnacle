EXEC [dbo].pts_CheckProc 'pts_Bonus_582_8'
GO
--EXEC pts_Bonus_582_8 582, 471849

-- Calculate All Star Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_8
   @CompanyID int,
   @TotalPoints money 
AS

SET NOCOUNT ON

DECLARE @Reference varchar (20), @Bonus money, @ID int
DECLARE @MemberID int, @BV money, @Shares int
DECLARE @ALLSTAR_BONUS int
SET @ALLSTAR_BONUS = 8
SET @Reference = ''

-- create temp table for members with shares in the pool 
DECLARE @Share TABLE(
   MemberID int ,
   Shares int
)
INSERT INTO @Share
SELECT MemberID, 
CASE Title 
	WHEN 8 THEN 1
	WHEN 9 THEN 2
	WHEN 10 THEN 4
END AS Shares
FROM Member
--WHERE CompanyID = 582 AND Status = 1 AND Qualify > 0 AND Title >= 8
WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify > 0 AND Title >= 8

-- Get the total number of shares
SELECT @Shares = SUM(Shares) FROM @Share

-- calc bonus per share by dividing total points by the number of shares 
-- and multiply by 3% and round to pennies
SET @BV = ROUND( ( @TotalPoints * .03 ) / @Shares, 2 )

print 'All Star Pool: ' + cast(@TotalPoints as varchar(10))
print 'Shares: ' + cast(@Shares as varchar(10))
print 'All Star Share: ' + cast(@BV as varchar(10))

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Shares FROM @Share

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Shares
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Bonus = @BV * @Shares
	SET @Reference = CAST(@Shares AS varchar(20)) + ' * ' + CAST(@BV AS varchar(20))
	EXEC pts_BonusItem_Add @ID, 0, @CompanyID, @MemberID, 0, @ALLSTAR_BONUS, @Bonus, @Reference, 1
--print '8, ' + cast(@MemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Shares
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


GO