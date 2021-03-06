EXEC [dbo].pts_CheckProc 'pts_Machine_ListAll'
GO

CREATE PROCEDURE [dbo].pts_Machine_ListAll
   @MemberID int
AS

SET NOCOUNT ON

SELECT      mc.MachineID, 
         mc.MemberID, 
         mc.LiveDriveID, 
         mc.NameFirst, 
         mc.NameLast, 
         mc.Email, 
         mc.Password, 
         mc.WebName, 
         mc.Status, 
         mc.Service, 
         mc.ActiveDate, 
         mc.CancelDate, 
         mc.RemoveDate, 
         mc.BackupUsed, 
         mc.BackupCapacity, 
         mc.BriefcaseUsed, 
         mc.BriefcaseCapacity, 
         mc.Qty
FROM Machine AS mc (NOLOCK)
WHERE (mc.MemberID = @MemberID)

ORDER BY   mc.Status , mc.NameLast , mc.NameFirst

GO