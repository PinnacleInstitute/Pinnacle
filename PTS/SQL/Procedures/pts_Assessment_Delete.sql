EXEC [dbo].pts_CheckProc 'pts_Assessment_Delete'
GO

CREATE PROCEDURE [dbo].pts_Assessment_Delete
   @AssessmentID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   31 ,
   @AssessmentID

DELETE asm
FROM Assessment AS asm
WHERE (asm.AssessmentID = @AssessmentID)


GO