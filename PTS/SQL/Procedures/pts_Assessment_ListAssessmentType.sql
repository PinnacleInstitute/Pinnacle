EXEC [dbo].pts_CheckProc 'pts_Assessment_ListAssessmentType'
GO

CREATE PROCEDURE [dbo].pts_Assessment_ListAssessmentType
   @CompanyID int ,
   @AssessType int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asm.AssessmentID, 
         asm.AssessmentName, 
         asm.AssessmentType, 
         asm.Description, 
         asm.AssessDate, 
         asm.CompanyID, 
         asm.Takes, 
         asm.Delay, 
         asm.IsCertify
FROM Assessment AS asm (NOLOCK)
WHERE (asm.Status = 2)
 AND (asm.AssessType = @AssessType)
 AND ((asm.CompanyID = 0)
 OR (asm.CompanyID = @CompanyID))

ORDER BY   asm.CompanyID DESC , asm.Rating DESC , asm.AssessmentName

GO