EXEC [dbo].pts_CheckProc 'pts_DripTarget_Delete'
 GO

CREATE PROCEDURE [dbo].pts_DripTarget_Delete ( 
   @DripTargetID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE det
FROM DripTarget AS det
WHERE det.DripTargetID = @DripTargetID

GO