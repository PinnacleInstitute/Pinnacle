EXEC [dbo].pts_CheckProc 'pts_Machine_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Machine_Fetch ( 
   @MachineID int,
   @MemberID int OUTPUT,
   @MemberNameFirst nvarchar (30) OUTPUT,
   @MemberNameLast nvarchar (30) OUTPUT,
   @MemberEmail nvarchar (80) OUTPUT,
   @LiveDriveID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MachineName nvarchar (62) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Password nvarchar (20) OUTPUT,
   @WebName nvarchar (80) OUTPUT,
   @Status int OUTPUT,
   @Service int OUTPUT,
   @ActiveDate datetime OUTPUT,
   @CancelDate datetime OUTPUT,
   @RemoveDate datetime OUTPUT,
   @BackupUsed nvarchar (10) OUTPUT,
   @BackupCapacity nvarchar (10) OUTPUT,
   @BriefcaseUsed nvarchar (10) OUTPUT,
   @BriefcaseCapacity nvarchar (10) OUTPUT,
   @Qty int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = mc.MemberID ,
   @MemberNameFirst = me.NameFirst ,
   @MemberNameLast = me.NameLast ,
   @MemberEmail = me.Email ,
   @LiveDriveID = mc.LiveDriveID ,
   @NameLast = mc.NameLast ,
   @NameFirst = mc.NameFirst ,
   @MachineName = LTRIM(RTRIM(mc.NameLast)) +  ', '  + LTRIM(RTRIM(mc.NameFirst)) ,
   @Email = mc.Email ,
   @Password = mc.Password ,
   @WebName = mc.WebName ,
   @Status = mc.Status ,
   @Service = mc.Service ,
   @ActiveDate = mc.ActiveDate ,
   @CancelDate = mc.CancelDate ,
   @RemoveDate = mc.RemoveDate ,
   @BackupUsed = mc.BackupUsed ,
   @BackupCapacity = mc.BackupCapacity ,
   @BriefcaseUsed = mc.BriefcaseUsed ,
   @BriefcaseCapacity = mc.BriefcaseCapacity ,
   @Qty = mc.Qty
FROM Machine AS mc (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mc.MemberID = me.MemberID)
WHERE mc.MachineID = @MachineID

GO