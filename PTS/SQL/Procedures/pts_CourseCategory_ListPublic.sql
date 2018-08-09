EXEC [dbo].pts_CheckProc 'pts_CourseCategory_ListPublic'
GO

CREATE PROCEDURE [dbo].pts_CourseCategory_ListPublic
   @UserID int
AS

SET NOCOUNT ON

SELECT      cc.CourseCategoryID, 
         cc.ParentCategoryID, 
         cc.CourseCategoryName, 
         cc.CourseCount
FROM CourseCategory AS cc (NOLOCK)
ORDER BY   cc.Seq

GO