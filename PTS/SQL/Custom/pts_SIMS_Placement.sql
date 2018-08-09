EXEC [dbo].pts_CheckProc 'pts_SIMS_Placement'
GO

--declare @Result varchar(1000) EXEC pts_SIMS_Placement 7219, @Result output print @Result
--declare @Result varchar(1000) EXEC pts_SIMS_Placement 7222, @Result output print @Result

CREATE PROCEDURE [dbo].pts_SIMS_Placement
   @MemberID int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON

DECLARE @ReferralID int, @EnrollDate datetime, @Sponsor2ID int, @cnt int, @Title int, @Level int
SET @ReferralID = 0
SET @Sponsor2ID = 0

--Get the member's referrer and enrolldate
SELECT @ReferralID = ReferralID, @EnrollDate = EnrollDate, @Level = [Level] FROM Member Where MemberID = @MemberID
--print 'ReferralID: ' + CAST(@ReferralID AS VARCHAR(10))

--Get the referrer's Sponsor2ID
SELECT @Sponsor2ID = Sponsor2ID FROM Member WHERE MemberID = @ReferralID
--print 'Sponsor2ID: ' + CAST(@Sponsor2ID AS VARCHAR(10))

--Free Resellers are always coded to their referer's Sponsor2ID
IF @Level > 0
BEGIN
--	Get the referrer's number of enrollees before this member
	SELECT @cnt = COUNT(MemberID) FROM Member WHERE ReferralID = @ReferralID AND EnrollDate < @EnrollDate AND Level != 0
--print 'cnt: ' + CAST(@cnt AS VARCHAR(10))

--	If this member is not #2, #4 or #6, set their Sponsor2ID to their referrer, otherwise set it to the referrer's sponsor2ID 
	IF @cnt != 1 AND @cnt != 3 AND @cnt != 5 SET @Sponsor2ID = @ReferralID
END

--Set the new member's Sponsor2ID for the Coded bonuses
UPDATE Member SET Sponsor2ID = @Sponsor2ID WHERE MemberID = @MemberID
--print 'Sponsor2ID: ' + CAST(@Sponsor2ID AS VARCHAR(10))

SET @Result = CAST(@Sponsor2ID AS VARCHAR(10))
 
GO