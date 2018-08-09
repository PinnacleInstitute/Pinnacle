-----------------------------
-- Place Nexxus matrix
-----------------------------
UPDATE Member set SponsorID = 0 WHERE CompanyID = 21
DECLARE @MemberID int, @ReferralID int, @Level int, @Pos int

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT memberid, referralid from Member where companyid = 21 and status = 1 order by enrolldate

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @ReferralID > 0
	BEGIN
		SET @Level = 0 SET @Pos = 0 
		EXEC pts_Member_PlaceSponsor -2, @ReferralID OUTPUT, @Level OUTPUT, @Pos OUTPUT
		UPDATE Member SET SponsorID = @ReferralID WHERE MemberID = @MemberID
	END
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @ReferralID
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


