EXEC [dbo].pts_CheckProc 'pts_OrgCourse_DeleteCourses'
GO

CREATE PROCEDURE [dbo].pts_OrgCourse_DeleteCourses
   @CourseID int ,
   @UserID int
AS

DECLARE @mID int

SET NOCOUNT ON
--Delete orgcourse with same courseid


DECLARE OrgCourse_cursor CURSOR FOR 
SELECT  OrgCourseID  FROM OrgCourse
WHERE   CourseID = @CourseID ORDER BY [OrgID] DESC

OPEN OrgCourse_cursor
FETCH NEXT FROM OrgCourse_cursor INTO @mID

WHILE @@FETCH_STATUS = 0
BEGIN

EXEC pts_OrgCourse_Delete @mID,@UserID

FETCH NEXT FROM OrgCourse_cursor INTO @mID

END

CLOSE OrgCourse_cursor
DEALLOCATE OrgCourse_cursor


GO