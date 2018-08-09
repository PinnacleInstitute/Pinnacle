EXEC [dbo].pts_CheckProc 'pts_Event_Add'
GO

CREATE PROCEDURE [dbo].pts_Event_Add
   @EventID int OUTPUT,
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

DECLARE @mNewID int

SET NOCOUNT ON

INSERT INTO Event (
            OwnerType , 
            OwnerID , 
            EventName , 
            EventDate , 
            EventType , 
            RemindDays , 
            RemindDate , 
            Recur

            )
VALUES (
            @OwnerType ,
            @OwnerID ,
            @EventName ,
            @EventDate ,
            @EventType ,
            @RemindDays ,
            @RemindDate ,
            @Recur
            )

SET @mNewID = @@IDENTITY
SET @EventID = @mNewID
EXEC pts_Event_SetRemindDate
   @EventID

GO