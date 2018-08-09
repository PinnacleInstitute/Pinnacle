EXEC [dbo].pts_CheckProc 'pts_Message_CanUserDelete'
GO

CREATE PROCEDURE [dbo].pts_Message_CanUserDelete
   @MessageID int ,
   @BoardUserID int ,   
   @UserID int ,
   @CanDelete bit OUTPUT

AS

SET NOCOUNT ON

DECLARE @ForumID int, @ForumModeratorID int, @BoardUserGroup int

SET @BoardUserGroup = (	SELECT BoardUserGroup FROM BoardUser WHERE BoardUserID = @BoardUserID )

IF @BoardUserGroup = 2
BEGIN
	SET @ForumID = (
		SELECT ForumID
		FROM Message
		WHERE MessageID = @MessageID)

	EXEC pts_ForumModerator_GetForumModerator @ForumID, 
		@BoardUserID, 
		@UserID,
		@ForumModeratorID OUTPUT

	IF @ForumModeratorID > 0
	BEGIN
		SET @CanDelete = 1
	END
	ELSE
	BEGIN
		SET @CanDelete = 0
	END
END
ELSE IF @BoardUserGroup = 3 
	SET @CanDelete = 1
ELSE 
	SET @CanDelete = 0

GO
