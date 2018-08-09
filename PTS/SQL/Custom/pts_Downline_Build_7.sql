EXEC [dbo].pts_CheckProc 'pts_Downline_Build_7'
GO

--EXEC pts_Downline_Build_7 7, 87103, 87095

CREATE PROCEDURE [dbo].pts_Downline_Build_7
   @CompanyID int ,
   @ParentID int ,
   @ChildID int 
AS

-- Build the WRN Coded Leadership Teams
SET NOCOUNT ON

DECLARE @Title int, @Team int, @ReferralID int
SET @Team = 0

-- Remove any already assigned downline for this member
DELETE Downline WHERE ChildID = @ChildID

-- Build all 3 leadership teams, walk up the enrollers
WHILE @ParentID > 0 AND @Team < 3
BEGIN
	SELECT @Title = Title, @ReferralID = ReferralID FROM Member WHERE MemberID = @ParentID
	
--	-- Add to Manager Team
	IF @Team < 1 
	BEGIN
		IF @Title >= 2
		BEGIN
			SET @Team = 1
			INSERT INTO Downline ( Line, ParentID, ChildID ) VALUES ( @Team, @ParentID, @ChildID )
		END
	END
--	-- Add to Director Team
	IF @Team < 2 
	BEGIN
		IF @Title >= 3
		BEGIN
			SET @Team = 2
			INSERT INTO Downline ( Line, ParentID, ChildID ) VALUES ( @Team, @ParentID, @ChildID )
		END
	END
--	-- Add to Executive Team
	IF @Team < 3 
	BEGIN
		IF @Title >= 4
		BEGIN
			SET @Team = 3
			INSERT INTO Downline ( Line, ParentID, ChildID ) VALUES ( @Team, @ParentID, @ChildID )
		END
	END

	SET @ParentID = @ReferralID

END


GO
