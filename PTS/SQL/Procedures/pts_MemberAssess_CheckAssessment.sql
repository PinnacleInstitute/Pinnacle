EXEC [dbo].pts_CheckProc 'pts_MemberAssess_CheckAssessment'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_CheckAssessment
   @AssessmentID int ,
   @MemberID int ,
   @UserID int ,
   @MemberAssessID int OUTPUT
AS

DECLARE @mMemberAssessID int

SET NOCOUNT ON

SELECT      @mMemberAssessID = ma.MemberAssessID
FROM MemberAssess AS ma (NOLOCK)
WHERE (ma.AssessmentID = @AssessmentID)
 AND (ma.MemberID = @MemberID)
 AND (ma.IsRemoved = 0)


SET @MemberAssessID = ISNULL(@mMemberAssessID, 0)
GO