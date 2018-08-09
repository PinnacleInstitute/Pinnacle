EXEC [dbo].pts_CheckProc 'pts_Downline_Build_5'
GO

--EXEC pts_Downline_Build_5 5, 0, 521
--select * from downline where childid=521

CREATE PROCEDURE [dbo].pts_Downline_Build_5
   @CompanyID int ,
   @ParentID int ,
   @ChildID int 
AS

-- Build the CloudZow Coded Leadership Teams
SET NOCOUNT ON

DECLARE @Title int, @Team int, @EnrollerID int, @AffiliateID int, @NewParentID int
SET @EnrollerID = @ParentID
SET @AffiliateID = @ChildID

-- Remove any already assigned downline for this member
DELETE Downline WHERE ChildID = @AffiliateID

-- Get the Enroller's Title
SELECT @Title = Title-2 FROM Member WHERE MemberID = @EnrollerID

-- Assign to Leadership Teams (Manager=2, Director=3, Executive=4
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
