EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_LoadQuestionCode'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_LoadQuestionCode
   @AssessmentID int ,
   @QuestionCode int ,
   @AssessQuestionID int OUTPUT ,
   @NextGrp int OUTPUT ,
   @QuestionType int OUTPUT ,
   @Question nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

SELECT      @AssessQuestionID = asq.AssessQuestionID, 
         @NextGrp = asq.Grp, 
         @QuestionType = asq.QuestionType, 
         @Question = asq.Question
FROM AssessQuestion AS asq (NOLOCK)
WHERE (asq.AssessmentID = @AssessmentID)
 AND (asq.QuestionCode = @QuestionCode)


GO