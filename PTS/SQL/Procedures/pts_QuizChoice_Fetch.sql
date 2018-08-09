EXEC [dbo].pts_CheckProc 'pts_QuizChoice_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_QuizChoice_Fetch ( 
   @QuizChoiceID int,
   @QuizQuestionID int OUTPUT,
   @QuizChoiceText nvarchar (1000) OUTPUT,
   @Seq int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @QuizQuestionID = qc.QuizQuestionID ,
   @QuizChoiceText = qc.QuizChoiceText ,
   @Seq = qc.Seq
FROM QuizChoice AS qc (NOLOCK)
WHERE qc.QuizChoiceID = @QuizChoiceID

GO