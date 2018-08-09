EXEC [dbo].pts_CheckProc 'pts_CommPlan_Delete'
 GO

CREATE PROCEDURE [dbo].pts_CommPlan_Delete ( 
   @CommPlanID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cp
FROM CommPlan AS cp
WHERE cp.CommPlanID = @CommPlanID

GO