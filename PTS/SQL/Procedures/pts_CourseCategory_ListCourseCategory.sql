EXEC [dbo].pts_CheckProc 'pts_CourseCategory_ListCourseCategory'
GO

CREATE PROCEDURE [dbo].pts_CourseCategory_ListCourseCategory
   @ParentCategoryID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      cc.CourseCategoryID, 
         cc.CourseCategoryName
FROM CourseCategory AS cc (NOLOCK)
WHERE (cc.ParentCategoryID = @ParentCategoryID)

ORDER BY   cc.Seq

GO