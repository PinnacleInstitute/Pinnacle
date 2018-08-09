EXEC [dbo].pts_CheckProc 'pts_Prospect_Delete'
GO

CREATE PROCEDURE [dbo].pts_Prospect_Delete
   @ProspectID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   81 ,
   @ProspectID

EXEC pts_Event_DeleteOwner
   81 ,
   @ProspectID

DELETE pr
FROM Prospect AS pr
WHERE (pr.ProspectID = @ProspectID)


GO