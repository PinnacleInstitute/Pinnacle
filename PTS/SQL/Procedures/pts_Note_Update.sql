EXEC [dbo].pts_CheckProc 'pts_Note_Update'
 GO

CREATE PROCEDURE [dbo].pts_Note_Update ( 
   @NoteID int,
   @OwnerType int,
   @OwnerID int,
   @AuthUserID int,
   @NoteDate datetime,
   @Notes varchar (1000),
   @IsLocked bit,
   @IsFrozen bit,
   @IsReminder bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE nt
SET nt.OwnerType = @OwnerType ,
   nt.OwnerID = @OwnerID ,
   nt.AuthUserID = @AuthUserID ,
   nt.NoteDate = @NoteDate ,
   nt.Notes = @Notes ,
   nt.IsLocked = @IsLocked ,
   nt.IsFrozen = @IsFrozen ,
   nt.IsReminder = @IsReminder
FROM Note AS nt
WHERE nt.NoteID = @NoteID

GO