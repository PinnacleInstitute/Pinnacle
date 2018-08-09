-- ************************************************************************************
-- Calculate Active Distributors for License Fees  (Billing = 2)
-- Calculate Active Distributors for Premium Memberships  (Billing = 3)
-- ************************************************************************************

DECLARE @FromDate datetime, @ToDate datetime, @Cnt2 int, @Cnt3 int
SET @ToDate = dbo.wtfn_DateOnly(GETDATE())
SET @ToDate = CAST(Month(@ToDate) as varchar(10)) + '/1/' + CAST(Year(@ToDate) as varchar(10))
SET @FromDate = DATEADD(month, -3, @Todate)

DECLARE @Share TABLE(
   MemberID int 
)

-- Distributors placed an order
INSERT INTO @Share
select distinct so.memberid 'memberid'
from salesorder as so
join member as me on so.memberid = me.memberid
where so.orderdate >= @FromDate
and so.orderdate < @Todate
and me.companyid = 582
and me.status = 1

-- Distributors enrolled new distributors
INSERT INTO @Share
select referralid  'memberid'
from member
where enrolldate >= @FromDate
and enrolldate < @Todate
and companyid = 582
and status = 1

-- Distributors accessed system
INSERT INTO @Share
select distinct memberid  'memberid'
from member
where visitdate >= @FromDate
and visitdate < @Todate
and companyid = 582
and status = 1

-- Distributors earned a bonus
INSERT INTO @Share
select distinct bo.memberid  'memberid'
from bonus as bo
join member as me on bo.memberid = me.memberid
where bo.bonusdate >= @FromDate
and bo.bonusdate < @Todate
and bo.companyid = 582
and bo.total > 0
and me.status = 1

-- Initialize Member Billing to 0
UPDATE Member SET Billing = 0 WHERE CompanyID = 582 AND Billing > 1

-- Set Active Distributors for License Fees  (Billing = 2)
UPDATE Member SET Billing = 2 
WHERE MemberID IN ( SELECT MemberID FROM @Share )

-- Calculate Active Distributors for Premium Memberships  (Billing = 3)
UPDATE Member SET Billing = 3 
WHERE VisitDate > 0  
AND EnrollDate < @ToDate
AND Status = 1 
AND Level = 1
AND MemberID IN ( SELECT MemberID FROM @Share )

-- Get number of active distributors
SELECT @Cnt2 = COUNT(*) FROM Member WHERE CompanyID = 582 AND Billing = 2
SELECT @Cnt3 = COUNT(*) FROM Member WHERE CompanyID = 582 AND Billing = 3

PRINT 'From: ' + cast(@FromDate as varchar(20)) + ' To: ' + cast(@ToDate as varchar(20)) 
PRINT 'Active Distributors: ' + CAST(@Cnt2 AS VARCHAR(10))
PRINT 'Premium Memberships: ' + CAST(@Cnt3 AS VARCHAR(10))
