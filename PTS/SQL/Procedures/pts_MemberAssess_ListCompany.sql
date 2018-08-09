EXEC [dbo].pts_CheckProc 'pts_MemberAssess_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_ListCompany
   @AssessmentID int ,
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      ma.MemberID, 
         ma.MemberAssessID, 
         ma.CompleteDate, 
         ma.Result, 
         me.CompanyName AS 'MemberName', 
         me.CompanyID AS 'CompanyID'
FROM MemberAssess AS ma (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (ma.MemberID = me.MemberID)
LEFT OUTER JOIN Assessment AS asm (NOLOCK) ON (ma.AssessmentID = asm.AssessmentID)
WHERE (ma.AssessmentID = @AssessmentID)
 AND (me.CompanyID = @CompanyID)
 AND (ma.IsPrivate = 0)
 AND (ma.CompleteDate <> 0)

ORDER BY   ma.CompleteDate DESC

GO