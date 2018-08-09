EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_NextCATQuestion'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_NextCATQuestion
   @MemberAssessID int,
   @Difficulty decimal(10, 8),
   @AssessQuestionID int OUTPUT
AS

SET         NOCOUNT ON

DECLARE @Order decimal

SELECT TOP 1 @AssessQuestionID = AssessQuestionID
FROM 
(SELECT TOP 20 asq.AssessQuestionID AS 'AssessQuestionID',
	ABS(@Difficulty - asq.Difficulty) AS 'Diff'
FROM MemberAssess AS asm
LEFT OUTER JOIN AssessQuestion AS asq ON (asm.AssessmentID = asq.AssessmentID) 
LEFT OUTER JOIN AssessAnswer AS asa ON (asa.MemberAssessID = @MemberAssessID AND asa.AssessQuestionID = asq.AssessQuestionID)
WHERE asm.MemberAssessID = 1
AND asa.AssessAnswerID IS NULL
AND ABS(@Difficulty - asq.Difficulty) <= .5
ORDER BY 'Diff' ASC) AS tmp
ORDER BY NewID()

GO