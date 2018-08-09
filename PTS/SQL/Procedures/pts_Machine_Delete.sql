EXEC [dbo].pts_CheckProc 'pts_Machine_Delete'
GO

CREATE PROCEDURE [dbo].pts_Machine_Delete
   @MachineID int ,
   @UserID int
AS

DECLARE @mMemberID int, 
         @mResult int

SET NOCOUNT ON

EXEC pts_Machine_GetMemberID
   @MachineID ,
   @mMemberID OUTPUT

DELETE mc
FROM Machine AS mc
WHERE (mc.MachineID = @MachineID)


EXEC pts_Machine_SetCustomerPrice
   @mMemberID ,
   @mResult OUTPUT

GO