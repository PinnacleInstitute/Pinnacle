EXEC [dbo].pts_CheckProc 'pts_Machine_GetMemberID'
GO

CREATE PROCEDURE [dbo].pts_Machine_GetMemberID
   @MachineID int ,
   @MemberID int OUTPUT
AS

SET NOCOUNT ON

SELECT @MemberID = MemberID FROM Machine WHERE MachineID = @MachineID

GO

