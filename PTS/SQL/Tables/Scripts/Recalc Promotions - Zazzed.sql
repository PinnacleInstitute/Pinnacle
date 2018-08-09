declare @CompanyID int, @MemberID int, @Title int, @Team int, @ReferralID int, @SponsorID int, @BV money, @EnrollDate datetime, @cnt int
SET @CompanyID = 9

-- Set title for affiliates not guaranteed a minimum title
UPDATE Member SET Title = 4, Title2 = 4 WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND MinTitle = 0 AND CHARINDEX('116', Options2) > 0
UPDATE Member SET Title = 6, Title2 = 6 WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND MinTitle = 0 AND CHARINDEX('115', Options2) > 0

-- Delete all member titles if the affiliate is not guaranteed a minimum title
DELETE mt FROM MemberTitle AS mt JOIN Member AS me ON mt.MemberID = me.MemberID
WHERE me.CompanyID = @CompanyID AND me.Level = 1 AND me.Status >= 1 AND me.Status <= 5 AND me.MinTitle = 0

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID, ReferralID, EnrollDate 
FROM Member WHERE CompanyID = @CompanyID AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND CHARINDEX('B', Options2) > 0
--and memberid = 7932
ORDER BY EnrollDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID, @EnrollDate 
WHILE @@FETCH_STATUS = 0
BEGIN
--	Assign new Affiliate to 5 coded teams (based on enroller)
	IF @ReferralID > 0 EXEC pts_Downline_Build_9 @CompanyID, @ReferralID, @MemberID
			
--	 *************************************************************
--	 Calculate upline advancements
--	 *************************************************************
	SET @MemberID = @ReferralID
	WHILE @MemberID > 0
	BEGIN
		SET @ReferralID = -1
		SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		IF @ReferralID >= 0
		BEGIN
--			-- check for advancement for this affiliate
			EXEC pts_Commission_CalcAdvancement_9 @MemberID, @EnrollDate, @cnt OUTPUT

			SET @MemberID = @ReferralID
		END
		ELSE SET @MemberID = 0
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID, @EnrollDate 
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
