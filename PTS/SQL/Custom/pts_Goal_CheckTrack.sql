EXEC [dbo].pts_CheckProc 'pts_Goal_CheckTrack'
GO

CREATE PROCEDURE [dbo].pts_Goal_CheckTrack
   @ParentID int ,   
   @MemberID int ,
   @GoalID int OUTPUT
AS

SET NOCOUNT ON

DECLARE @TrackID int, @mGoalID int, @GoalName nvarchar(60), @Template int

SET @TrackID = @ParentID
SET @GoalID = 0

-- Get the name of the desired goal
SELECT @GoalName = GoalName, @Template = Template FROM Goal WHERE GoalID = @TrackID

-- Check to see if the member already has a goal with the same name
IF @GoalName != ''
BEGIN
	SELECT TOP 1 @mGoalID = GoalID FROM Goal (NOLOCK)
	WHERE MemberID = @MemberID AND ParentID = 0 AND GoalName = @GoalName AND Template = 0
	ORDER BY CreateDate DESC

	SET @GoalID = ISNULL(@mGoalID, 0)

-- 	-- If the member does not have the goal, check if they belong to a group that has a goal with the same name
	IF @GoalID = 0
	BEGIN
		DECLARE @GroupID int
		SELECT @GroupID = GroupID FROM Member WHERE MemberID = @MemberID
--		-- If the member belongs to a group, the group # is the member # owning the track

		IF @GroupID = 1
		BEGIN
--			-- Lookup the Group Member for the goal template with the same name and template type as the requested track
			SET @MemberID = @GroupID
			SELECT TOP 1 @mGoalID = GoalID FROM Goal (NOLOCK)
			WHERE MemberID = @MemberID AND Template = @Template AND GoalName = @GoalName
			ORDER BY CreateDate DESC
		
			SET @GoalID = ISNULL(@mGoalID, 0)
--			-- IF the member's group has a goal with the same name, return it negated
			IF @GoalID > 0 SET @GoalID = @GoalID * -1
		END
	END

END

GO