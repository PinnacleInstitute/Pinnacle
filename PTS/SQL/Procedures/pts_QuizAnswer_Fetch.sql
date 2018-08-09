EXEC [dbo].pts_CheckProc 'pts_QuizAnswer_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_QuizAnswer_Fetch ( 
   @QuizAnswerID int,
   @SessionLessonID int OUTPUT,
   @QuizQuestionID int OUTPUT,
   @QuizChoiceID int OUTPUT,
   @Question nvarchar (2000) OUTPUT,
   @Explain nvarchar (1000) OUTPUT,
   @QuizChoiceText nvarchar (1000) OUTPUT,
   @IsCorrect bit OUTPUT,
   @CreateDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SessionLessonID = qa.SessionLessonID ,
   @QuizQuestionID = qa.QuizQuestionID ,
   @QuizChoiceID = qa.QuizChoiceID ,
   @Question = qq.Question ,
   @Explain = qq.Explain ,
   @QuizChoiceText = qc.QuizChoiceText ,
   @IsCorrect = qa.IsCorrect ,
   @CreateDate = qa.CreateDate
FROM QuizAnswer AS qa (NOLOCK)
LEFT OUTER JOIN QuizQuestion AS qq (NOLOCK) ON (qa.QuizQuestionID = qq.QuizQuestionID)
LEFT OUTER JOIN QuizChoice AS qc (NOLOCK) ON (qa.QuizChoiceID = qc.QuizChoiceID)
WHERE qa.QuizAnswerID = @QuizAnswerID

GO