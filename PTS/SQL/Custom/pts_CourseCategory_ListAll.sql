EXEC [dbo].pts_CheckProc 'pts_CourseCategory_ListAll'
GO
--EXEC pts_CourseCategory_ListAll 7,6528
CREATE PROCEDURE [dbo].pts_CourseCategory_ListAll
   @CompanyID int,
   @MemberID int
AS

SET         NOCOUNT ON

SELECT DISTINCT 
       0 - oo.OrgID AS CourseCategoryID, 
       0 - oo.ParentID AS ParentCategoryID, 
       oo.OrgName AS CourseCategoryName, 
       oo.CourseCount AS CourseCount, 
       -1 AS Seq
FROM (
	SELECT Org.OrgID, Org.ParentID, Org.OrgName, Org.CourseCount
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
) AS oo
UNION ALL
SELECT CourseCategoryID, 
       ParentCategoryID, 
       CourseCategoryName,
       CourseCount,
       Seq
FROM   CourseCategory (NOLOCK)
WHERE  CourseCount > 0

ORDER BY Seq

GO