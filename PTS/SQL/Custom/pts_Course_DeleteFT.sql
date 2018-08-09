EXEC [dbo].pts_CheckProc 'pts_Course_DeleteFT'
GO

CREATE PROCEDURE [dbo].pts_Course_DeleteFT
   @CourseID int
AS

DELETE CourseFT WHERE CourseID = @CourseID

GO