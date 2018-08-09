update Member SET Title = 6 where Title = 4
update Member SET Title = 5 where Title = 3
update Member SET Title = 4 where Title = 2
update Member SET Title = 2 where Title = 1

update Member SET Title2 = 6 where Title2 = 4
update Member SET Title2 = 5 where Title2 = 3
update Member SET Title2 = 4 where Title2 = 2
update Member SET Title2 = 2 where Title2 = 1

update Member SET MinTitle = 6 where MinTitle = 4
update Member SET MinTitle = 5 where MinTitle = 3
update Member SET MinTitle = 4 where MinTitle = 2
update Member SET MinTitle = 2 where MinTitle = 1

update Member SET BusAccts = 6 where BusAccts = 4
update Member SET BusAccts = 5 where BusAccts = 3
update Member SET BusAccts = 4 where BusAccts = 2
update Member SET BusAccts = 2 where BusAccts = 1

update Member SET MaxMembers = 6 where MaxMembers = 4
update Member SET MaxMembers = 5 where MaxMembers = 3
update Member SET MaxMembers = 4 where MaxMembers = 2
update Member SET MaxMembers = 2 where MaxMembers = 1

update member set Title = 1, Title2 = 1 where level = 1 and title = 2 and bv < 40

update me set Title = 3, Title2 = 3 from member as me
where level = 1 and title < 4 and bv >= 40 
and 2 <= ( select count(*) from member where level = 1 and status >= 1 and status <= 4 and bv >= 40 and SponsorID = me.memberid )

update me set Title = 2, Title2 = 2 from member as me
where level = 1 and title = 3 and bv >= 40 
and 2 > ( select count(*) from member where level = 1 and status >= 1 and status <= 4 and bv >= 40 and  SponsorID = me.memberid )


-- *****************************************************************
-- Update MaxTitles (MaxMembers)
-- *****************************************************************
DECLARE @MemberID int, @SponsorID int, @Title int, @MaxTitle int, @CurMaxTitle int

UPDATE me 
SET BV3 = (SELECT COUNT(*) FROM Member WHERE SponsorID = me.MemberID AND [Level] = 1 AND Status >= 1 AND Status <= 4)
FROM Member AS me WHERE me.CompanyID = 5 AND [Level] = 1 AND me.Status >= 1 AND me.Status <= 5

--	Process all affiliates at the bottom of the enroller hierarchy (BV3=0 they have no recruits)
--	Walk up the sponsor line and store the highest title in MaxMembers
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT SponsorID
FROM Member WHERE CompanyID = 5 AND [Level] = 1 AND Status >= 1 AND Status <= 5 AND BV3 = 0

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @MaxTitle = 1
	WHILE @MemberID > 0
	BEGIN
		SET @SponsorID = -1
--		--Get the current Affiliate's sponsor, personal volume, group volume, downline count, title
		SELECT @SponsorID = SponsorID, @Title = Title, @CurMaxTitle = MaxMembers FROM Member WHERE MemberID = @MemberID
--		--TEST if we found the affiliate
		IF @SponsorID >= 0
		BEGIN
--			--Check for highest title
			IF @Title > @MaxTitle SET @MaxTitle = @Title

--			--Update highest title for the current affiliate
			IF @MaxTitle <> @CurMaxTitle
				UPDATE Member SET MaxMembers = @MaxTitle WHERE MemberID = @MemberID

			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor


-- *****************************************************************
-- SAVE current BV in QV4 for FAST START for existing affiliates
-- *****************************************************************
UPDATE Member SET QV4 = BV

