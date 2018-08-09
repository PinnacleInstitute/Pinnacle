EXEC [dbo].pts_CheckProc 'pts_CourseCategory_ListPrivate'
GO

CREATE PROCEDURE [dbo].pts_CourseCategory_ListPrivate
   @CompanyID int,
   @MemberID int
AS

SET         NOCOUNT ON

SELECT
	0 - Org.OrgID AS CourseCategoryID, 
	0 - Org.ParentID AS ParentCategoryID, 
	Org.OrgName AS CourseCategoryName,
	Org.CourseCount AS CourseCount
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
AND (Org.CourseCount > 0)
GO
