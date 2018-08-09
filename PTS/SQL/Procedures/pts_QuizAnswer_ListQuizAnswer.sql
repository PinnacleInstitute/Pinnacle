EXEC [dbo].pts_CheckProc 'pts_QuizAnswer_ListQuizAnswer'
GO

CREATE PROCEDURE [dbo].pts_QuizAnswer_ListQuizAnswer
   @SessionLessonID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qa.QuizAnswerID, 
         qa.QuizQuestionID, 
         qa.QuizChoiceID, 
         qa.IsCorrect, 
         qq.Question AS 'Question', 
         qq.Explain AS 'Explain', 
         qc.QuizChoiceText AS 'QuizChoiceText'
FROM QuizAnswer AS qa (NOLOCK)
LEFT OUTER JOIN QuizQuestion AS qq (NOLOCK) ON (qa.QuizQuestionID = qq.QuizQuestionID)
LEFT OUTER JOIN QuizChoice AS qc (NOLOCK) ON (qa.QuizChoiceID = qc.QuizChoiceID)
WHERE (qa.SessionLessonID = @SessionLessonID)


GO