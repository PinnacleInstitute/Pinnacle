-- Set Matrix Sponsors

DECLARE @CompanyID int, @MemberID int, @ReferralID int, @SponsorID int, @Level int, @Pos int
SET @CompanyID = 14

UPDATE Member SET SponsorID = 0 WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, ReferralID
FROM Member WHERE CompanyID = 14 AND Status >= 1 AND Status <= 4
--and memberid = 22652
ORDER BY EnrollDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @ReferralID > 0
	BEGIN
--		Place in Matrix
		SET @SponsorID = @ReferralID
		SET @Level = 0 SET @Pos = 0 
		EXEC pts_Member_PlaceSponsor -4, @SponsorID OUTPUT, @Level OUTPUT, @Pos OUTPUT
		UPDATE Member SET SponsorID = @SponsorID WHERE MemberID = @MemberID
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO

--select ReferralID, SponsorID, Status, * from Member where CompanyID = 14 and SponsorID = 0 and status <= 4
--select ReferralID, SponsorID, Status, * from Member where memberid = 22652\