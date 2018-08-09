EXEC [dbo].pts_CheckProc 'pts_Machine_FetchEmail'
GO

CREATE PROCEDURE [dbo].pts_Machine_FetchEmail
   @Email nvarchar (80) ,
   @MachineID int OUTPUT
AS

DECLARE @mMachineID int

SET NOCOUNT ON

SELECT      @mMachineID = mc.MachineID
FROM Machine AS mc (NOLOCK)
WHERE (mc.Email = @Email)


SET @MachineID = ISNULL(@mMachineID, 0)
GO