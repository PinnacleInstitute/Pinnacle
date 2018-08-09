EXEC [dbo].pts_CheckProc 'pts_Shortcut_Add'
 GO

CREATE PROCEDURE [dbo].pts_Shortcut_Add ( 
   @ShortcutID int OUTPUT,
   @AuthUserID int,
   @EntityID int,
   @ItemID int,
   @ShortcutName nvarchar (80),
   @URL nvarchar (100),
   @IsPinned bit,
   @IsPopup bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Shortcut (
            AuthUserID , 
            EntityID , 
            ItemID , 
            ShortcutName , 
            URL , 
            IsPinned , 
            IsPopup
            )
VALUES (
            @AuthUserID ,
            @EntityID ,
            @ItemID ,
            @ShortcutName ,
            @URL ,
            @IsPinned ,
            @IsPopup            )

SET @mNewID = @@IDENTITY

SET @ShortcutID = @mNewID

GO