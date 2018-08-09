EXEC [dbo].pts_CheckProc 'pts_Machine_Update'
GO

CREATE PROCEDURE [dbo].pts_Machine_Update
   @MachineID int,
   @MemberID int,
   @LiveDriveID int,
   @NameLast nvarchar (30),
   @NameFirst nvarchar (30),
   @Email nvarchar (80),
   @Password nvarchar (20),
   @WebName nvarchar (80),
   @Status int,
   @Service int,
   @ActiveDate datetime,
   @CancelDate datetime,
   @RemoveDate datetime,
   @BackupUsed nvarchar (10),
   @BackupCapacity nvarchar (10),
   @BriefcaseUsed nvarchar (10),
   @BriefcaseCapacity nvarchar (10),
   @Qty int,
   @UserID int
AS

DECLARE @mNow datetime, 
         @mResult int

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE mc
SET mc.MemberID = @MemberID ,
   mc.LiveDriveID = @LiveDriveID ,
   mc.NameLast = @NameLast ,
   mc.NameFirst = @NameFirst ,
   mc.Email = @Email ,
   mc.Password = @Password ,
   mc.WebName = @WebName ,
   mc.Status = @Status ,
   mc.Service = @Service ,
   mc.ActiveDate = @ActiveDate ,
   mc.CancelDate = @CancelDate ,
   mc.RemoveDate = @RemoveDate ,
   mc.BackupUsed = @BackupUsed ,
   mc.BackupCapacity = @BackupCapacity ,
   mc.BriefcaseUsed = @BriefcaseUsed ,
   mc.BriefcaseCapacity = @BriefcaseCapacity ,
   mc.Qty = @Qty
FROM Machine AS mc
WHERE (mc.MachineID = @MachineID)


EXEC pts_Machine_SetCustomerPrice
   @MemberID ,
   @mResult OUTPUT

GO