EXEC [dbo].pts_CheckProc 'pts_Forum_ListUserForum'
GO

CREATE PROCEDURE [dbo].pts_Forum_ListUserForum
   @BoardUserID int ,
   @UserID int
AS

SET         NOCOUNT ON

DECLARE @CompanyID int, @MemberID int

SET @MemberID = (SELECT me.MemberID 
		FROM BoardUser AS bo
		LEFT OUTER JOIN Member AS me ON (me.AuthUserID = bo.AuthUserID) 
		WHERE BoardUserID = @BoardUserID
	)

SET @CompanyID = (SELECT CompanyID FROM Member WHERE MemberID = @MemberID)

-- Org Header
SELECT -1 AS 'ForumID',
	'' AS 'ForumName',
	'' AS 'Description'

UNION ALL

-- Get Org Forums
SELECT      mbf.ForumID, 
         mbf.ForumName, 
         mbf.Description
FROM Org (NOLOCK)
LEFT OUTER JOIN Forum AS mbf ON (mbf.ForumID = Org.ForumID)
WHERE Org.ForumID > 0
AND OrgID IN (
	SELECT Org.OrgID
	FROM Org
	LEFT OUTER JOIN (
		SELECT Org.OrgID, Org.Hierarchy
		FROM OrgMember
		JOIN Org ON (OrgMember.OrgID = Org.OrgID)
		WHERE Org.PrivateID = Org.OrgID
		AND OrgMember.MemberID = @MemberID
	) AS private ON (private.OrgID = Org.PrivateID)
	WHERE Org.CompanyID = @CompanyID
	AND (Org.Status = 2 OR Org.Status = 3)
	AND (Org.PrivateID = 0 OR Org.Hierarchy LIKE private.Hierarchy + '%')
)

UNION ALL

-- CourseCategory Header
SELECT -2 AS 'ForumID',
	'' AS 'ForumName',
	'' AS 'Description'

UNION ALL

-- Get CourseCategory Forums
SELECT      mbf.ForumID, 
         mbf.ForumName, 
         mbf.Description
FROM CourseCategory AS cc (NOLOCK)
LEFT OUTER JOIN Forum AS mbf ON (mbf.ForumID = cc.ForumID)
WHERE cc.ForumID > 0
AND CourseCategoryID IN (
	SELECT DISTINCT cq.CourseCategoryID FROM (
		SELECT se.SessionID, co.CourseCategoryID
		FROM Session AS se (NOLOCK)
		LEFT OUTER JOIN Course AS co ON (co.CourseID = se.CourseID)
		WHERE se.MemberID = @MemberID
	) AS cq
)

GO