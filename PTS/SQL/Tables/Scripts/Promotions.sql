declare @MemberID int, @Title int, @Team int, @ReferralID int, @SponsorID int, @BV money, @EnrollDate datetime, @cnt int

UPDATE me 
	SET BV3 = (SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND [Level] = 1 AND Status >= 1 AND Status <= 4)
FROM Member AS me WHERE me.CompanyID = 5 AND [Level] = 1 AND me.Status >= 1 AND me.Status <= 5

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID
FROM Member WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND BV3 = 0
--and memberid = 763

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--		-- TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			-- check for advancement for this affiliate
			EXEC pts_Commission_CalcAdvancement_5 @MemberID, 0, @cnt OUTPUT

			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
