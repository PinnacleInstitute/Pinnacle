-- ******************************************
-- Move a Member under a different Enroller
-- And Rebuild their Downlines
-- ******************************************

DECLARE @MemberID int, @ReferralID int, @Result int 

SET @MemberID = 90209
SET @ReferralID = 89441

-- Set the ReferralID and clear the sponsorids
UPDATE Member SET ReferralID = @ReferralID, SponsorID = @ReferralID, Sponsor2ID = 0, Sponsor3ID = 0 WHERE MemberID = @MemberID

-- Remove the member from the old Leadership TEams
DELETE FROM Downline WHERE ChildID = @MemberID

-- Re-initialize the member to rebuild downlines and counts
EXEC pts_Company_Custom_7 100, 0, @MemberID, 0, @Result output 

-- Re-calculate downline counts
--DECLARE @Result int
--EXEC pts_Company_Custom_7 1, 0, 0, 0, @Result output 

