EXEC [dbo].pts_CheckProc 'pts_Event_DeleteOwner'
GO

CREATE PROCEDURE [dbo].pts_Event_DeleteOwner
   @OwnerType int ,
   @OwnerID int
AS

SET NOCOUNT ON

DELETE ev
FROM Event AS ev
WHERE (ev.OwnerType = @OwnerType)
 AND (ev.OwnerID = @OwnerID)


GO