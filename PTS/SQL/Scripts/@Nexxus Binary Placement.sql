-----------------------------
-- Place Nexxus Binary
-----------------------------
UPDATE Member set Sponsor3ID = 0, BV3 = 0, BV4 = 0 WHERE CompanyID = 21 AND Status <= 5
DECLARE @MemberID int, @ReferralID int, @tmpReferralID int, @Level int, @Pos int, @Result varchar(100)


DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT memberid, referralid from Member where companyid = 21 and status >= 1 and status <= 5 and title > 1 order by enrolldate

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @ReferralID > 0
	BEGIN
		SET @tmpReferralID = @ReferralID
		EXEC pts_Member_PlaceBinary3 @tmpReferralID OUTPUT, @Pos OUTPUT
		UPDATE Member SET Sponsor3ID = @tmpReferralID, Pos = @Pos WHERE MemberID = @MemberID
		
		--	Update the upline binary totals
		EXEC pts_Nexxus_SetTotalsB @tmpReferralID, 1, @Result output

	END
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @ReferralID
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


