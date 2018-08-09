EXEC [dbo].pts_CheckProc 'pts_AssessAnswer_ListAnswers'
GO

CREATE PROCEDURE [dbo].pts_AssessAnswer_ListAnswers
   @MemberAssessID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asa.AssessAnswerID, 
         asa.AssessQuestionID, 
         asa.AssessChoiceID, 
         asa.Answer, 
         asa.AnswerDate, 
         asa.AnswerText
FROM AssessAnswer AS asa (NOLOCK)
WHERE (asa.MemberAssessID = @MemberAssessID)


GO