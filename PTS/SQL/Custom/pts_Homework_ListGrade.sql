EXEC [dbo].pts_CheckProc 'pts_Homework_ListGrade'
GO

--EXEC pts_Homework_ListGrade 747

CREATE PROCEDURE [dbo].pts_Homework_ListGrade
   @CourseID int
AS

SET NOCOUNT ON

SELECT  att.AttachmentID 'HomeworkID',
        le.LessonName 'Name', 
        hw.Name 'Description' 
FROM Attachment AS att (NOLOCK)
JOIN Homework AS hw ON att.RefID = hw.HomeworkID
JOIN SessionLesson AS sl ON att.ParentID = sl.SessionLessonID 
JOIN Lesson AS le ON sl.LessonID = le.LessonID 
WHERE att.ParentType = 24
AND le.CourseID = @CourseID
AND hw.IsGrade <> 0
AND att.Score = 0

ORDER BY le.Seq, att.AttachDate

GO


