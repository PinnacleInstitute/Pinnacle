EXEC [dbo].pts_CheckProc 'pts_Event_ListReminder'
GO

CREATE PROCEDURE [dbo].pts_Event_ListReminder
   @RemindDate datetime
AS

SET NOCOUNT ON

SELECT ev.EventID, ev.OwnerType, ev.OwnerID, ev.EventName, ev.EventDate,
       ev.EventType, me.Email, me.MemberID, me.IsMsg, pr.ProspectName 'OwnerName'
FROM Event AS ev (NOLOCK)
JOIN Prospect AS pr ON ev.OwnerType = 81 AND ev.OwnerID = pr.ProspectID  
JOIN Member AS me ON pr.MemberID = me.MemberID
WHERE ev.OwnerType = 81 AND ev.RemindDate != 0 AND  ev.RemindDate <= @RemindDate

GO
