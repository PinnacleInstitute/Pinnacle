-- ********************************************************************
-- Calculate Fast Start Restart Bonuses for existing Affiliates 6/1/12
-- ********************************************************************
DECLARE @CompanyID int, @MemberID int
DECLARE @Bonus money, @ID int, @Desc varchar(1000)
DECLARE @tmpCount int, @CommissionType int

SET @CompanyID = 5

-- Fast Start Bonuses
-- ********************************************************************************
-- 	Fast Start Senior Bonus for new Affiliate recruiting 2 New Affiliates in 7 days
-- ********************************************************************************
PRINT '-------------------------'
PRINT 'FAST START Senior Bonuses'
PRINT '-------------------------'
--	Get All Active Affiliates whose first 7 days ended this week
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, NameFirst + ' ' + NameLast 
	FROM   Member
	WHERE  CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2
	AND    EnrollDate < '6/1/12'

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Desc
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		Get the number of new active Affiliates enrolled by this member in 7 days
		SET @tmpCount = 0
		SELECT @tmpCount = COUNT(*) FROM Member 
		WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2 AND EnrollDate < '6/1/12'
		AND ( ( EnrollDate > '6/1/12' AND EnrollDate < '6/8/12') OR (BV >= 40 and QV4 < 40))
		
		IF @tmpCount >= 2 
		BEGIN
			SET @CommissionType = 32
			SET @Bonus = 20
PRINT CAST(@MemberID AS VARCHAR(10)) + ' ' + @Desc + '(' + CAST(@tmpCount AS VARCHAR(10)) + ')'
			SET @Desc = 'Existing Affiliate: 6/1/12 - 6/7/12'
--			CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
--			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, 0, @Today, 1, @CommissionType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID, @Desc
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor

-- ********************************************************************************
-- 	Fast Start Manager Bonus for new Affiliate recruiting 2 New Sr. Affiliates in 14 days
-- ********************************************************************************
PRINT ''
PRINT '--------------------------'
PRINT 'FAST START Manager Bonuses'
PRINT '--------------------------'
--	Get All Active Affiliates whose first 14 days ended this week
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT MemberID, NameFirst + ' ' + NameLast
	FROM   Member
	WHERE  CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 2
	AND    EnrollDate < '6/1/12'

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Desc
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		Get the number of new active Affiliates enrolled by this member in 7 days
		SET @tmpCount = 0
		SELECT @tmpCount = COUNT(*) FROM Member 
		WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 4 AND Level = 1 AND Title >= 3 AND EnrollDate < '6/15/12'
		AND ( ( EnrollDate > '6/1/12' AND EnrollDate < '6/15/12') OR (BV >= 40 and QV4 < 40))
		
		IF @tmpCount >= 2 
		BEGIN
			SET @CommissionType = 33
			SET @Bonus = 20
PRINT CAST(@MemberID AS VARCHAR(10)) + ' ' + @Desc + '(' + CAST(@tmpCount AS VARCHAR(10)) + ')'
			SET @Desc = 'Existing Affiliate: 6/1/12 - 6/14/12'
--			CommissionID, CompanyID, OwnerType, OwnerID, PayoutID, RefID, CommDate, Status, CommType, Amount, Total, Charge, Description, Notes, View, UserID
--			EXEC pts_Commission_Add @ID, @CompanyID, 4, @MemberID, 0, 0, @Today, 1, @CommissionType, @Bonus, @Bonus, 0, @Desc, '', 1, 1
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID, @Desc
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor

GO
