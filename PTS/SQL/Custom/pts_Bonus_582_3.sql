EXEC [dbo].pts_CheckProc 'pts_Bonus_582_3'
GO
--EXEC pts_Bonus_582_3 582, '10/1/08', '11/1/08', 83675.80 

-- Calculate Builder Pool Bonus
CREATE PROCEDURE [dbo].pts_Bonus_582_3
   @CompanyID int,
   @FromDate datetime, 
   @ToDate datetime, 
   @BuilderPoints money 
AS

SET NOCOUNT ON

DECLARE @BonusMemberID int, @Reference varchar (20), @Rate money, @Bonus money, @ID int
DECLARE @MemberID int, @BV money, @Qualify int, @Shares int
DECLARE @BUILDERPOOL_BONUS int
SET @BUILDERPOOL_BONUS = 3
SET @Reference = ''

-- create temp table for members with shares in the builder pool 
DECLARE @Share TABLE(
   MemberID int ,
   Shares int
)
-- get all members that have enrolled 5+ new members
INSERT INTO @Share
SELECT ReferralID 'MemberID', COUNT(MemberID)/5 'Cnt' FROM Member
WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify > 0 AND ReferralID > 0
AND EnrollDate >= @FromDate AND EnrollDate < @ToDate 
GROUP BY ReferralID
HAVING COUNT(MemberID) >= 5

-- Get the total number of shares
SELECT @Shares = SUM(Shares) FROM @Share

-- calc bonus per share by dividing total builder points by the number of shares 
-- and multiply by 2% and round to pennies
SET @BV = ROUND( ( @BuilderPoints * .02 ) / @Shares, 2 )

print 'BuilderPool: ' + cast(@BuilderPoints as varchar(10))
print 'Shares: ' + cast(@Shares as varchar(10))
print 'Builder Share: ' + cast(@BV as varchar(10))

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Shares FROM @Share

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Shares
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Bonus = @BV * @Shares
	SET @Reference = CAST(@Shares AS varchar(20)) + ' * ' + CAST(@BV AS varchar(20))
	EXEC pts_BonusItem_Add @ID, 0, @CompanyID, @MemberID, 0, @BUILDERPOOL_BONUS, @Bonus, @Reference, 1
--print '2, ' + cast(@MemberID as varchar(10)) + ', ' + cast(@BV as varchar(10)) + ', ' + cast(@Bonus as varchar(10)) + ', ' + @Reference
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Shares
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO