EXEC [dbo].pts_CheckProc 'pts_Org_Delete'
GO

CREATE PROCEDURE [dbo].pts_Org_Delete
   @OrgID int ,
   @UserID int
AS

DECLARE @mAuthUserID int, @mBoardUserID int, @mForumModeratorID int, @mForumID int
DECLARE @CompanyID int, @Hierarchy varchar(100)

SET NOCOUNT ON

SET @mForumModeratorID = 0

SELECT @mAuthUserID = AuthUserID, @mForumID = ForumID, @CompanyID = CompanyID, @Hierarchy = Hierarchy
FROM Org WHERE OrgID = @OrgID

IF @mAuthUserID > 0 
BEGIN
	EXEC pts_AuthUser_Delete @mAuthUserID, @UserID

--	EXEC pts_BoardUser_GetBoardUser @mAuthUserID, @mBoardUserID OUTPUT

--	IF @mBoardUserID > 0 
--		EXEC pts_BoardUser_Delete @mBoardUserID, @UserID
END

--IF @mForumID > 0
--BEGIN 
--	EXEC pts_Forum_Delete @mForumID, @UserID
--
--	EXEC pts_ForumModerator_GetForumModerator @mForumID, @mBoardUserID, @UserID, @mForumModeratorID OUTPUT
--
--	IF @mForumModeratorID > 0
--	   EXEC pts_ForumModerator_Delete @mForumModeratorID, @UserID
--END

IF @CompanyID > 0
BEGIN
	IF @Hierarchy <> ''
	BEGIN
		DELETE FROM OrgMember WHERE OrgID IN ( 
			SELECT OrgID FROM Org WHERE CompanyID = @CompanyID AND Hierarchy LIKE @Hierarchy + '%' )

		DELETE FROM OrgCourse WHERE OrgID IN ( 
			SELECT OrgID FROM Org WHERE CompanyID = @CompanyID AND Hierarchy LIKE @Hierarchy + '%' )

		DELETE FROM Org WHERE CompanyID = @CompanyID AND Hierarchy LIKE @Hierarchy + '%'
		EXEC pts_Company_Update_Counters @CompanyID
	END
	ELSE
	BEGIN
		DELETE FROM Org WHERE OrgID = @OrgID
	END
END

GO