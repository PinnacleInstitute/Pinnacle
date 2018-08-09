EXEC [dbo].pts_CheckProc 'pts_Homework_ListAttachment'
GO

CREATE PROCEDURE [dbo].pts_Homework_ListAttachment
   @SessionLessonID int
AS

SET NOCOUNT ON

SELECT  hw.HomeworkID, 
	    ISNULL(att.AttachmentID,0) 'AttachmentID',
        hw.Name, 
        hw.Description, 
        hw.Seq, 
        hw.Weight, 
        hw.IsGrade,
	    ISNULL(att.Score,0) 'Score'
FROM Homework AS hw (NOLOCK)
LEFT OUTER JOIN SessionLesson AS sl ON hw.LessonID = sl.LessonID 
LEFT OUTER JOIN Attachment AS att ON att.ParentType = 24 AND att.ParentID = sl.SessionLessonID AND att.RefID = hw.HomeworkID
WHERE sl.SessionLessonID = @SessionLessonID
ORDER BY   hw.Seq

GO