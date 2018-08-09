EXEC [dbo].pts_CheckProc 'pts_SessionLesson_ListSession'
GO

--EXEC pts_SessionLesson_ListSession 6, 2069, '', 0

CREATE PROCEDURE [dbo].pts_SessionLesson_ListSession
   @CourseID int ,
   @SessionID int ,
   @Description nvarchar (1000) ,
   @UserID int
AS

SET NOCOUNT ON

SELECT  le.seq AS 'Seq',
		le.LessonID AS 'SessionLessonID', 
		le.LessonID As 'LessonID',
        le.LessonName AS 'LessonName', 
        le.Description AS 'Description', 
        le.Content AS 'Content', 
        le.Quiz AS 'Quiz', 
        le.MediaType AS 'MediaType',
        le.MediaURL AS 'MediaURL',
        le.LessonLength AS 'LessonLength',
        le.PassingGrade AS 'PassingGrade',
        le.QuizWeight AS 'QuizWeight',
        le.IsPassQuiz AS 'IsPassQuiz',
        ISNULL(sl.QuizScore, 0) AS 'QuizScore', 
        ISNULL(sl.Status, 0) AS 'Status',
        ISNULL(sl.Time, 0) AS 'Time',
        ISNULL(sl.Times, 0) AS 'Times'
FROM    SessionLesson AS sl (NOLOCK)
        RIGHT JOIN Lesson AS le (NOLOCK) ON (sl.LessonID = le.LessonID) AND sl.SessionID = @SessionID
WHERE   (le.CourseID = @CourseID) 
AND		le.Status = 2
AND     ( @Description = '' OR  @Description LIKE '%,' + CONVERT(nvarchar(10), le.seq) + ',%'  )

ORDER BY le.seq

GO
