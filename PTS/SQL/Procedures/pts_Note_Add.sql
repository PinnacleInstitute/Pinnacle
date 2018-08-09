EXEC [dbo].pts_CheckProc 'pts_Note_Add'
 GO

CREATE PROCEDURE [dbo].pts_Note_Add ( 
   @NoteID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Note (
            OwnerType , 
            OwnerID , 
            AuthUserID , 
            NoteDate , 
            Notes , 
            IsLocked , 
            IsFrozen , 
            IsReminder
            )
VALUES (
            @OwnerType ,
            @OwnerID ,
            @AuthUserID ,
            @NoteDate ,
            @Notes ,
            @IsLocked ,
            @IsFrozen ,
            @IsReminder            )

SET @mNewID = @@IDENTITY

SET @NoteID = @mNewID

GO