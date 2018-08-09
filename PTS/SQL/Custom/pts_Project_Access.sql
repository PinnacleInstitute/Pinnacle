EXEC [dbo].pts_CheckProc 'pts_Project_Access'
GO
-- Check if the member can access the specified project via security level
-- or by owning or belonging to it or any parent project
CREATE PROCEDURE [dbo].pts_Project_Access
   @ProjectID int ,
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DECLARE @ProjectSecure int, @OwnerID int, @MemberSecure int, @ParentID int, @Options varchar (20)

SET @Result = 0

-- Get the Project Owner and Security Level
SELECT @OwnerID = MemberID, @ParentID = ParentID, @ProjectSecure = Secure FROM Project WHERE ProjectID = @ProjectID

-- Check if the Member is the Owner
IF @OwnerID = @MemberID	SET @Result = 1

-- Check if the Member has security level access 
IF @Result = 0
BEGIN
	SELECT @Options = Options, @MemberSecure = Secure FROM Member WHERE MemberID = @MemberID
	IF ((CHARINDEX('f', @Options, 1) > 0) AND @MemberSecure >= @ProjectSecure) SET @Result = 1
END

-- Check if the Member belongs to the Project 
IF @Result = 0
	SELECT @Result = COUNT(*) FROM ProjectMember WHERE ProjectID = @ProjectID AND MemberID = @MemberID

-- Check the parent projects
WHILE @Result = 0 AND @ParentID > 0
BEGIN
--	Get the next parent Project ID, Owner and parent
	SELECT @ProjectID = ProjectID, @OwnerID = MemberID, @ParentID = ParentID FROM Project WHERE ProjectID = @ParentID

--	Check if the Member is the Owner
	IF @OwnerID = @MemberID	SET @Result = 1

-- 	Check if the Member belongs to the Project 
	IF @Result = 0
		SELECT @Result = COUNT(*) FROM ProjectMember WHERE ProjectID = @ProjectID AND MemberID = @MemberID
END

GO
