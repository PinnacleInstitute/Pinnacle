EXEC [dbo].pts_CheckProc 'pts_CommPlan_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_CommPlan_Fetch ( 
   @CommPlanID int,
   @CompanyID int OUTPUT,
   @CommPlanName nvarchar (40) OUTPUT,
   @CommPlanNo int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = cp.CompanyID ,
   @CommPlanName = cp.CommPlanName ,
   @CommPlanNo = cp.CommPlanNo
FROM CommPlan AS cp (NOLOCK)
WHERE cp.CommPlanID = @CommPlanID

GO