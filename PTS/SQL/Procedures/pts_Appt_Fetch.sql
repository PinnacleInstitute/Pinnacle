EXEC [dbo].pts_CheckProc 'pts_Appt_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Appt_Fetch ( 
   @ApptID int,
   @CalendarID int OUTPUT,
   @ApptName nvarchar (60) OUTPUT,
   @Location nvarchar (80) OUTPUT,
   @Note nvarchar (500) OUTPUT,
   @StartDate datetime OUTPUT,
   @StartTime varchar (8) OUTPUT,
   @EndDate datetime OUTPUT,
   @EndTime varchar (8) OUTPUT,
   @IsAllDay bit OUTPUT,
   @Status int OUTPUT,
   @ApptType int OUTPUT,
   @Importance int OUTPUT,
   @Show int OUTPUT,
   @Reminder int OUTPUT,
   @RemindDate datetime OUTPUT,
   @Recur int OUTPUT,
   @RecurDate datetime OUTPUT,
   @IsEdit bit OUTPUT,
   @IsPlan bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CalendarID = app.CalendarID ,
   @ApptName = app.ApptName ,
   @Location = app.Location ,
   @Note = app.Note ,
   @StartDate = app.StartDate ,
   @StartTime = app.StartTime ,
   @EndDate = app.EndDate ,
   @EndTime = app.EndTime ,
   @IsAllDay = app.IsAllDay ,
   @Status = app.Status ,
   @ApptType = app.ApptType ,
   @Importance = app.Importance ,
   @Show = app.Show ,
   @Reminder = app.Reminder ,
   @RemindDate = app.RemindDate ,
   @Recur = app.Recur ,
   @RecurDate = app.RecurDate ,
   @IsEdit = app.IsEdit ,
   @IsPlan = app.IsPlan
FROM Appt AS app (NOLOCK)
WHERE app.ApptID = @ApptID

GO