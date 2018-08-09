EXEC [dbo].pts_CheckProc 'pts_Event_Update'
GO

CREATE PROCEDURE [dbo].pts_Event_Update
   @EventID int,
   @OwnerType int,
   @OwnerID int,
   @EventName nvarchar (60),
   @EventDate datetime,
   @EventType int,
   @RemindDays int,
   @RemindDate datetime,
   @Recur int,
   @UserID int
AS

SET NOCOUNT ON

UPDATE ev
SET ev.OwnerType = @OwnerType ,
   ev.OwnerID = @OwnerID ,
   ev.EventName = @EventName ,
   ev.EventDate = @EventDate ,
   ev.EventType = @EventType ,
   ev.RemindDays = @RemindDays ,
   ev.RemindDate = @RemindDate ,
   ev.Recur = @Recur
FROM Event AS ev
WHERE (ev.EventID = @EventID)


EXEC pts_Event_SetRemindDate
   @EventID

GO