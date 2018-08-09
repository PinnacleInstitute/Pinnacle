-- ****************************************************************************************
-- Recalculate all points for all orders for the month
-- ****************************************************************************************

-- --------------------------------------------------------------------------------------------------------
-- Set Initial variables
-- --------------------------------------------------------------------------------------------------------
DECLARE @CompanyID int, @FromDate datetime, @ToDate datetime, @MemberID int, @BV money
SET @CompanyID = 582
SET @FromDate = '11/1/08'
SET @ToDate = '12/1/08'

-- --------------------------------------------------------------------------------------------------------
-- Clear Member personal and group points
-- --------------------------------------------------------------------------------------------------------
UPDATE Member SET BV = 0, QV = 0 WHERE CompanyID = @CompanyID AND (BV != 0 OR QV != 0)

-- --------------------------------------------------------------------------------------------------------
-- Set Member personal points
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

-- Get all orders for customers
INSERT INTO @Orders
SELECT me.SponsorID 'MemberID', so.BV 'BV'
FROM SalesOrder AS so
JOIN Member AS me ON so.MemberID = me.MemberID
WHERE so.CompanyID = @CompanyID
AND me.Status = 3
AND so.OrderDate >= @FromDate
AND so.OrderDate < @ToDate
AND so.Status = 3
AND so.AutoShip < 2
AND so.BV > 0
AND me.SponsorID > 0

--select sum(bv) from @Orders

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, SUM(BV) FROM @Orders GROUP BY MemberID

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
WHILE @@FETCH_STATUS = 0
BEGIN
	UPDATE Member SET BV = @BV, QV = @BV WHERE MemberID = @MemberID
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


-- --------------------------------------------------------------------------------------------------------
-- calculate the member's total group points (QV) by accumulating the downline personal points (BV)
-- --------------------------------------------------------------------------------------------------------
--DECLARE @CompanyID int
--SET @CompanyID = 582
--UPDATE Member SET QV = BV WHERE CompanyID = @CompanyID AND Status = 1 AND QV != BV
EXEC pts_Member_CalcQV @CompanyID

--select * from salesorder where companyid=582 
--AND OrderDate >= '10/1/08'
--AND OrderDate < '11/1/08'
 
