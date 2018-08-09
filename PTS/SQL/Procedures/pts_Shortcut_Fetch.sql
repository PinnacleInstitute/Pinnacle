EXEC [dbo].pts_CheckProc 'pts_Shortcut_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Shortcut_Fetch ( 
   @ShortcutID int,
   @AuthUserID int OUTPUT,
   @EntityID int OUTPUT,
   @ItemID int OUTPUT,
   @ShortcutName nvarchar (80) OUTPUT,
   @URL nvarchar (100) OUTPUT,
   @IsPinned bit OUTPUT,
   @IsPopup bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = sh.AuthUserID ,
   @EntityID = sh.EntityID ,
   @ItemID = sh.ItemID ,
   @ShortcutName = sh.ShortcutName ,
   @URL = sh.URL ,
   @IsPinned = sh.IsPinned ,
   @IsPopup = sh.IsPopup
FROM Shortcut AS sh (NOLOCK)
WHERE sh.ShortcutID = @ShortcutID

GO