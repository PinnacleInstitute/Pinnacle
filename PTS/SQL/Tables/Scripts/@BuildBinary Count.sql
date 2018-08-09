-- *********************************************************************
-- Count all members in the Binary Downline
-- *********************************************************************
DECLARE @MemberID int, @SponsorID int, @tmp int

UPDATE Member SET QV4 = 0 WHERE CompanyID = 7 AND QV4 > 0

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, ReferralID FROM Member 
WHERE CompanyID = 7 AND ReferralID > 0
ORDER BY EnrollDate

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @SponsorID

WHILE @@FETCH_STATUS = 0
BEGIN
--print '-------------------------------------------------------'
--print 'Member: ' + CAST(@MemberID AS VARCHAR(10))
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

