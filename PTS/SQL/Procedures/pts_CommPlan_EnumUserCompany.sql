EXEC [dbo].pts_CheckProc 'pts_CommPlan_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_CommPlan_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      cp.CommPlanID AS 'ID', 
         cp.CommPlanName AS 'Name'
FROM CommPlan AS cp (NOLOCK)
WHERE (cp.CompanyID = @CompanyID)

ORDER BY   cp.CommPlanNo

GO