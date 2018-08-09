EXEC [dbo].pts_CheckProc 'pts_Assessment_EnumCompany'
GO

CREATE PROCEDURE [dbo].pts_Assessment_EnumCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asm.AssessmentID AS 'ID', 
         asm.AssessmentName AS 'Name'
FROM Assessment AS asm (NOLOCK)
WHERE (asm.Status = 2)
 AND (asm.IsCertify = 1)
 AND ((asm.CompanyID = @CompanyID)
 OR (asm.CompanyID = 0))

ORDER BY   asm.CompanyID DESC , asm.AssessmentName

GO