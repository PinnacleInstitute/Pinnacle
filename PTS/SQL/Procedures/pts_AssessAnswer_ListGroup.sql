EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_ListGroup
   @MemberAssessID int ,
   @AssessmentID int ,
   @Grp int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asa.AssessAnswerID, 
         asa.AssessQuestionID, 
         asa.AssessChoiceID, 
         asa.Answer, 
         asa.AnswerDate, 
         asa.AnswerText, 
         asq.Discrimination AS 'Discrimination', 
         asq.Difficulty AS 'Difficulty', 
         asq.Guessing AS 'Guessing', 
         asq.UseCount AS 'UseCount'
FROM AssessAnswer AS asa (NOLOCK)
LEFT OUTER JOIN MemberAssess AS ma (NOLOCK) ON (asa.MemberAssessID = ma.MemberAssessID)
LEFT OUTER JOIN AssessQuestion AS asq (NOLOCK) ON (asa.AssessQuestionID = asq.AssessQuestionID)
WHERE (asa.MemberAssessID = @MemberAssessID)
 AND (asq.AssessmentID = @AssessmentID)
 AND (asq.Grp = @Grp)


GO