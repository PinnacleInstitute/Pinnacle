EXEC [dbo].pts_CheckProc 'pts_QuizChoice_EnumUserQuizChoice'
GO

CREATE PROCEDURE [dbo].pts_QuizChoice_EnumUserQuizChoice
   @QuizQuestionID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      qc.QuizChoiceID AS 'ID', 
         qc.QuizChoiceText AS 'Name'
FROM QuizChoice AS qc (NOLOCK)
WHERE (qc.QuizQuestionID = @QuizQuestionID)

ORDER BY   qc.Seq

GO