EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_ListGroup
   @AssessmentID int ,
   @Grp int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asq.Grp, 
         asq.AssessmentID, 
         asq.AssessQuestionID, 
         asq.Question, 
         asq.Description, 
         asq.QuestionCode, 
         asq.Seq, 
         asq.QuestionType, 
         asq.MultiSelect, 
         asq.NextQuestion, 
         asq.RankMin, 
         asq.RankMax, 
         asq.NextType, 
         asq.CustomCode, 
         asq.MediaType, 
         asq.MediaFile
FROM AssessQuestion AS asq (NOLOCK)
WHERE (asq.AssessmentID = @AssessmentID)
 AND (asq.Grp = @Grp)
 AND (asq.Status <= 1)

ORDER BY   asq.Seq

GO