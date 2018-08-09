EXEC [dbo].pts_CheckProc 'pts_Appt_Update'
 GO

CREATE PROCEDURE [dbo].pts_Appt_Update ( 
   @ApptID int,
   @CalendarID int,
   @ApptName nvarchar (60),
   @Location nvarchar (80),
   @Note nvarchar (500),
   @StartDate datetime,
   @StartTime varchar (8),
   @EndDate datetime,
   @EndTime varchar (8),
   @IsAllDay bit,
   @Status int,
   @ApptType int,
   @Importance int,
   @Show int,
   @Reminder int,
   @RemindDate datetime,
   @Recur int,
   @RecurDate datetime,
   @IsEdit bit,
   @IsPlan bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE app
SET app.CalendarID = @CalendarID ,
   app.ApptName = @ApptName ,
   app.Location = @Location ,
   app.Note = @Note ,
   app.StartDate = @StartDate ,
   app.StartTime = @StartTime ,
   app.EndDate = @EndDate ,
   app.EndTime = @EndTime ,
   app.IsAllDay = @IsAllDay ,
   app.Status = @Status ,
   app.ApptType = @ApptType ,
   app.Importance = @Importance ,
   app.Show = @Show ,
   app.Reminder = @Reminder ,
   app.RemindDate = @RemindDate ,
   app.Recur = @Recur ,
   app.RecurDate = @RecurDate ,
   app.IsEdit = @IsEdit ,
   app.IsPlan = @IsPlan
FROM Appt AS app
WHERE app.ApptID = @ApptID

GO