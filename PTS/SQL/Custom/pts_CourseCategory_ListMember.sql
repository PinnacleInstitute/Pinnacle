EXEC [dbo].pts_CheckProc 'pts_CourseCategory_ListMember'
GO

CREATE PROCEDURE [dbo].pts_CourseCategory_ListMember
   @MemberID int  
AS

SET         NOCOUNT ON

SELECT DISTINCT 
       cc.CourseCategoryID, 
       cc.CourseCategoryName,
       cc.ForumID
FROM CourseCategory AS cc
JOIN Course AS co ON cc.CourseCategoryID = co.CourseCategoryID
JOIN Session AS se ON co.CourseID = se.CourseID
WHERE se.MemberID = @MemberID
AND se.IsInactive = 0
ORDER BY CourseCategoryName

GO