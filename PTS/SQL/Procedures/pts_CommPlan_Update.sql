EXEC [dbo].pts_CheckProc 'pts_CommPlan_Update'
 GO

CREATE PROCEDURE [dbo].pts_CommPlan_Update ( 
   @CommPlanID int,
   @CompanyID int,
   @CommPlanName nvarchar (40),
   @CommPlanNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cp
SET cp.CompanyID = @CompanyID ,
   cp.CommPlanName = @CommPlanName ,
   cp.CommPlanNo = @CommPlanNo
FROM CommPlan AS cp
WHERE cp.CommPlanID = @CommPlanID

GO