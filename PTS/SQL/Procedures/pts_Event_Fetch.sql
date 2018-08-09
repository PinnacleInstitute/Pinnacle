EXEC [dbo].pts_CheckProc 'pts_Event_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Event_Fetch ( 
   @EventID int,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @EventName nvarchar (60) OUTPUT,
   @EventDate datetime OUTPUT,
   @EventType int OUTPUT,
   @RemindDays int OUTPUT,
   @RemindDate datetime OUTPUT,
   @Recur int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @OwnerType = ev.OwnerType ,
   @OwnerID = ev.OwnerID ,
   @EventName = ev.EventName ,
   @EventDate = ev.EventDate ,
   @EventType = ev.EventType ,
   @RemindDays = ev.RemindDays ,
   @RemindDate = ev.RemindDate ,
   @Recur = ev.Recur
FROM Event AS ev (NOLOCK)
WHERE ev.EventID = @EventID

GO