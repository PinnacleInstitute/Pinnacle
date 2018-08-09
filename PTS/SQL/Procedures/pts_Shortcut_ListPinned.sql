EXEC [dbo].pts_CheckProc 'pts_Shortcut_ListPinned'
GO

CREATE PROCEDURE [dbo].pts_Shortcut_ListPinned
   @AuthUserID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sh.ShortcutID, 
         sh.EntityID, 
         sh.ShortcutName, 
         sh.URL, 
         sh.IsPinned, 
         sh.IsPopup
FROM Shortcut AS sh (NOLOCK)
WHERE (sh.AuthUserID = @AuthUserID)
 AND (sh.IsPinned <> 0)

ORDER BY   sh.EntityID , sh.ShortcutName

GO