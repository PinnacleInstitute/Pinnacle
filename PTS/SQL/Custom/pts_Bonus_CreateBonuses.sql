EXEC [dbo].pts_CheckProc 'pts_Bonus_CreateBonuses'
GO
--DECLARE @Count int
--EXEC pts_Bonus_CreateBonuses 582, '12/1/08', '11/1/08', '12/1/08', @Count
--EXEC pts_Bonus_CreateBonuses 582, '11/1/08', '10/1/08', '11/1/08', @Count

CREATE PROCEDURE [dbo].pts_Bonus_CreateBonuses
   @CompanyID int ,
   @BonusDate datetime ,
   @FromDate datetime ,
   @ToDate datetime ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

-- *********************************************************************************
IF @CompanyID = 582
BEGIN
-- *********************************************************************************

SET @Count = 0

DECLARE @MemberID int, @BV money, @ID int
print 'Create Bonus Records From Sales Orders: ' + dbo.wtfn_TimeStr(GETDATE())
-- --------------------------------------------------------------------------------------------------------
-- Create a bonus record for every member that has a personal or customer order in the specified date range
-- save the total personal points (BV) on the bonus record
-- --------------------------------------------------------------------------------------------------------
DECLARE @Orders TABLE(
   MemberID int ,
   BV money
)

-- Get all orders for distributors
INSERT INTO @Orders
SELECT so.MemberID 'MemberID', so.BV 'BV'
FROM SalesOrder AS so
JOIN Member AS me ON so.MemberID = me.MemberID
WHERE so.CompanyID = @CompanyID
AND me.Status != 3
AND so.OrderDate >= @FromDate
AND so.OrderDate < @ToDate
AND so.Status = 3
AND so.AutoShip < 2
AND so.BV > 0
--and me.enrolldate >= '6/20/08'

-- Get all orders for customers
INSERT INTO @Orders
SELECT me.SponsorID 'MemberID', so.BV 'BV'
FROM SalesOrder AS so
JOIN Member AS me ON so.MemberID = me.MemberID
--join Member AS sp ON me.SponsorID = sp.MemberID
WHERE so.CompanyID = @CompanyID
AND me.Status = 3
AND so.OrderDate >= @FromDate
AND so.OrderDate < @ToDate
AND so.Status = 3
AND so.AutoShip < 2
AND so.BV > 0
AND me.SponsorID > 0
--and sp.enrolldate >= '6/20/08'

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SUM(BV) FROM @Orders GROUP BY MemberID

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
--	-- BonusID,CompanyID,MemberID,BonusDate,Title,BV,QV,Total,PaidDate, Reference, IsPrivate, UserID
	EXEC pts_Bonus_Add @ID, @CompanyID, @MemberID, @BonusDate, 0, @BV, 0, 0, 0, '', 1, 1 
--UPDATE Member SET BV = @BV WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

-- --------------------------------------------------------------------------------------------------------
-- initialize all active member's personal points (BV) and group points (QV) to 0  
-- --------------------------------------------------------------------------------------------------------
print 'Clear All Member BV and QV volume: ' + dbo.wtfn_TimeStr(GETDATE())
UPDATE Member SET BV = 0, QV = 0 WHERE CompanyID = @CompanyID AND (BV != 0 OR QV != 0)

-- --------------------------------------------------------------------------------------------------------
-- copy all active member's BV and QV from the bonus records BV 
-- --------------------------------------------------------------------------------------------------------
print 'Copy Member BV and QV from Bonuses: ' + dbo.wtfn_TimeStr(GETDATE())
UPDATE me SET me.BV = bo.BV, me.QV = bo.BV
FROM Member AS me
JOIN Bonus AS bo ON (bo.MemberID = me.MemberID AND bo.BonusDate = @BonusDate)
WHERE me.CompanyID = @CompanyID AND me.Status = 1

-- --------------------------------------------------------------------------------------------------------
-- initialize all active member's bonus qualified flag to 0 if not locked (2)
-- initialize all active member's bonus qualified flag to 0 if locked (2) and QualifyDate is set and is past
-- --------------------------------------------------------------------------------------------------------
print 'Clear Bonus Qualified Flags: ' + dbo.wtfn_TimeStr(GETDATE())
UPDATE Member SET Qualify = 0 WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify = 1
UPDATE Member SET Qualify = 0 WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify = 2 AND QualifyDate > 0 AND QualifyDate < @FromDate

-- --------------------------------------------------------------------------------------------------------
-- set all active member's bonus qualified flag if they have any personal points (BV) >= 30
-- --------------------------------------------------------------------------------------------------------
print 'Set Bonus Qualified Members: ' + dbo.wtfn_TimeStr(GETDATE())
UPDATE Member SET Qualify = 1 WHERE CompanyID = @CompanyID AND Status = 1 AND Qualify = 0 AND BV >= 30

-- --------------------------------------------------------------------------------------------------------
-- calculate the member's total group points (QV) by accumulating the downline personal points (BV)
-- --------------------------------------------------------------------------------------------------------
print 'Accumulate Member Group Volume (QV): ' + dbo.wtfn_TimeStr(GETDATE())
EXEC pts_Member_CalcQV @CompanyID

-- --------------------------------------------------------------------------------------------------------
-- calculate the earned title for each member
-- if title has changed, update the membertitle log 
-- --------------------------------------------------------------------------------------------------------
print 'Calc Titles: ' + dbo.wtfn_TimeStr(GETDATE())
EXEC pts_Member_CalcTitle @CompanyID, @FromDate

-- --------------------------------------------------------------------------------------------------------
-- copy all member's QV and Title to the bonus records 
-- --------------------------------------------------------------------------------------------------------
print 'Copy Member QV and Title to Bonuses: ' + dbo.wtfn_TimeStr(GETDATE())
UPDATE bo SET bo.QV = me.QV, bo.Title = me.Title
FROM Bonus AS bo
JOIN Member AS me ON bo.MemberID = me.MemberID
WHERE bo.CompanyID = @CompanyID AND bo.BonusDate = @BonusDate

-- --------------------------------------------------------------------------------------------------------
-- create bonuse items
-- --------------------------------------------------------------------------------------------------------
print 'Calculate Bonuses: ' + dbo.wtfn_TimeStr(GETDATE())
EXEC pts_Bonus_CalcBonuses @CompanyID, @BonusDate, @FromDate, @ToDate

print 'END: ' + dbo.wtfn_TimeStr(GETDATE())

END

GO
