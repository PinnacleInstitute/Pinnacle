EXEC [dbo].pts_CheckProc 'pts_Shortcut_Update'
 GO

CREATE PROCEDURE [dbo].pts_Shortcut_Update ( 
   @ShortcutID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sh
SET sh.AuthUserID = @AuthUserID ,
   sh.EntityID = @EntityID ,
   sh.ItemID = @ItemID ,
   sh.ShortcutName = @ShortcutName ,
   sh.URL = @URL ,
   sh.IsPinned = @IsPinned ,
   sh.IsPopup = @IsPopup
FROM Shortcut AS sh
WHERE sh.ShortcutID = @ShortcutID

GO