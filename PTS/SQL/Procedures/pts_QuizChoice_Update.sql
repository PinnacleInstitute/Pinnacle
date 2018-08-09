EXEC [dbo].pts_CheckProc 'pts_QuizChoice_Update'
 GO

CREATE PROCEDURE [dbo].pts_QuizChoice_Update ( 
   @QuizChoiceID int,
   @QuizQuestionID int,
   @QuizChoiceText nvarchar (1000),
   @Seq int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE qc
SET qc.QuizQuestionID = @QuizQuestionID ,
   qc.QuizChoiceText = @QuizChoiceText ,
   qc.Seq = @Seq
FROM QuizChoice AS qc
WHERE qc.QuizChoiceID = @QuizChoiceID

GO