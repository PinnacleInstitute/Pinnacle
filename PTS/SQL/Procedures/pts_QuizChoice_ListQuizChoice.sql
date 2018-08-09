EXEC [dbo].pts_CheckProc 'pts_QuizChoice_ListQuizChoice'
GO

CREATE PROCEDURE [dbo].pts_QuizChoice_ListQuizChoice
   @QuizQuestionID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qc.QuizChoiceID, 
         qc.QuizChoiceText, 
         qc.Seq
FROM QuizChoice AS qc (NOLOCK)
WHERE (qc.QuizQuestionID = @QuizQuestionID)

ORDER BY   qc.Seq

GO