EXEC [dbo].pts_CheckProc 'pts_AssessQuestion_CATGroupCorrectCount'
GO

CREATE PROCEDURE [dbo].pts_AssessQuestion_CATGroupCorrectCount
   @AssessQuestionID int,
   @GroupMin decimal(10,8),
   @GroupMax decimal(10,8),
   @UseCount int OUTPUT
AS

SET         NOCOUNT ON

SELECT @UseCount = ISNULL(COUNT(*), 0)
FROM AssessAnswer AS aa (NOLOCK)
LEFT OUTER JOIN MemberAssess AS ma ON (ma.MemberAssessID = aa.MemberAssessID)
WHERE (ma.Score BETWEEN @GroupMin AND @GroupMax)
AND (aa.AssessQuestionID = @AssessQuestionID)
AND (aa.Answer <> 0)

GO