EXEC [dbo].pts_CheckProc 'pts_AssessChoice_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_AssessChoice_ListGroup
   @AssessmentID int ,
   @Grp int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asmc.AssessChoiceID, 
         asmc.AssessQuestionID, 
         asmc.Choice, 
         asmc.Points, 
         asmc.NextQuestion
FROM AssessChoice AS asmc (NOLOCK)
LEFT OUTER JOIN AssessQuestion AS asq (NOLOCK) ON (asmc.AssessQuestionID = asq.AssessQuestionID)
WHERE (asq.AssessmentID = @AssessmentID)
 AND (asq.Grp = @Grp)
 AND (asq.Status <= 1)

ORDER BY   asmc.Seq

GO