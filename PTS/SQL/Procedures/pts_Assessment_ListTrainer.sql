EXEC [dbo].pts_CheckProc 'pts_Assessment_ListTrainer'
GO

CREATE PROCEDURE [dbo].pts_Assessment_ListTrainer
   @TrainerID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      asm.AssessmentID, 
         asm.CompanyID, 
         asm.AssessmentName, 
         asm.Description, 
         asm.Status, 
         asm.IsTrial
FROM Assessment AS asm (NOLOCK)
WHERE (asm.TrainerID = @TrainerID)


GO