EXEC [dbo].pts_CheckProc 'pts_Shortcut_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Shortcut_Delete ( 
   @ShortcutID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sh
FROM Shortcut AS sh
WHERE sh.ShortcutID = @ShortcutID

GO