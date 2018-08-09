EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_ListAssessment'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_ListAssessment
   @AssessmentID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asq.AssessQuestionID, 
         asq.AssessmentID, 
         asq.QuestionCode, 
         asq.Question, 
         asq.Description, 
         asq.Grp, 
         asq.Seq, 
         asq.QuestionType, 
         asq.RankMin, 
         asq.RankMax, 
         asq.ResultType, 
         asq.Answer, 
         asq.Points, 
         asq.NextType, 
         asq.NextQuestion, 
         asq.Formula, 
         asq.CustomCode, 
         asq.MultiSelect, 
         asq.MediaType, 
         asq.MediaFile, 
         asq.Courses, 
         asq.Status
FROM AssessQuestion AS asq (NOLOCK)
WHERE (asq.AssessmentID = @AssessmentID)

ORDER BY   asq.Grp , asq.Seq

GO