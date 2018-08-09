EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_LoadDefaultQuestion'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_LoadDefaultQuestion
   @AssessmentID int ,
   @Grp int ,
   @AssessQuestionID int OUTPUT ,
   @NextGrp int OUTPUT ,
   @QuestionType int OUTPUT ,
   @Question nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

SELECT TOP 1      @AssessQuestionID = asq.AssessQuestionID, 
         @NextGrp = asq.Grp, 
         @QuestionType = asq.QuestionType, 
         @Question = asq.Question
FROM AssessQuestion AS asq (NOLOCK)
WHERE (asq.AssessmentID = @AssessmentID)
 AND (asq.Grp > @Grp)

ORDER BY   asq.Grp , asq.Seq

SET @AssessQuestionID = ISNULL(@AssessQuestionID, 0)
GO