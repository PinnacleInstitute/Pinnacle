EXEC [dbo].pts_CheckProc 'pts_Commission_Company_5b'
GO
-- ********************************************************************************
-- 	Fast Start $20 Bonuses
-- ********************************************************************************

--DECLARE @Count int EXEC pts_Commission_Company_5b '6/10/12', @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_Company_5b
   @ToDate datetime ,
   @Count int OUTPUT
AS

DECLARE @CompanyID int, @Today datetime, @FromDate datetime, @MemberID int, @ID int, @Bonus money
DECLARE @tmpCount int, @CommissionType int, @EnrollDate datetime, @tmpDate datetime

SET @CompanyID = 5
SET @Count = 0
SET @Today = GETDATE()

-- Fast Start Bonuses
-- ********************************************************************************
-- 	Fast Start Senior Bonus for new Affiliate recruiting 2 New Affiliates in 7 days
-- ********************************************************************************
--	Get All Active Affiliates whose first 7 days ended this week
--print '-----------------------'
--print 'Fast Start Senior Bonus'
--print '-----------------------'
SET @tmpDate = @ToDate
SET @ToDate = DATEADD(d,-7,@ToDate)
SET @FromDate = DATEADD(d,-7,@ToDate)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, EnrollDate 
FROM   Member
WHERE  CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2
AND    dbo.wtfn_DateOnly(EnrollDate) >= @FromDate AND dbo.wtfn_DateOnly(EnrollDate) <= @ToDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
WHILE @@FETCH_STATUS = 0
BEGIN
--	Get the number of new active Affiliates enrolled by this member in 7 days
	SET @tmpCount = 0
	SELECT @tmpCount = COUNT(*) FROM Member 
	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2
	AND EnrollDate < DATEADD(d,7,@EnrollDate)
	
	IF @tmpCount >= 2 
	BEGIN
		SET @CommissionType = 32
		SET @Bonus = 20
--print @MemberID
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, 0, @Today, 1, @CommissionType, @Bonus, @Bonus, 0, '', '', 1, 1
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

-- ********************************************************************************
-- 	Fast Start Manager Bonus for new Affiliate recruiting 2 New Sr. Affiliates in 14 days
-- ********************************************************************************
--	Get All Active Affiliates whose first 14 days ended this week
--print '-----------------------'
--print 'Fast Start Manager Bonus'
--print '------------------------'
SET @ToDate = @tmpDate
SET @ToDate = DATEADD(d,-14,@ToDate)
SET @FromDate = DATEADD(d,-7,@ToDate)
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, EnrollDate 
FROM   Member
WHERE  CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2
AND    dbo.wtfn_DateOnly(EnrollDate) >= @FromDate AND dbo.wtfn_DateOnly(EnrollDate) <= @ToDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
WHILE @@FETCH_STATUS = 0
BEGIN
--	Get the number of new active Affiliates enrolled by this member in 7 days
	SET @tmpCount = 0
	SELECT @tmpCount = COUNT(*) FROM Member 
	WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 3
	AND EnrollDate < DATEADD(d,14,@EnrollDate)
	
	IF @tmpCount >= 2 
	BEGIN
		SET @CommissionType = 33
		SET @Bonus = 20
--print @MemberID
--		CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
		EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, 0, @Today, 1, @CommissionType, @Bonus, @Bonus, 0, '', '', 1, 1
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @EnrollDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO
