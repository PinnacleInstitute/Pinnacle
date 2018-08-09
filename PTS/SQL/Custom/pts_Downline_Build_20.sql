EXEC [dbo].pts_CheckProc 'pts_Downline_Build_20'
GO

--EXEC pts_Downline_Build_20 20, 8168, 8169
--select * from downline where childid=521

CREATE PROCEDURE [dbo].pts_Downline_Build_20
   @CompanyID int ,
   @ParentID int ,
   @ChildID int 
AS

-- Build the Coded Teams
SET NOCOUNT ON

DECLARE @Title int, @Team int, @EnrollerID int, @AffiliateID int, @NewParentID int
SET @EnrollerID = @ParentID
SET @AffiliateID = @ChildID

-- Remove any already assigned downline for this member
DELETE Downline WHERE ChildID = @AffiliateID

-- Get the Enroller's Title
SELECT @Title = Title FROM Member WHERE MemberID = @EnrollerID

-- Assign to Leadership Teams (M=2, C=3, H=4)
SET @Team = 2
WHILE @Team <= 4
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
