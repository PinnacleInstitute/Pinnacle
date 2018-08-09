EXEC [dbo].pts_CheckProc 'pts_CommPlan_List'
GO

CREATE PROCEDURE [dbo].pts_CommPlan_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      cp.CommPlanID, 
         cp.CommPlanName, 
         cp.CommPlanNo
FROM CommPlan AS cp (NOLOCK)
WHERE (cp.CompanyID = @CompanyID)

ORDER BY   cp.CommPlanNo

GO