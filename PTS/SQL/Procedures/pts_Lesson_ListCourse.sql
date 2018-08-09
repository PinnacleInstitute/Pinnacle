EXEC [dbo].pts_CheckProc 'pts_Lesson_ListCourse'
GO

CREATE PROCEDURE [dbo].pts_Lesson_ListCourse
   @CourseID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      le.LessonID, 
         le.CourseID, 
         le.LessonName, 
         le.Description, 
         le.Seq, 
         le.Status, 
         le.LessonLength, 
         le.MediaType, 
         le.Quiz, 
         le.IsPassQuiz
FROM Lesson AS le (NOLOCK)
LEFT OUTER JOIN Course AS cs (NOLOCK) ON (le.CourseID = cs.CourseID)
WHERE (le.CourseID = @CourseID)

ORDER BY   le.Seq

GO