EXEC [dbo].pts_CheckProc 'pts_Downline_Build_13'
GO

--EXEC pts_Downline_Build_13 13, 0, 521
--select * from downline where childid=521

CREATE PROCEDURE [dbo].pts_Downline_Build_13
   @CompanyID int ,
   @ParentID int ,
   @ChildID int 
AS

-- Build the GFT Global Coded Teams
SET NOCOUNT ON

DECLARE @Title int, @Team int, @EnrollerID int, @AffiliateID int, @NewParentID int
SET @EnrollerID = @ParentID
SET @AffiliateID = @ChildID

-- Remove any already assigned downline for this member
DELETE Downline WHERE ChildID = @AffiliateID

-- Get the Enroller's Title
SELECT @Title = Title FROM Member WHERE MemberID = @EnrollerID

-- Assign to Leadership Teams (Emerald=5, Ruby=6, Diamond=7, Presidential=9, Ambassador=10, Global=11)
SET @Team = 5
WHILE @Team <= 11
BEGIN
--	Skip over Title #8 Blue Diamond has no coded team	
	IF @Team = 8 SET @Team = 9

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
