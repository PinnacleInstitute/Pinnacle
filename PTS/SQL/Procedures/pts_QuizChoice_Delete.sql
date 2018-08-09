EXEC [dbo].pts_CheckProc 'pts_QuizChoice_Delete'
 GO

CREATE PROCEDURE [dbo].pts_QuizChoice_Delete ( 
   @QuizChoiceID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE qc
FROM QuizChoice AS qc
WHERE qc.QuizChoiceID = @QuizChoiceID

GO