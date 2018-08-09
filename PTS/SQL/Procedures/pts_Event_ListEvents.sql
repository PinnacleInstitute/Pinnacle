EXEC [dbo].pts_CheckProc 'pts_Event_ListEvents'
GO

CREATE PROCEDURE [dbo].pts_Event_ListEvents
   @OwnerType int ,
   @OwnerID int
AS

SET NOCOUNT ON

SELECT      ev.EventID, 
         ev.EventName, 
         ev.EventDate, 
         ev.EventType, 
         ev.RemindDate
FROM Event AS ev (NOLOCK)
WHERE (ev.OwnerType = @OwnerType)
 AND (ev.OwnerID = @OwnerID)

ORDER BY   ev.RemindDate DESC

GO