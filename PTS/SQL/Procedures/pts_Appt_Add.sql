EXEC [dbo].pts_CheckProc 'pts_Appt_Add'
 GO

CREATE PROCEDURE [dbo].pts_Appt_Add ( 
   @ApptID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Appt (
            CalendarID , 
            ApptName , 
            Location , 
            Note , 
            StartDate , 
            StartTime , 
            EndDate , 
            EndTime , 
            IsAllDay , 
            Status , 
            ApptType , 
            Importance , 
            Show , 
            Reminder , 
            RemindDate , 
            Recur , 
            RecurDate , 
            IsEdit , 
            IsPlan
            )
VALUES (
            @CalendarID ,
            @ApptName ,
            @Location ,
            @Note ,
            @StartDate ,
            @StartTime ,
            @EndDate ,
            @EndTime ,
            @IsAllDay ,
            @Status ,
            @ApptType ,
            @Importance ,
            @Show ,
            @Reminder ,
            @RemindDate ,
            @Recur ,
            @RecurDate ,
            @IsEdit ,
            @IsPlan            )

SET @mNewID = @@IDENTITY

SET @ApptID = @mNewID

GO