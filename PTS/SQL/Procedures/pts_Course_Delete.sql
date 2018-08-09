EXEC [dbo].pts_CheckProc 'pts_Course_Delete'
GO

CREATE PROCEDURE [dbo].pts_Course_Delete
   @CourseID int ,
   @UserID int
AS

DECLARE @mCourseCategoryID int

SET NOCOUNT ON

SET @mCourseCategoryID = (SELECT CourseCategoryID FROM Course WHERE CourseID = @CourseID)
EXEC pts_Shortcut_DeleteItem
   11 ,
   @CourseID

EXEC pts_Course_DeleteFT
   @CourseID

IF ((@mCourseCategoryID > 0))
   BEGIN
   EXEC pts_CourseCategory_Update_Counters
      @mCourseCategoryID

   END

DELETE cs
FROM Course AS cs
WHERE (cs.CourseID = @CourseID)


EXEC pts_OrgCourse_DeleteCourses
   @CourseID ,
   @UserID

GO