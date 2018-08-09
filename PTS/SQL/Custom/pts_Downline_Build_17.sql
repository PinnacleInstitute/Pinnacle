EXEC [dbo].pts_CheckProc 'pts_Downline_Build_17'
GO

--EXEC pts_Downline_Build_17 17, 30147, 30678
--select * from downline where childid=521

CREATE PROCEDURE [dbo].pts_Downline_Build_17
   @CompanyID int ,
   @ParentID int ,
   @ChildID int 
AS

-- Build the Coded Teams
SET NOCOUNT ON

DECLARE @Title int, @Team int, @EnrollerID int, @AffiliateID int, @NewParentID int, @Status int, @ReferralID int
SET @EnrollerID = @ParentID
SET @AffiliateID = @ChildID

-- Remove any already assigned downline for this member
DELETE Downline WHERE ChildID = @AffiliateID

-- Get the Enroller's Title, status and enroller
SELECT @Title = Title, @Status = Status, @ReferralID = ReferralID FROM Member WHERE MemberID = @EnrollerID

--Find Upline Active Enroller
WHILE @Status <> 1
BEGIN
	SET @Status = 1
	SET @EnrollerID = @ReferralID
	SELECT @Title = Title, @Status = Status, @ReferralID = ReferralID FROM Member WHERE MemberID = @EnrollerID
END

-- Assign to Leadership Teams (D=6, DD=7, DDD=8)
SET @Team = 6
WHILE @Team <= 8
BEGIN
	SET @NewParentID = 0
--	-- If the enroller's title has the current team
	IF @Title >= @Team
		SET @NewParentID = @EnrollerID
	ELSE
		SELECT @NewParentID = ISNULL(ParentID,0) FROM Downline WHERE Line = @Team AND ChildID = @EnrollerID

	INSERT INTO Downline ( Line, ParentID, ChildID ) VALUES ( @Team, @NewParentID, @AffiliateID )

	SET @Team = @Team + 1
END

GO
