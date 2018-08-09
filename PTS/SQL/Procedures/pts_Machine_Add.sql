EXEC [dbo].pts_CheckProc 'pts_Machine_Add'
GO

CREATE PROCEDURE [dbo].pts_Machine_Add
   @MachineID int OUTPUT,
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
         @mNewID int, 
         @mResult int

SET NOCOUNT ON

SET @mNow = GETDATE()
INSERT INTO Machine (
            MemberID , 
            LiveDriveID , 
            NameLast , 
            NameFirst , 
            Email , 
            Password , 
            WebName , 
            Status , 
            Service , 
            ActiveDate , 
            CancelDate , 
            RemoveDate , 
            BackupUsed , 
            BackupCapacity , 
            BriefcaseUsed , 
            BriefcaseCapacity , 
            Qty

            )
VALUES (
            @MemberID ,
            @LiveDriveID ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @Password ,
            @WebName ,
            @Status ,
            @Service ,
            @ActiveDate ,
            @CancelDate ,
            @RemoveDate ,
            @BackupUsed ,
            @BackupCapacity ,
            @BriefcaseUsed ,
            @BriefcaseCapacity ,
            @Qty
            )

SET @mNewID = @@IDENTITY
SET @MachineID = @mNewID
EXEC pts_Machine_SetCustomerPrice
   @MemberID ,
   @mResult OUTPUT

GO