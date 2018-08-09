EXEC [dbo].pts_CheckProc 'pts_Homework_ListSession'
GO

--EXEC pts_Homework_ListSession 2064

CREATE PROCEDURE [dbo].pts_Homework_ListSession
   @SessionID int
AS

SET NOCOUNT ON

SELECT  hw.HomeworkID, 
	ISNULL(att.AttachmentID,0) 'AttachmentID',
        hw.Name 'Name', 
        le.LessonName 'Description', 
        hw.Seq, 
        hw.Weight, 
        hw.IsGrade,
	ISNULL(att.Score,0) 'Score'
FROM Homework AS hw (NOLOCK)
LEFT OUTER JOIN SessionLesson AS sl ON hw.LessonID = sl.LessonID 
LEFT OUTER JOIN Session AS se ON sl.SessionID = se.SessionID 
LEFT OUTER JOIN Lesson AS le ON sl.LessonID = le.LessonID 
LEFT OUTER JOIN Attachment AS att ON att.ParentType = 24 AND att.ParentID = sl.SessionLessonID AND att.RefID = hw.HomeworkID
WHERE se.SessionID = @SessionID
ORDER BY le.Seq, hw.Seq

GO

