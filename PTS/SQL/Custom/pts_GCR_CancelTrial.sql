EXEC [dbo].pts_CheckProc 'pts_GCR_CancelTrial'
GO

--declare @Result varchar(1000) EXEC pts_GCR_CancelTrial @Result output print @Result
--select * from Member where companyid = 17 and Status = 6
-- *******************************************************************
-- Cancel all GCR Trial Dealers over 30 days (plus 10 day buffer)
-- *******************************************************************
CREATE PROCEDURE [dbo].pts_GCR_CancelTrial
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
SET @Result = '0'

DECLARE @CompanyID int, @MemberID int, @ReferralID int, @SponsorID int, @tmpSponsorID int, @SponsoreeID int, @Date datetime, @Cnt int, @Level int, @Pos int
SET @CompanyID = 17
SET @Date = DATEADD( day, -40, GETDATE()) 
SET @Cnt = 0

--	Process all affiliates at the bottom of the enroller hierarchy (BV=0)
--	Walk up the referral line and store the Group Totals for each member in QV and the highest title in MaxMembers
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, ReferralID, SponsorID
FROM Member WHERE CompanyID = @CompanyID AND Status = 2 AND EnrollDate < @Date

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID, @SponsorID
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Cnt = @Cnt + 1

--	Cancel Member
--	UPDATE Member SET Status = 6 WHERE MemberID = @MemberID
	UPDATE Member SET Title = 1 WHERE MemberID = @MemberID

--	Update children Referral, save old referralID in Sponsor2ID
	UPDATE Member SET ReferralID = @ReferralID, Sponsor2ID = @MemberID WHERE ReferralID = @MemberID

--	Update children Mentor
	UPDATE Member SET MentorID = @ReferralID WHERE MentorID = @MemberID

--	Update children Sponsor (Matrix), save old SponsorID in Sponsor3ID
--	DECLARE Sponsor_cursor CURSOR LOCAL STATIC FOR 
--	SELECT MemberID FROM Member WHERE SponsorID = @MemberID
--	OPEN Sponsor_cursor
--	FETCH NEXT FROM Sponsor_cursor INTO @SponsoreeID
--	WHILE @@FETCH_STATUS = 0
--	BEGIN
--		SET @tmpSponsorID = @SponsorID
--		SET @Level = 0 SET @Pos = 0 
--		UPDATE Member SET SponsorID = 0, Sponsor3ID = @MemberID WHERE MemberID = @SponsoreeID
--		EXEC pts_Member_PlaceSponsor -2, @tmpSponsorID OUTPUT, @Level OUTPUT, @Pos OUTPUT
--		UPDATE Member SET SponsorID = @tmpSponsorID WHERE MemberID = @SponsoreeID
--		FETCH NEXT FROM Sponsor_cursor INTO @SponsoreeID
--	END
--	CLOSE Sponsor_cursor
--	DEALLOCATE Sponsor_cursor

	FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID, @SponsorID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

SET @Result = CAST(@Cnt AS VARCHAR(10))

GO