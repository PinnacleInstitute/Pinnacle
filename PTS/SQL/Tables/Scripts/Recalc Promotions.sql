declare @MemberID int, @Title int, @MaxTitle int, @Team int, @ReferralID int, @SponsorID int, @BV money, @EnrollDate datetime, @cnt int

-- Set title for affiliates not guaranteed a minimum title
UPDATE Member SET Title = 1, Title2 = 1, MaxMembers = 1
WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND MinTitle = 0

-- Delete all member titles if the affiliate is not guaranteed a minimum title
DELETE mt FROM MemberTitle AS mt JOIN Member AS me ON mt.MemberID = me.MemberID
WHERE me.CompanyID = 5 AND me.Level = 1 AND me.Status >= 1 AND me.Status <= 5 AND me.MinTitle = 0
	
--	Init personal volume(BV), group volume(QV), 1st level count(BV3), downline count(BV4), leg title(MaxMembers), sponsor team(BusAccts)
UPDATE Member SET BV = 0, BV2 = 0, QV = 0, QV2 = 0, BV3 = 0, BV4 = 0, MaxMembers = 1, BusAccts = 1 
WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5

--	Set the Personal Sales Volume (personal use + retail sales) (store in BV, BV2) 
UPDATE me 
	SET BV = Price + (SELECT ISNULL(SUM(Price),0) FROM Member WHERE ReferralID = me.MemberID AND [Level] = 0 AND Status = 1),
	   BV2 = Price + (SELECT ISNULL(SUM(Price),0) FROM Member WHERE ReferralID = me.MemberID AND [Level] = 0 AND Status = 1)
FROM Member AS me WHERE me.CompanyID = 5 AND [Level] = 1 AND me.Status >= 1 AND me.Status <= 5

-- Set Affiliate title if they have $40
UPDATE Member SET Title = 2, Title2 = 2, MaxMembers = 2 WHERE CompanyID = 5 AND Title = 1 AND BV >= 40

DECLARE Member_cursor CURSOR FOR 
SELECT MemberID, ReferralID, SponsorID, BV, EnrollDate 
FROM Member WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5
ORDER BY EnrollDate
--and memberid = 763

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID, @SponsorID, @BV, @EnrollDate 
WHILE @@FETCH_STATUS = 0
BEGIN
--	Assign new Affiliate to 3 leadership teams (based on enroller)
	IF @ReferralID > 0
		EXEC pts_Downline_Build_5 5, @ReferralID, @MemberID
			
--	-- Assign new Affiliate to the sponsor's team
	IF @SponsorID > 0
	BEGIN	
		SELECT @Title = Title FROM Member WHERE MemberID = @SponsorID
		UPDATE Member SET BusAccts = @Title WHERE MemberID = @MemberID
	END

--	 *************************************************************
--	 Accumulate group volume (based on sponsor)
--	 *************************************************************
	SET @MemberID = @SponsorID
	SET @MaxTitle = 1
	
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID, @Title = Title FROM Member WHERE MemberID = @MemberID
--		-- TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			--Check for highest title
			IF @Title > @MaxTitle SET @MaxTitle = @Title

--			-- accumulate the new sale in the affiliate's group sales volume
			UPDATE Member SET QV = QV + @BV, QV2 = QV2 + @BV, BV4 = BV4 + 1, MaxMembers = @MaxTitle WHERE MemberID = @MemberID 

--			-- check for advancement for this affiliate
			EXEC pts_Commission_CalcAdvancement_5 @MemberID, @EnrollDate, @cnt OUTPUT

			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID, @SponsorID, @BV, @EnrollDate 
END
CLOSE Member_cursor
DEALLOCATE Member_cursor
