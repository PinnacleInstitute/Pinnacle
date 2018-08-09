EXEC [dbo].pts_CheckProc 'pts_AssessChoice_ListAssessment'
GO

CREATE PROCEDURE [dbo].pts_AssessChoice_ListAssessment
   @AssessmentID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asmc.AssessChoiceID, 
         asmc.AssessQuestionID, 
         asmc.Choice, 
         asmc.Seq, 
         asmc.Points, 
         asmc.NextQuestion, 
         asmc.Courses
FROM AssessChoice AS asmc (NOLOCK)
LEFT OUTER JOIN AssessQuestion AS asq (NOLOCK) ON (asmc.AssessQuestionID = asq.AssessQuestionID)
WHERE (asq.AssessmentID = @AssessmentID)

ORDER BY   asmc.Seq

GO