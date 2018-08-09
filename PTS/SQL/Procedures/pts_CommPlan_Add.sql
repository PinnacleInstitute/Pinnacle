EXEC [dbo].pts_CheckProc 'pts_CommPlan_Add'
 GO

CREATE PROCEDURE [dbo].pts_CommPlan_Add ( 
   @CommPlanID int OUTPUT,
   @CompanyID int,
   @CommPlanName nvarchar (40),
   @CommPlanNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO CommPlan (
            CompanyID , 
            CommPlanName , 
            CommPlanNo
            )
VALUES (
            @CompanyID ,
            @CommPlanName ,
            @CommPlanNo            )

SET @mNewID = @@IDENTITY

SET @CommPlanID = @mNewID

GO