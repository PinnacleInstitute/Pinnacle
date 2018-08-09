-- *********************************************************************
-- Place phsae one members in the Community Matrix Downline
-- *********************************************************************
DECLARE @CompanyID int, @MemberID int, @SponsorID int, @cnt int
SET @CompanyID = 7

--update member set sponsorid = 0 where companyid = 7 and level = 3 

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, ReferralID FROM Member WHERE CompanyID = 7 AND ReferralID > 0 AND SponsorID = 0 
AND Status >= 1 AND Status <= 5 
ORDER BY EnrollDate

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @SponsorID

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @cnt = COUNT(*) FROM Member WHERE SponsorID = @SponsorID AND Status >= 1 AND Status <= 5 

	IF @cnt > 2 EXEC pts_Member_PlaceSponsor 3, @SponsorID OUTPUT, 0, 0

	UPDATE Member SET SponsorID = @SponsorID FROM Member WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @SponsorID
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

