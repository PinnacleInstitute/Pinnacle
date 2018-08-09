-- *********************************************************************
-- Place all members in a Binary Downline
-- *********************************************************************
DECLARE @CompanyID int, @MemberID int, @SponsorID int, @Pos int, @tmp int
SET @CompanyID = 7

-- Clear all Sponsor3IDs
--UPDATE Member SET Sponsor3ID = 0, Pos = 0 WHERE CompanyID = 7 AND Sponsor3ID > 0 -- AND ReferralID = 87101
--UPDATE Member SET QV4 = 0 WHERE CompanyID = 7 AND QV4 > 0 -- AND ReferralID = 87101
--select count(*) from member where sponsor3id > 0
--select * from member where memberid = 87778 

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, ReferralID FROM Member 
WHERE CompanyID = 7 AND ReferralID > 0 AND Sponsor3ID = 0 -- AND ReferralID = 87101
ORDER BY EnrollDate

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @SponsorID

WHILE @@FETCH_STATUS = 0
BEGIN
--print '-------------------------------------------------------'
--print 'Member: ' + CAST(@MemberID AS VARCHAR(10))
	EXEC pts_Member_PlaceBinary3 @SponsorID OUTPUT, @Pos OUTPUT
--PRINT CAST(@SponsorID AS VARCHAR(10)) + ':' + CAST(@Pos AS VARCHAR(10))

	UPDATE Member SET Sponsor3ID = @SponsorID, Pos = @Pos WHERE MemberID = @MemberID

--	-- Increment personal total for the sponsors of this new member	
	WHILE @SponsorID > 0
	BEGIN
		-- update upline personal and group counts
		UPDATE Member SET QV4 = QV4 + 1 WHERE MemberID = @SponsorID 
		SET @tmp = @SponsorID
		SET @SponsorID = 0
		SELECT @SponsorID = Sponsor3ID FROM Member WHERE MemberID = @tmp
	END

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @SponsorID
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

