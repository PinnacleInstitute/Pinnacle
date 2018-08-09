EXEC [dbo].pts_CheckProc 'pts_AssessChoice_ListAssessQuestion'
GO

CREATE PROCEDURE [dbo].pts_AssessChoice_ListAssessQuestion
   @AssessQuestionID int ,
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
WHERE (asmc.AssessQuestionID = @AssessQuestionID)

ORDER BY   asmc.Seq

GO