EXEC [dbo].pts_CheckProc 'pts_SessionLesson_ListQuiz'
GO

--EXEC pts_SessionLesson_ListQuiz 6, 2069

CREATE PROCEDURE [dbo].pts_SessionLesson_ListQuiz
   @CourseID int,
   @SessionID int 
AS

SET NOCOUNT ON

SELECT  le.LessonID AS 'SessionLessonID', 
        le.LessonName AS 'LessonName', 
        le.PassingGrade AS 'PassingGrade',
        le.QuizWeight AS 'QuizWeight',
        ISNULL(sl.QuizScore, 0) AS 'QuizScore', 
        ISNULL(sl.Status, 0) AS 'Status'
FROM    SessionLesson AS sl (NOLOCK)
        RIGHT OUTER JOIN Lesson AS le (NOLOCK) ON sl.LessonID = le.LessonID AND sl.SessionID = @SessionID
WHERE   le.CourseID = @CourseID
AND	le.Status = 2
AND	le.Quiz > 1

ORDER BY le.seq

GO
