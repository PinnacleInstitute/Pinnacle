EXEC [dbo].pts_CheckProc 'pts_Event_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Event_Delete ( 
   @EventID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ev
FROM Event AS ev
WHERE ev.EventID = @EventID

GO