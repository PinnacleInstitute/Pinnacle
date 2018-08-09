EXEC [dbo].pts_CheckProc 'pts_Shortcut_DeleteItem'
GO

CREATE PROCEDURE [dbo].pts_Shortcut_DeleteItem
   @EntityID int ,
   @ItemID int
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

DELETE sh
FROM Shortcut AS sh
WHERE (sh.EntityID = @EntityID)
 AND (sh.ItemID = @ItemID)


GO