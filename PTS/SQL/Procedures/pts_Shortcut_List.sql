EXEC [dbo].pts_CheckProc 'pts_Shortcut_List'
GO

CREATE PROCEDURE [dbo].pts_Shortcut_List
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

ORDER BY   sh.IsPinned DESC , sh.EntityID , sh.ShortcutName

GO