EXEC [dbo].pts_CheckProc 'pts_MemberAssess_ListAssessmentAll'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_ListAssessmentAll
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ma.MemberID, 
         ma.MemberAssessID, 
         ma.StartDate, 
         ma.CompleteDate, 
         ma.Status, 
         ma.ExternalID, 
         ma.Result, 
         ma.Score, 
         ma.AssessmentID, 
         asm.AssessmentName AS 'AssessmentName', 
         asm.IsCertify AS 'IsCertify', 
         asm.NoCertificate AS 'NoCertificate', 
         asm.IsCustomCertificate AS 'IsCustomCertificate', 
         me.CompanyID AS 'CompanyID', 
         ma.IsPrivate, 
         ma.IsRemoved
FROM MemberAssess AS ma (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (ma.MemberID = me.MemberID)
LEFT OUTER JOIN Assessment AS asm (NOLOCK) ON (ma.AssessmentID = asm.AssessmentID)
WHERE (ma.MemberID = @MemberID)


GO