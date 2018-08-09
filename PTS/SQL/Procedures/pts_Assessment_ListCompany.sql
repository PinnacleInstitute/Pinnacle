EXEC [dbo].pts_CheckProc 'pts_Assessment_ListCompany'
GO

CREATE PROCEDURE [dbo].pts_Assessment_ListCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asm.AssessmentID, 
         asm.TrainerID, 
         asm.CompanyID, 
         asm.AssessmentName, 
         asm.Description, 
         asm.Status, 
         asm.IsTrial
FROM Assessment AS asm (NOLOCK)
WHERE (asm.Status = 2)
 AND ((asm.CompanyID = @CompanyID)
 OR (asm.CompanyID = 0))

ORDER BY   asm.CompanyID DESC , asm.AssessmentName

GO